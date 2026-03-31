/**
 * Planner - 任务规划器
 * 
 * 将复杂任务分解为可执行的步骤
 */

import { Intent } from './intent';
import { Step } from './step';

/**
 * 执行计划
 */
export interface Plan {
  /** 执行步骤列表 */
  steps: Step[];
  
  /** 预估时间（分钟） */
  estimatedTime: number;
  
  /** 依赖关系 */
  dependencies?: Map<string, string[]>;
}

/**
 * 任务规划器
 */
export class TaskPlanner {
  
  /**
   * 为意图创建执行计划
   */
  createPlan(intent: Intent): Plan {
    const steps: Step[] = [];
    
    switch (intent.type) {
      case 'code-generation':
        steps.push(
          { id: 1, action: 'parse-spec', description: '解析规范' },
          { id: 2, action: 'generate-interface', description: '生成接口' },
          { id: 3, action: 'generate-implementation', description: '生成实现' },
          { id: 4, action: 'generate-tests', description: '生成测试' },
          { id: 5, action: 'validate', description: '验证结果' }
        );
        break;
      
      case 'code-analysis':
        steps.push(
          { id: 1, action: 'parse-code', description: '解析代码' },
          { id: 2, action: 'analyze-structure', description: '分析结构' },
          { id: 3, action: 'identify-issues', description: '识别问题' },
          { id: 4, action: 'suggest-improvements', description: '建议改进' }
        );
        break;
      
      case 'testing':
        steps.push(
          { id: 1, action: 'identify-test-targets', description: '识别测试目标' },
          { id: 2, action: 'generate-test-cases', description: '生成测试用例' },
          { id: 3, action: 'run-tests', description: '运行测试' },
          { id: 4, action: 'report-results', description: '报告结果' }
        );
        break;
      
      default:
        steps.push(
          { id: 1, action: 'analyze', description: '分析需求' },
          { id: 2, action: 'execute', description: '执行任务' },
          { id: 3, action: 'validate', description: '验证结果' }
        );
    }
    
    return {
      steps,
      estimatedTime: steps.length * 2 // 每个步骤预估 2 分钟
    };
  }
}
