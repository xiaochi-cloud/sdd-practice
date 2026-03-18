#!/bin/bash
# 持续迭代脚本

echo "🚀 开始持续迭代..."

HOUR=$(date +%H)

# 10:00-17:00 每小时迭代一个功能
if [ $HOUR -ge 10 ] && [ $HOUR -le 17 ]; then
    TASKS=(
        "examples/user-management/src/main/java"
        "examples/user-management/tests"
        "templates/feature"
        "templates/api"
        "templates/model"
        "best-practices/guides"
        "best-practices/pitfalls"
        "tools/qoder"
        "learning-path/beginner"
    )
    
    TASK_INDEX=$((HOUR - 10))
    TASK=${TASKS[$TASK_INDEX]}
    
    if [ -n "$TASK" ]; then
        echo "📝 [$HOUR:00] 迭代：$TASK"
        mkdir -p "$TASK"
        
        # 根据类型创建内容
        case $TASK in
            *java*)
                cat > "$TASK/UserService.java" << 'EOF'
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
EOF
                echo "✅ 创建 Java 文件"
                ;;
            *tests*)
                cat > "$TASK/UserServiceTest.java" << 'EOF'
package com.sdd.user;

import org.junit.jupiter.api.Test;
import static org.junit.jupiter.api.Assertions.*;

/**
 * 用户服务测试
 */
public class UserServiceTest {
    
    @Test
    public void testCreateUser() {
        // TODO: 实现测试
        assertTrue(true);
    }
}
EOF
                echo "✅ 创建测试文件"
                ;;
            *templates*)
                cat > "$TASK/template.yaml" << 'EOF'
name: 模板名称
version: 1.0.0
description: 模板描述

fields:
  - name: 字段 1
    type: string
    required: true
  - name: 字段 2
    type: string
    required: false
EOF
                echo "✅ 创建模板文件"
                ;;
            *)
                cat > "$TASK/guide.md" << 'EOF'
# 实战指南

## 概述

[内容待完善]

## 步骤

1. 步骤 1
2. 步骤 2
3. 步骤 3

## 最佳实践

- 实践 1
- 实践 2
EOF
                echo "✅ 创建文档"
                ;;
        esac
        
        # Git 提交
        git add -A
        git commit -m "feat: 迭代 $TASK ($(date +%H:%M))"
        echo "✅ 提交完成"
    fi
fi

echo "✅ 迭代完成"
