# 30 分钟完整教程

> 从零开始体验 SDD 规范驱动开发

**预计时间：** 30 分钟  
**难度：** ⭐⭐☆☆☆  
**前置要求：** Java 基础

---

## 🎯 学习目标

完成本教程后，你将能够：
- ✅ 理解 SDD 核心概念
- ✅ 编写简单的规范
- ✅ 使用 AI 生成代码
- ✅ 运行和测试示例

---

## 📋 第一部分：理解 SDD（5 分钟）

### 什么是 SDD？

**SDD = Specification-Driven Development（规范驱动开发）**

**核心理念：** 先写规范，再写代码

**传统开发流程：**
```
需求 → 设计 → 编码 → 测试 → 文档
（容易信息丢失，返工率高）
```

**SDD 开发流程：**
```
规范 → AI 生成 → 测试 → 迭代
（规范即代码，文档永远同步）
```

### SDD 的核心价值

| 价值 | 说明 | 数据 |
|------|------|------|
| 减少返工 | 规范明确，需求不偏差 | ↓60% |
| 提高效率 | AI 自主编程，端到端完成 | ↑10 倍 |
| 文档同步 | Spec 即文档，自动更新 | ↓80% 维护 |

---

## 📋 第二部分：编写规范（10 分钟）

### 规范示例：用户注册

创建文件：`.openspec/user-register.yaml`

```yaml
name: 用户注册
version: 1.0.0
description: 新用户注册功能

functions:
  - name: register
    description: 用户注册
    parameters:
      - name: username
        type: string
        required: true
        description: 用户名（3-20 字符）
      - name: email
        type: string
        required: true
        description: 邮箱地址
      - name: password
        type: string
        required: true
        description: 密码（8-32 字符）
    returns:
      type: User
      description: 用户对象
    errors:
      - USER_EXISTS: 用户已存在
      - INVALID_EMAIL: 邮箱格式错误
      - WEAK_PASSWORD: 密码强度不足
```

### 规范要点

1. **清晰的名称** - 一眼看出功能
2. **完整的参数** - 类型、必填、描述
3. **明确的返回值** - 返回什么
4. **完整的错误** - 可能的错误情况

---

## 📋 第三部分：AI 生成代码（10 分钟）

### 使用 Qoder 生成

```bash
# 安装 Qoder（如未安装）
pip install qoder-cli

# 生成代码
qoder generate --spec .openspec/user-register.yaml --lang java

# 输出：
# ✅ 生成 UserService.java
# ✅ 生成 UserServiceImpl.java
# ✅ 生成 UserRegisterRequest.java
# ✅ 生成 UserServiceTest.java
```

### 生成的代码

**UserService.java：**
```java
package com.sdd.user;

/**
 * 用户服务接口
 * SDD 规范驱动生成
 */
public interface UserService {
    
    /**
     * 用户注册
     * @param request 注册请求
     * @return 用户对象
     * @throws UserExistsException 用户已存在
     */
    User register(UserRegisterRequest request);
}
```

**UserServiceImpl.java：**
```java
package com.sdd.user;

@Service
public class UserServiceImpl implements UserService {
    
    @Override
    public User register(UserRegisterRequest request) {
        // 验证用户名
        if (userRepository.existsByUsername(request.getUsername())) {
            throw new UserExistsException("用户已存在");
        }
        
        // 验证邮箱
        if (!isValidEmail(request.getEmail())) {
            throw new InvalidEmailException("邮箱格式错误");
        }
        
        // 验证密码强度
        if (!isStrongPassword(request.getPassword())) {
            throw new WeakPasswordException("密码强度不足");
        }
        
        // 创建用户
        User user = new User();
        user.setUsername(request.getUsername());
        user.setEmail(request.getEmail());
        user.setPassword(encodePassword(request.getPassword()));
        
        return userRepository.save(user);
    }
}
```

---

## 📋 第四部分：运行测试（5 分钟）

### 运行测试

```bash
cd examples/user-management
mvn test
```

### 预期输出

```
[INFO] Tests run: 5, Failures: 0, Errors: 0, Skipped: 0
[INFO] BUILD SUCCESS

测试覆盖：
✅ 用户注册成功
✅ 用户名重复检测
✅ 邮箱格式验证
✅ 密码强度验证
✅ 密码加密存储
```

### 查看测试报告

```bash
# 打开测试报告
open target/site/jacoco/index.html
```

---

## 🎉 完成！

你已经完成了 30 分钟 SDD 教程！

---

## 📚 下一步

- [02-sdd-introduction.md](./02-sdd-introduction.md) - SDD 深入介绍
- [../templates/](../templates/) - 规范模板
- [../examples/user-management/](../examples/user-management/) - 完整示例

---

## ❓ 常见问题

**Q: 规范很难写吗？**

A: 不难！就像写配置一样，参考模板即可。

**Q: AI 生成的代码可靠吗？**

A: 标准代码可靠（80%），复杂逻辑需人工优化（20%）。

**Q: 如何调试生成的代码？**

A: 像普通代码一样调试，IDE 支持完整功能。

---

**最后更新：** 2026-03-18  
**维护者：** 池少团队
