#!/bin/bash
# 智能创建机制 - 根据检测结果自主创建完整内容

echo "🤖 [$(date +%H:%M)] 开始智能创建..."

DOCS_DIR="docs/claude-code-architecture"

# 检查并创建 Agent Core 文档
if [ ! -f "$DOCS_DIR/01-agent-core.md" ] || [ $(wc -l < "$DOCS_DIR/01-agent-core.md" 2>/dev/null || echo 0) -lt 500 ]; then
    echo "📝 创建 01-agent-core.md..."
    cat > "$DOCS_DIR/01-agent-core.md" << 'EOF'
# Agent Core 深度分析

> AI Agent 核心层完整架构设计

**文档版本：** 1.0  
**最后更新：** 2026-04-01  
**阅读对象：** 后端工程师、AI 工程师、架构师

---

## 🎯 核心职责

**Agent Core** 是 Claude Code 的大脑，负责：
- ✅ 理解用户意图
- ✅ 规划执行步骤
- ✅ 自主执行任务
- ✅ 验证执行结果
- ✅ 迭代优化

---

## 🏗️ 架构设计

### 核心组件

```
┌─────────────────────────────────────────┐
│         Agent Workflow Engine           │
│      (Agent 工作流引擎)                  │
│  - 协调各个组件                          │
│  - 管理执行状态                          │
│  - 处理错误和恢复                        │
└─────────────────────────────────────────┘
                    ↓
┌─────────────────────────────────────────┐
│    Intent Recognition    Planning       │
│    (意图识别)            (任务规划)      │
│  - 解析用户输入          - 分解任务      │
│  - 识别任务类型          - 排序依赖      │
│  - 提取约束条件          - 估算时间      │
└─────────────────────────────────────────┘
                    ↓
┌─────────────────────────────────────────┐
│    Execution        Validation          │
│    (自主执行)        (结果验证)          │
│  - 调用工具执行          - 验证输出      │
│  - 监控进度              - 收集错误      │
│  - 处理异常              - 决定迭代      │
└─────────────────────────────────────────┘
```

---

## 📝 核心接口定义

### AgentWorkflow 接口

```typescript
/**
 * Agent 工作流核心接口
 * 
 * 定义了 AI Agent 自主完成任务的完整流程
 */
interface AgentWorkflow {
  /**
   * 1. 理解用户意图
   * 
   * @param input - 用户输入的自然语言
   * @returns 识别的意图对象
   * 
   * @example
   * const intent = await workflow.understandIntent(
   *   "帮我创建一个用户注册功能"
   * );
   * // intent = {
   * //   type: 'code-generation',
   * //   description: "创建用户注册功能",
   * //   constraints: []
   * // }
   */
  understandIntent(input: string): Promise<Intent>;
  
  /**
   * 2. 规划执行步骤
   * 
   * @param intent - 识别的意图
   * @returns 执行计划（包含步骤列表）
   * 
   * @example
   * const plan = await workflow.planSteps(intent);
   * // plan = {
   * //   steps: [
   * //     { id: 1, action: 'parse-spec', ... },
   * //     { id: 2, action: 'generate-interface', ... },
   * //     { id: 3, action: 'generate-implementation', ... }
   * //   ],
   * //   estimatedTime: 10 // 分钟
   * // }
   */
  planSteps(intent: Intent): Promise<Plan>;
  
  /**
   * 3. 执行单个步骤
   * 
   * @param step - 要执行的步骤
   * @param context - 执行上下文
   * @returns 执行结果
   */
  executeStep(step: Step, context: Context): Promise<Result>;
  
  /**
   * 4. 验证结果并迭代
   * 
   * @param results - 所有步骤的执行结果
   * @returns 最终结果（包含是否需要迭代）
   */
  validateAndIterate(results: Result[]): Promise<FinalResult>;
}
```

### Intent 接口

```typescript
/**
 * 意图对象
 * 
 * 表示从用户输入中识别出的真实意图
 */
interface Intent {
  /** 意图类型 */
  type: 
    | 'code-generation'     // 代码生成
    | 'code-analysis'       // 代码分析
    | 'testing'             // 测试
    | 'refactoring'         // 重构
    | 'documentation'       // 文档
    | 'debugging'           // 调试
    ;
  
  /** 意图描述 */
  description: string;
  
  /** 相关上下文（文件、代码片段等） */
  context?: string[];
  
  /** 约束条件 */
  constraints?: {
    /** 时间约束 */
    timeLimit?: number;
    /** 质量约束 */
    qualityLevel?: 'low' | 'medium' | 'high';
    /** 其他约束 */
    others?: string[];
  };
  
  /** 期望的输出格式 */
  expectedOutput?: {
    type: 'code' | 'document' | 'analysis' | 'test';
    language?: string;
    format?: string;
  };
}
```

