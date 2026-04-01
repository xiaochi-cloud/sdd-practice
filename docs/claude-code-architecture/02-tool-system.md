# Tool System 深度分析

> 工具系统层完整架构设计

**文档版本：** 1.0  
**最后更新：** 2026-04-01  
**阅读对象：** 后端工程师、系统架构师

---

## 🎯 核心职责

**Tool System** 是 Claude Code 的双手，负责：
- ✅ 提供统一的工具接口
- ✅ 注册和管理所有工具
- ✅ 执行具体操作
- ✅ 权限和安全控制

---

## 🏗️ 架构设计

### 工具分层

```
┌─────────────────────────────────────────┐
│         Tool Registry                   │
│      (工具注册中心)                      │
│  - 工具注册                              │
│  - 工具发现                              │
│  - 工具路由                              │
└─────────────────────────────────────────┘
                    ↓
┌─────────────────────────────────────────┐
│         Tool Interface                  │
│      (统一工具接口)                      │
│  - execute()                             │
│  - validate()                            │
│  - getDescription()                      │
└─────────────────────────────────────────┘
                    ↓
┌─────────────────────────────────────────┐
│    Built-in Tools    Custom Tools       │
│    (内置工具)        (自定义工具)        │
│  - ReadFile           - Plugin A         │
│  - WriteFile          - Plugin B         │
│  - RunCommand         - Plugin C         │
│  - Git                - ...              │
└─────────────────────────────────────────┘
```

---

## 📝 核心接口定义

### Tool 接口

```typescript
/**
 * 工具接口
 * 
 * 所有工具必须实现此接口
 */
interface Tool {
  /** 工具名称（唯一标识） */
  name: string;
  
  /** 工具描述 */
  description: string;
  
  /** 参数 Schema（用于验证） */
  parameters: ParameterSchema;
  
  /**
   * 执行工具
   * 
   * @param context - 执行上下文
   * @param args - 工具参数
   * @returns 执行结果
   */
  execute(context: Context, args: Record<string, any>): Promise<ToolResult>;
  
  /**
   * 验证参数
   * 
   * @param args - 待验证的参数
   * @returns 验证结果
   */
  validate(args: Record<string, any>): ValidationResult;
  
  /** 获取工具描述信息 */
  getDescription(): ToolDescription;
}
```

### ToolResult 接口

```typescript
/**
 * 工具执行结果
 */
interface ToolResult {
  /** 是否成功 */
  success: boolean;
  
  /** 输出内容 */
  output: string;
  
  /** 错误信息（失败时） */
  errors?: string[];
  
  /** 执行时间（毫秒） */
  executionTime?: number;
  
  /** 附加数据 */
  data?: any;
}
```

---

## 🛠️ 内置工具实现

### 1. ReadFile 工具

```typescript
/**
 * 读取文件工具
 */
class ReadFileTool implements Tool {
  name = 'ReadFile';
  description = '读取文件内容';
  
  parameters = {
    type: 'object',
    properties: {
      path: {
        type: 'string',
        description: '文件路径'
      },
      encoding: {
        type: 'string',
        description: '文件编码',
        default: 'utf-8'
      }
    },
    required: ['path']
  };
  
  async execute(context: Context, args: Record<string, any>): Promise<ToolResult> {
    const startTime = Date.now();
    
    try {
      const { path, encoding = 'utf-8' } = args;
      
      // 验证路径
      if (!path || typeof path !== 'string') {
        throw new Error('Invalid file path');
      }
      
      // 读取文件
      const content = await fs.promises.readFile(path, { encoding });
      
      return {
        success: true,
        output: content,
        executionTime: Date.now() - startTime,
        data: {
          path,
          size: content.length,
          lines: content.split('\n').length
        }
      };
    } catch (error) {
      return {
        success: false,
        output: '',
        errors: [error instanceof Error ? error.message : String(error)],
        executionTime: Date.now() - startTime
      };
    }
  }
  
  validate(args: Record<string, any>): ValidationResult {
    if (!args.path) {
      return { valid: false, error: 'path is required' };
    }
    return { valid: true };
  }
  
  getDescription(): ToolDescription {
    return {
      name: this.name,
      description: this.description,
      parameters: this.parameters
    };
  }
}
```

### 2. WriteFile 工具

```typescript
/**
 * 写入文件工具
 */
class WriteFileTool implements Tool {
  name = 'WriteFile';
  description = '写入文件内容';
  
  parameters = {
    type: 'object',
    properties: {
      path: { type: 'string', description: '文件路径' },
      content: { type: 'string', description: '文件内容' },
      encoding: { type: 'string', description: '编码', default: 'utf-8' },
      append: { type: 'boolean', description: '是否追加', default: false }
    },
    required: ['path', 'content']
  };
  
  async execute(context: Context, args: Record<string, any>): Promise<ToolResult> {
    const startTime = Date.now();
    
    try {
      const { path, content, encoding = 'utf-8', append = false } = args;
      
      // 验证参数
      if (!path || !content) {
        throw new Error('path and content are required');
      }
      
      // 确保目录存在
      await fs.promises.mkdir(path.dirname(path), { recursive: true });
      
      // 写入文件
      if (append) {
        await fs.promises.appendFile(path, content, { encoding });
      } else {
        await fs.promises.writeFile(path, content, { encoding });
      }
      
      return {
        success: true,
        output: `Successfully wrote to ${path}`,
        executionTime: Date.now() - startTime,
        data: { path, size: content.length }
      };
    } catch (error) {
      return {
        success: false,
        output: '',
        errors: [error instanceof Error ? error.message : String(error)],
        executionTime: Date.now() - startTime
      };
    }
  }
}
```

