# Context Manager 深度分析

> 上下文管理层完整架构设计

**文档版本：** 1.0  
**最后更新：** 2026-04-01  
**阅读对象：** 后端工程师、AI 工程师

---

## 🎯 核心职责

**Context Manager** 是 Claude Code 的记忆系统，负责：
- ✅ 管理对话上下文
- ✅ Token 智能管理
- ✅ 相关性检索
- ✅ 历史压缩
- ✅ 会话恢复

---

## 🏗️ 架构设计

### 上下文分层

```
┌─────────────────────────────────────────┐
│     Short-term Context (短期上下文)     │
│  - 当前对话                              │
│  - 最近消息                              │
│  - 临时变量                              │
└─────────────────────────────────────────┘
                    ↓
┌─────────────────────────────────────────┐
│     Long-term Context (长期上下文)      │
│  - 历史对话                              │
│  - 用户偏好                              │
│  - 项目知识                              │
└─────────────────────────────────────────┘
                    ↓
┌─────────────────────────────────────────┐
│     External Context (外部上下文)       │
│  - 代码库                                │
│  - 文档                                  │
│  - 外部 API                              │
└─────────────────────────────────────────┘
```

---

## 📝 核心接口定义

### ContextManager 接口

```typescript
/**
 * 上下文管理器接口
 */
interface ContextManager {
  /**
   * 添加消息到上下文
   */
  addMessage(role: Role, content: string): void;
  
  /**
   * 压缩上下文（超出 Token 限制时）
   */
  compressContext(maxTokens: number): void;
  
  /**
   * 获取相关上下文
   */
  getRelevantContext(query: string): Context;
  
  /**
   * 清除上下文
   */
  clearContext(): void;
  
  /**
   * 获取当前 Token 使用量
   */
  getTokenCount(): number;
  
  /**
   * 导出上下文
   */
  exportContext(): ExportedContext;
  
  /**
   * 导入上下文
   */
  importContext(context: ExportedContext): void;
}
```

---

## 🔍 Token 管理实现

### Token 计算器

```typescript
/**
 * Token 管理器
 */
class TokenManager {
  private maxTokens: number = 100000; // Claude 3 的上下文限制
  private currentTokens: number = 0;
  
  /**
   * 计算文本的 Token 数
   */
  countTokens(text: string): number {
    // 简单估算：4 个字符≈1 个 token
    // 实际应该使用 tiktoken 或其他 tokenizer
    return Math.ceil(text.length / 4);
  }
  
  /**
   * 添加消息并更新 Token 计数
   */
  addMessage(role: Role, content: string): boolean {
    const tokens = this.countTokens(content);
    
    if (this.currentTokens + tokens > this.maxTokens) {
      // 超出限制，需要压缩
      this.compressContext(this.maxTokens * 0.8);
    }
    
    this.currentTokens += tokens;
    return true;
  }
  
  /**
   * 获取当前 Token 使用率
   */
  getUsageRate(): number {
    return this.currentTokens / this.maxTokens;
  }
  
  /**
   * 获取剩余 Token 数
   */
  getRemainingTokens(): number {
    return this.maxTokens - this.currentTokens;
  }
}
```

---

## 📚 上下文压缩算法

### 压缩策略

```typescript
/**
 * 上下文压缩器
 */
class ContextCompressor {
  
  /**
   * 压缩上下文到指定 Token 数
   */
  compress(context: Context, maxTokens: number): Context {
    const messages = context.messages;
    let currentTokens = this.countTotalTokens(messages);
    
    if (currentTokens <= maxTokens) {
      return context;
    }
    
    // 压缩策略 1: 删除最早的消息
    while (currentTokens > maxTokens && messages.length > 1) {
      const removed = messages.shift()!;
      currentTokens -= this.countTokens(removed.content);
    }
    
    // 压缩策略 2: 压缩长消息
    for (const message of messages) {
      if (currentTokens <= maxTokens) break;
      
      const originalTokens = this.countTokens(message.content);
      message.content = this.summarize(message.content);
      const newTokens = this.countTokens(message.content);
      currentTokens -= (originalTokens - newTokens);
    }
    
    // 压缩策略 3: 删除低优先级消息
    const lowPriority = messages.filter(m => m.priority === 'low');
    for (const message of lowPriority) {
      if (currentTokens <= maxTokens) break;
      const index = messages.indexOf(message);
      messages.splice(index, 1);
      currentTokens -= this.countTokens(message.content);
    }
    
    return { ...context, messages };
  }
  
  /**
   * 摘要长消息
   */
  private summarize(text: string): string {
    // 简单实现：只保留前 500 个字符
    // 实际应该使用 AI 摘要
    if (text.length <= 500) return text;
    return text.substring(0, 500) + '... [compressed]';
  }
}
```

