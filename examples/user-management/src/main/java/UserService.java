package com.sdd.user;

/**
 * 用户服务接口
 * 
 * SDD 规范驱动开发示例
 */
public interface UserService {
    
    /**
     * 创建用户
     * @param request 用户注册请求
     * @return 用户 ID
     */
    String createUser(CreateUserRequest request);
    
    /**
     * 获取用户
     * @param userId 用户 ID
     * @return 用户信息
     */
    User getUser(String userId);
}