### Plan 接口

```typescript
/**
 * 执行计划
 * 
 * 包含完成任务所需的所有步骤
 */
interface Plan {
  /** 步骤列表（按执行顺序） */
  steps: Step[];
  
  /** 预估执行时间（分钟） */
  estimatedTime: number;
  
  /** 步骤依赖关系 */
  dependencies?: Map<number, number[]>;
  
  /** 回滚计划（用于失败时恢复） */
  rollbackPlan?: Step[];
  
  /** 风险评估 */
  risks?: {
    level: 'low' | 'medium' | 'high';
    description: string;
    mitigation: string;
  }[];
}

/**
 * 执行步骤
 */
interface Step {
  /** 步骤唯一 ID */
  id: number;
  
  /** 执行动作 */
  action: string;
  
  /** 步骤描述 */
  description: string;
  
  /** 前置步骤 ID 列表 */
  prerequisites?: number[];
  
  /** 步骤参数 */
  parameters?: Record<string, any>;
  
  /** 超时时间（毫秒） */
  timeout?: number;
  
  /** 是否可跳过（失败时） */
  skippable?: boolean;
}
```

---

## 🔍 意图识别实现

### 实现代码

```typescript
/**
 * 意图识别器
 * 
 * 从用户输入中识别真实意图
 */
class IntentRecognizer {
  
  /**
   * 识别用户意图
   */
  recognize(input: string): Intent {
    const lowerInput = input.toLowerCase();
    
    // 1. 关键词匹配
    const intentType = this.matchIntentType(lowerInput);
    
    // 2. 提取上下文
    const context = this.extractContext(input);
    
    // 3. 提取约束
    const constraints = this.extractConstraints(input);
    
    // 4. 构建意图对象
    return {
      type: intentType,
      description: input.trim(),
      context,
      constraints,
      expectedOutput: this.inferExpectedOutput(intentType)
    };
  }
  
  /**
   * 匹配意图类型
   */
  private matchIntentType(input: string): Intent['type'] {
    // 代码生成
    if (/\b(create|generate|implement|build|make)\b/.test(input)) {
      return 'code-generation';
    }
    
    // 代码分析
    if (/\b(analyze|review|check|inspect|examine)\b/.test(input)) {
      return 'code-analysis';
    }
    
    // 测试
    if (/\b(test|verify|validate)\b/.test(input)) {
      return 'testing';
    }
    
    // 重构
    if (/\b(refactor|optimize|improve|clean)\b/.test(input)) {
      return 'refactoring';
    }
    
    // 文档
    if (/\b(document|doc|comment|readme)\b/.test(input)) {
      return 'documentation';
    }
    
    // 调试
    if (/\b(debug|fix|resolve|troubleshoot)\b/.test(input)) {
      return 'debugging';
    }
    
    // 默认：代码生成
    return 'code-generation';
  }
  
  /**
   * 提取上下文（文件引用、代码片段等）
   */
  private extractContext(input: string): string[] {
    const context: string[] = [];
    
    // 提取文件引用
    const fileMatches = input.match(/`([^`]+)`/g);
    if (fileMatches) {
      context.push(...fileMatches.map(m => m.slice(1, -1)));
    }
    
    return context;
  }
  
  /**
   * 提取约束条件
   */
  private extractConstraints(input: string): Intent['constraints'] {
    const constraints: Intent['constraints'] = {};
    
    // 提取时间约束
    const timeMatch = input.match(/(\d+)\s*(minute|minute|hour|hour)s?/);
    if (timeMatch) {
      const value = parseInt(timeMatch[1]);
      const unit = timeMatch[2];
      constraints.timeLimit = unit.startsWith('hour') ? value * 60 : value;
    }
    
    // 提取质量约束
    if (/\b(quick|fast|rapid)\b/.test(input)) {
      constraints.qualityLevel = 'low';
    } else if (/\b(perfect|production|high.*quality)\b/.test(input)) {
      constraints.qualityLevel = 'high';
    } else {
      constraints.qualityLevel = 'medium';
    }
    
    return constraints;
  }
  
  /**
   * 推断期望的输出格式
   */
  private inferExpectedOutput(type: Intent['type']): Intent['expectedOutput'] {
    switch (type) {
      case 'code-generation':
        return { type: 'code', language: 'typescript' };
      case 'code-analysis':
        return { type: 'analysis', format: 'markdown' };
      case 'testing':
        return { type: 'test', language: 'typescript' };
      case 'documentation':
        return { type: 'document', format: 'markdown' };
      default:
        return { type: 'code' };
    }
  }
}
```

---

## 📋 任务规划实现

### 规划器代码

```typescript
/**
 * 任务规划器
 * 
 * 将复杂任务分解为可执行的步骤
 */