### 3. RunCommand 工具

```typescript
/**
 * 执行命令工具
 */
class RunCommandTool implements Tool {
  name = 'RunCommand';
  description = '执行系统命令';
  
  parameters = {
    type: 'object',
    properties: {
      command: { type: 'string', description: '命令' },
      args: { type: 'array', description: '参数列表', items: { type: 'string' } },
      cwd: { type: 'string', description: '工作目录' },
      timeout: { type: 'number', description: '超时时间（毫秒）', default: 60000 }
    },
    required: ['command']
  };
  
  async execute(context: Context, args: Record<string, any>): Promise<ToolResult> {
    const startTime = Date.now();
    
    try {
      const { command, args = [], cwd = process.cwd(), timeout = 60000 } = args;
      
      // 执行命令
      const { stdout, stderr } = await execa(command, args, {
        cwd,
        timeout,
        encoding: 'utf-8'
      });
      
      return {
        success: !stderr,
        output: stdout || stderr,
        executionTime: Date.now() - startTime,
        data: { command, args, cwd }
      };
    } catch (error) {
      return {
        success: false,
        output: '',
        errors: [error instanceof Error ? error.message : String(error)],
        executionTime: Date.now() - startTime
      };
    }
  }
}
```

---

## 📊 工具注册中心

### 注册中心实现

```typescript
/**
 * 工具注册中心
 */
class ToolRegistry {
  private tools: Map<string, Tool> = new Map();
  
  /**
   * 注册工具
   */
  register(tool: Tool): void {
    if (this.tools.has(tool.name)) {
      throw new Error(`Tool ${tool.name} already registered`);
    }
    this.tools.set(tool.name, tool);
    console.log(`[ToolRegistry] Registered tool: ${tool.name}`);
  }
  
  /**
   * 获取工具
   */
  getTool(name: string): Tool | undefined {
    return this.tools.get(name);
  }
  
  /**
   * 获取所有工具
   */
  getAllTools(): Tool[] {
    return Array.from(this.tools.values());
  }
  
  /**
   * 获取工具描述列表
   */
  getToolDescriptions(): ToolDescription[] {
    return this.getAllTools().map(tool => tool.getDescription());
  }
  
  /**
   * 注销工具
   */
  unregister(name: string): void {
    this.tools.delete(name);
    console.log(`[ToolRegistry] Unregistered tool: ${name}`);
  }
  
  /**
   * 清空所有工具
   */
  clear(): void {
    this.tools.clear();
  }
}
```

---

## 🔒 权限和安全

### 权限控制

```typescript
/**
 * 权限管理器
 */
class PermissionManager {
  private permissions: Map<string, Set<string>> = new Map();
  
  /**
   * 检查权限
   */
  checkPermission(toolName: string, action: string): boolean {
    const toolPerms = this.permissions.get(toolName);
    if (!toolPerms) return false;
    return toolPerms.has(action);
  }
  
  /**
   * 授予权限
   */
  grantPermission(toolName: string, action: string): void {
    if (!this.permissions.has(toolName)) {
      this.permissions.set(toolName, new Set());
    }
    this.permissions.get(toolName)!.add(action);
  }
  
  /**
   * 撤销权限
   */
  revokePermission(toolName: string, action: string): void {
    const toolPerms = this.permissions.get(toolName);
    if (toolPerms) {
      toolPerms.delete(action);
    }
  }
}
```

---

## 📈 性能优化

### 1. 工具缓存

```typescript
/**
 * 工具结果缓存
 */
class ToolCache {
  private cache: Map<string, { result: ToolResult; timestamp: number }> = new Map();
  private ttl: number = 5 * 60 * 1000; // 5 分钟
  
  get(key: string): ToolResult | null {
    const item = this.cache.get(key);
    if (!item) return null;
    
    if (Date.now() - item.timestamp > this.ttl) {
      this.cache.delete(key);
      return null;
    }
    
    return item.result;
  }
  
  set(key: string, result: ToolResult): void {
    this.cache.set(key, {
      result,
      timestamp: Date.now()
    });
  }
  
  clear(): void {
    this.cache.clear();
  }
}
```

---

## 🔗 相关文档

- [00-overview.md](./00-overview.md) - 架构总览
- [01-agent-core.md](./01-agent-core.md) - Agent 核心
- [03-context-manager.md](./03-context-manager.md) - 上下文管理

---

**文档持续迭代中...** 🚀

**最后更新：** 2026-04-01  
**维护者：** 池少团队