---

## 🔎 相关性检索

### 检索实现

```typescript
/**
 * 上下文检索器
 */
class ContextRetriever {
  private index: MessageIndex = new MessageIndex();
  
  /**
   * 获取相关上下文
   */
  getRelevantContext(query: string, maxMessages: number = 10): Context {
    // 1. 关键词匹配
    const keywordMatches = this.index.searchByKeywords(query);
    
    // 2. 语义相似度匹配
    const semanticMatches = this.index.searchBySemantic(query);
    
    // 3. 时间衰减
    const timeDecayedMatches = this.applyTimeDecay(keywordMatches);
    
    // 4. 合并结果
    const combined = this.mergeResults([
      keywordMatches,
      semanticMatches,
      timeDecayedMatches
    ]);
    
    // 5. 排序并返回 Top N
    const sorted = combined.sort((a, b) => b.score - a.score);
    const topN = sorted.slice(0, maxMessages);
    
    return {
      messages: topN.map(m => m.message),
      query,
      timestamp: Date.now()
    };
  }
  
  /**
   * 应用时间衰减
   */
  private applyTimeDecay(matches: MatchResult[]): MatchResult[] {
    const now = Date.now();
    const halfLife = 30 * 60 * 1000; // 30 分钟半衰期
    
    return matches.map(match => {
      const age = now - match.message.timestamp;
      const decay = Math.exp(-age / halfLife);
      return {
        ...match,
        score: match.score * decay
      };
    });
  }
}
```

---

## 💾 持久化实现

### 上下文存储

```typescript
/**
 * 上下文持久化
 */
class ContextStorage {
  private storagePath: string;
  
  constructor(storagePath: string) {
    this.storagePath = storagePath;
  }
  
  /**
   * 保存上下文
   */
  async save(context: Context): Promise<void> {
    const exported = this.exportContext(context);
    const json = JSON.stringify(exported, null, 2);
    
    await fs.promises.writeFile(
      this.storagePath,
      json,
      { encoding: 'utf-8' }
    );
  }
  
  /**
   * 加载上下文
   */
  async load(): Promise<Context> {
    try {
      const json = await fs.promises.readFile(
        this.storagePath,
        { encoding: 'utf-8' }
      );
      
      const exported = JSON.parse(json);
      return this.importContext(exported);
    } catch (error) {
      // 文件不存在，返回空上下文
      return { messages: [] };
    }
  }
  
  /**
   * 导出上下文
   */
  private exportContext(context: Context): ExportedContext {
    return {
      version: '1.0',
      messages: context.messages.map(msg => ({
        role: msg.role,
        content: msg.content,
        timestamp: msg.timestamp,
        metadata: msg.metadata
      })),
      metadata: {
        createdAt: Date.now(),
        messageCount: context.messages.length
      }
    };
  }
  
  /**
   * 导入上下文
   */
  private importContext(exported: ExportedContext): Context {
    return {
      messages: exported.messages.map(msg => ({
        id: this.generateId(),
        role: msg.role,
        content: msg.content,
        timestamp: msg.timestamp,
        metadata: msg.metadata || {}
      }))
    };
  }
  
  private generateId(): string {
    return `${Date.now()}-${Math.random().toString(36).substr(2, 9)}`;
  }
}
```

---

## 📊 性能优化

### 1. 增量索引

```typescript
/**
 * 消息索引（增量更新）
 */
class MessageIndex {
  private index: Map<string, Set<number>> = new Map();
  
  /**
   * 添加消息到索引
   */
  addMessage(message: Message): void {
    const words = this.tokenize(message.content);
    
    for (const word of words) {
      if (!this.index.has(word)) {
        this.index.set(word, new Set());
      }
      this.index.get(word)!.add(message.id);
    }
  }
  
  /**
   * 搜索关键词
   */
  searchByKeywords(query: string): MatchResult[] {
    const words = this.tokenize(query);
    const messageScores = new Map<number, number>();
    
    for (const word of words) {
      const messageIds = this.index.get(word) || new Set();
      for (const id of messageIds) {
        messageScores.set(
          id,
          (messageScores.get(id) || 0) + 1
        );
      }
    }
    
    return Array.from(messageScores.entries())
      .map(([id, score]) => ({ id, score }));
  }
}
```

---

## 🔗 相关文档

- [00-overview.md](./00-overview.md) - 架构总览
- [01-agent-core.md](./01-agent-core.md) - Agent 核心
- [02-tool-system.md](./02-tool-system.md) - 工具系统

---

**文档持续迭代中...** 🚀

**最后更新：** 2026-04-01  
**维护者：** 池少团队