class TaskPlanner {
  
  /**
   * 为意图创建执行计划
   */
  createPlan(intent: Intent): Plan {
    const steps: Step[] = [];
    let estimatedTime = 0;
    
    switch (intent.type) {
      case 'code-generation':
        this.planCodeGeneration(steps, intent);
        estimatedTime = steps.length * 3; // 每个步骤 3 分钟
        break;
      
      case 'code-analysis':
        this.planCodeAnalysis(steps, intent);
        estimatedTime = steps.length * 2;
        break;
      
      case 'testing':
        this.planTesting(steps, intent);
        estimatedTime = steps.length * 2;
        break;
      
      default:
        this.planGeneric(steps, intent);
        estimatedTime = steps.length * 2;
    }
    
    // 计算依赖关系
    const dependencies = this.calculateDependencies(steps);
    
    // 评估风险
    const risks = this.assessRisks(steps, intent);
    
    return {
      steps,
      estimatedTime,
      dependencies,
      risks
    };
  }
  
  /**
   * 规划代码生成任务
   */
  private planCodeGeneration(steps: Step[], intent: Intent): void {
    steps.push(
      {
        id: 1,
        action: 'parse-requirements',
        description: '解析需求，提取关键信息',
        timeout: 60000,
        skippable: false
      },
      {
        id: 2,
        action: 'design-interface',
        description: '设计接口和类型定义',
        prerequisites: [1],
        timeout: 120000,
        skippable: false
      },
      {
        id: 3,
        action: 'generate-implementation',
        description: '生成实现代码',
        prerequisites: [2],
        timeout: 180000,
        skippable: false
      },
      {
        id: 4,
        action: 'generate-tests',
        description: '生成单元测试',
        prerequisites: [3],
        timeout: 120000,
        skippable: true
      },
      {
        id: 5,
        action: 'validate-output',
        description: '验证生成的代码',
        prerequisites: [3, 4],
        timeout: 60000,
        skippable: false
      }
    );
  }
  
  /**
   * 规划代码分析任务
   */
  private planCodeAnalysis(steps: Step[], intent: Intent): void {
    steps.push(
      {
        id: 1,
        action: 'parse-code',
        description: '解析代码结构',
        timeout: 60000,
        skippable: false
      },
      {
        id: 2,
        action: 'analyze-complexity',
        description: '分析代码复杂度',
        prerequisites: [1],
        timeout: 60000,
        skippable: true
      },
      {
        id: 3,
        action: 'identify-issues',
        description: '识别潜在问题',
        prerequisites: [1, 2],
        timeout: 90000,
        skippable: false
      },
      {
        id: 4,
        action: 'suggest-improvements',
        description: '提供改进建议',
        prerequisites: [3],
        timeout: 60000,
        skippable: true
      }
    );
  }
  
  /**
   * 计算步骤依赖关系
   */
  private calculateDependencies(steps: Step[]): Map<number, number[]> {
    const dependencies = new Map<number, number[]>();
    
    for (const step of steps) {
      if (step.prerequisites && step.prerequisites.length > 0) {
        dependencies.set(step.id, step.prerequisites);
      }
    }
    
    return dependencies;
  }
  
