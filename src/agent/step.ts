/**
 * Step - 执行步骤
 * 
 * 定义单个执行步骤的结构
 */

/**
 * 执行步骤
 */
export interface Step {
  /** 步骤 ID */
  id: number;
  
  /** 执行动作 */
  action: string;
  
  /** 步骤描述 */
  description: string;
  
  /** 前置步骤 ID 列表 */
  prerequisites?: number[];
  
  /** 步骤参数 */
  parameters?: Record<string, any>;
}

/**
 * 步骤执行结果
 */
export interface Result {
  /** 是否成功 */
  success: boolean;
  
  /** 输出内容 */
  output: string;
  
  /** 错误信息 */
  errors?: string[];
  
  /** 执行时间（毫秒） */
  executionTime?: number;
}
