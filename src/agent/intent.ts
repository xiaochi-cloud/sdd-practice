/**
 * Intent - 意图识别
 * 
 * 识别用户输入的真实意图
 */

export interface Intent {
  /** 意图类型 */
  type: 'code-generation' | 'code-analysis' | 'testing' | 'refactoring' | 'documentation';
  
  /** 意图描述 */
  description: string;
  
  /** 相关上下文 */
  context?: string[];
  
  /** 约束条件 */
  constraints?: string[];
}

/**
 * 意图识别器
 */
export class IntentRecognizer {
  
  /**
   * 识别用户意图
   */
  recognize(input: string): Intent {
    const lowerInput = input.toLowerCase();
    
    // 代码生成
    if (lowerInput.includes('create') || lowerInput.includes('generate')) {
      return { type: 'code-generation', description: input };
    }
    
    // 代码分析
    if (lowerInput.includes('analyze') || lowerInput.includes('review')) {
      return { type: 'code-analysis', description: input };
    }
    
    // 测试
    if (lowerInput.includes('test')) {
      return { type: 'testing', description: input };
    }
    
    // 重构
    if (lowerInput.includes('refactor') || lowerInput.includes('optimize')) {
      return { type: 'refactoring', description: input };
    }
    
    // 文档
    if (lowerInput.includes('document') || lowerInput.includes('doc')) {
      return { type: 'documentation', description: input };
    }
    
    // 默认：代码生成
    return { type: 'code-generation', description: input };
  }
}