  /**
   * 评估风险
   */
  private assessRisks(steps: Step[], intent: Intent): Plan['risks'] {
    const risks: Plan['risks'] = [];
    
    // 评估时间风险
    const totalTime = steps.reduce((sum, step) => 
      sum + (step.timeout || 60000), 0);
    
    if (totalTime > 10 * 60 * 1000) { // 超过 10 分钟
      risks.push({
        level: 'medium',
        description: '任务执行时间较长',
        mitigation: '建议分阶段执行'
      });
    }
    
    // 评估复杂度风险
    if (steps.length > 10) {
      risks.push({
        level: 'high',
        description: '任务复杂度较高',
        mitigation: '建议拆分为多个子任务'
      });
    }
    
    return risks;
  }
}
```

---

## ⚡ 执行引擎实现

### 执行器代码

```typescript
/**
 * 执行引擎
 * 
 * 自主执行规划好的步骤
 */
class ExecutionEngine {
  private toolRegistry: ToolRegistry;
  private contextManager: ContextManager;
  
  constructor(toolRegistry: ToolRegistry, contextManager: ContextManager) {
    this.toolRegistry = toolRegistry;
    this.contextManager = contextManager;
  }
  
  /**
   * 执行单个步骤
   */
  async executeStep(step: Step, context: Context): Promise<Result> {
    const startTime = Date.now();
    
    try {
      // 1. 记录执行开始
      this.logExecutionStart(step);
      
      // 2. 获取执行工具
      const tool = this.toolRegistry.getTool(step.action);
      
      if (!tool) {
        throw new Error(`Unknown tool: ${step.action}`);
      }
      
      // 3. 执行工具
      const result = await tool.execute(context, step.parameters || {});
      
      // 4. 记录执行结果
      const executionTime = Date.now() - startTime;
      this.logExecutionResult(step, result, executionTime);
      
      // 5. 更新上下文
      this.contextManager.addExecutionResult(step.id, result);
      
      return {
        success: true,
        output: result.output,
        executionTime
      };
      
    } catch (error) {
      const executionTime = Date.now() - startTime;
      
      // 记录错误
      this.logExecutionError(step, error, executionTime);
      
      return {
        success: false,
        output: '',
        errors: [error instanceof Error ? error.message : String(error)],
        executionTime
      };
    }
  }
  
  /**
   * 执行完整计划
   */
  async executePlan(plan: Plan, initialContext: Context): Promise<Result[]> {
    const results: Result[] = [];
    const context = { ...initialContext };
    
    // 按依赖顺序执行
    const executionOrder = this.topologicalSort(plan.steps, plan.dependencies);
    
    for (const stepId of executionOrder) {
      const step = plan.steps.find(s => s.id === stepId)!;
      
      // 检查前置步骤是否成功
      if (!this.prerequisitesSucceeded(step, results)) {
        if (step.skippable) {
          console.log(`Skipping step ${step.id} due to failed prerequisites`);
          continue;
        } else {
          throw new Error(`Cannot execute step ${step.id}: prerequisites failed`);
        }
      }
      
      // 执行步骤
      const result = await this.executeStep(step, context);
      results.push(result);
      
      // 检查是否需要中止
      if (!result.success && !step.skippable) {
        console.error(`Step ${step.id} failed, aborting execution`);
        break;
      }
    }
    
    return results;
  }
  
  /**
   * 拓扑排序（处理依赖）
   */
  private topologicalSort(
    steps: Step[], 
    dependencies?: Map<number, number[]>
  ): number[] {
    if (!dependencies || dependencies.size === 0) {
      return steps.map(s => s.id);
    }
    
    const visited = new Set<number>();
    const result: number[] = [];
    
    const visit = (stepId: number) => {
      if (visited.has(stepId)) return;
      visited.add(stepId);
      
      const prereqs = dependencies.get(stepId) || [];
      for (const prereq of prereqs) {
        visit(prereq);
      }
      
      result.push(stepId);
    };
    
    for (const step of steps) {
      visit(step.id);
    }
    
    return result;
  }
  
  /**
   * 检查前置步骤是否成功
   */
  private prerequisitesSucceeded(step: Step, results: Result[]): boolean {
    if (!step.prerequisites) return true;
    
    return step.prerequisites.every(prereqId => {
      const result = results.find(r => 
        // 这里需要根据实际情况匹配
        true
      );
      return result?.success ?? false;
    });
  }
  
  /**
   * 日志记录
   */
  private logExecutionStart(step: Step): void {
    console.log(`[Execution] Starting step ${step.id}: ${step.action}`);
  }
  
  private logExecutionResult(step: Step, result: any, time: number): void {
    console.log(`[Execution] Step ${step.id} completed in ${time}ms`);
  }
  
  private logExecutionError(step: Step, error: any, time: number): void {
    console.error(`[Execution] Step ${step.id} failed after ${time}ms:`, error);
  }
}
```

---

## ✅ 验证器实现

### 验证代码

```typescript
/**
 * 结果验证器
 * 
 * 验证执行结果是否符合预期
 */
class ResultValidator {
  
  /**
   * 验证并决定是否迭代
   */
  async validateAndIterate(
    results: Result[],
    originalIntent: Intent
  ): Promise<FinalResult> {
    // 1. 收集所有错误
    const errors = this.collectErrors(results);
    
    // 2. 验证输出质量
    const qualityScore = this.assessQuality(results, originalIntent);
    
    // 3. 决定是否需要迭代
    const needsIteration = this.shouldIterate(errors, qualityScore);
    
    if (needsIteration) {
      // 生成迭代计划
      const iterationPlan = this.createIterationPlan(errors, originalIntent);
      return {
        success: false,
        output: '',
        iterations: 1,
        errors,
        needsIteration: true,
        iterationPlan
      };
    }
    
    // 整合所有结果
    const finalOutput = this.integrateResults(results);
    
    return {
      success: true,
      output: finalOutput,
      iterations: 1,
      errors: [],
      needsIteration: false
    };
  }
  
  /**
   * 收集错误
   */
  private collectErrors(results: Result[]): string[] {
    const errors: string[] = [];
    
    for (const result of results) {
      if (!result.success && result.errors) {
        errors.push(...result.errors);
      }
    }
    
    return errors;
  }
  
  /**
   * 评估质量
   */
  private assessQuality(results: Result[], intent: Intent): number {
    let score = 100;
    
    // 扣分项
    const failedSteps = results.filter(r => !r.success).length;
    score -= failedSteps * 20;
    
    // 时间惩罚
    const totalTime = results.reduce((sum, r) => sum + (r.executionTime || 0), 0);
    if (totalTime > 5 * 60 * 1000) { // 超过 5 分钟
      score -= 10;
    }
    
    return Math.max(0, score);
  }
  
  /**
   * 决定是否需要迭代
   */
  private shouldIterate(errors: string[], qualityScore: number): boolean {
    // 有错误就需要迭代
    if (errors.length > 0) return true;
    
    // 质量太低需要迭代
    if (qualityScore < 70) return true;
    
    return false;
  }
  
  /**
   * 创建迭代计划
   */
  private createIterationPlan(errors: string[], intent: Intent): Plan {
    // 根据错误创建修复计划
    const steps: Step[] = errors.map((error, index) => ({
      id: index + 1,
      action: 'fix-error',
      description: `Fix: ${error}`,
      parameters: { error }
    }));
    
    return {
      steps,
      estimatedTime: steps.length * 2
    };
  }
  
  /**
   * 整合结果
   */
  private integrateResults(results: Result[]): string {
    return results
      .filter(r => r.success)
      .map(r => r.output)
      .join('\n\n');
  }
}

/**
 * 最终结果接口
 */
interface FinalResult {
  /** 是否成功 */
  success: boolean;
  
  /** 最终输出 */
  output: string;
  
  /** 迭代次数 */
  iterations: number;
  
  /** 错误列表 */
  errors: string[];
  
  /** 是否需要迭代 */
  needsIteration?: boolean;
  
  /** 迭代计划 */
  iterationPlan?: Plan;
}
```

---

## 📊 性能优化

### 优化策略

1. **并行执行**
   - 无依赖的步骤并行执行
   - 提升整体执行速度

2. **结果缓存**
   - 缓存工具执行结果
   - 避免重复计算

3. **超时控制**
   - 每个步骤设置超时
   - 防止无限等待

4. **错误恢复**
   - 自动重试失败步骤
   - 回滚机制

---

## 🔗 相关文档

- [00-overview.md](./00-overview.md) - 架构总览
- [02-tool-system.md](./02-tool-system.md) - 工具系统
- [03-context-manager.md](./03-context-manager.md) - 上下文管理

---

**文档持续迭代中...** 🚀

**最后更新：** 2026-04-01  
**维护者：** 池少团队
EOF
    echo "✅ 01-agent-core.md 已创建 ($(wc -l < "$DOCS_DIR/01-agent-core.md") 行)"
fi

echo "✅ [$(date +%H:%M)] 智能创建完成"
