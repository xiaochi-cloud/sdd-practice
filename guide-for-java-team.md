# Qoder + SDD + OpenSpec 科普指南

> 面向 Java 开发团队的规范驱动开发入门

**版本：** v1.0 | **日期：** 2026-03-11 | **目标受众：** Java 程序员

---

## 📋 目录

1. [为什么需要 SDD](#为什么需要-sdd)
2. [核心概念](#核心概念)
3. [Java 开发者的 SDD 实践](#java-开发者的-sdd-实践)
4. [Qoder 实战](#qoder-实战)
5. [迁移指南](#迁移指南)
6. [FAQ](#faq)

---

## 为什么需要 SDD

### 传统 Java 开发的痛点

作为 Java 程序员，你是否遇到过：

```
❌ 需求理解偏差
   产品经理说"A"，开发做成"B"，测试测的是"C"
   
❌ 文档过时
   代码改了，文档没改，3 个月后没人知道怎么维护
   
❌ 接口联调困难
   前端：你这个接口参数不对！
   后端：我按文档写的啊！
   
❌ 代码质量参差不齐
   不同人写的代码风格迥异，review 困难
   
❌ AI 协作困难
   让 AI 写代码，但 AI 不理解业务意图
```

### SDD 带来的改变

```
✅ 规范即文档
   规范文件就是最新文档，永远不会过时
   
✅ 规范即代码
   规范可以验证、可以测试、可以生成代码
   
✅ AI 友好
   AI 理解规范，生成符合规范的代码
   
✅ 团队协作
   规范审查 = 代码审查，减少沟通成本
```

---

## 核心概念

### 1. SDD（规范驱动开发）

**定义：** Specification-Driven Development

**核心思想：** 先编写规范，再基于规范开发

**对比传统开发：**

```
┌─────────────────────────────────────────────────────────┐
│                   传统开发流程                          │
├─────────────────────────────────────────────────────────┤
│                                                         │
│  需求文档 → 设计文档 → 编码 → 测试 → 文档（可选）       │
│     ↓         ↓         ↓      ↓         ↓             │
│   容易丢失   可能脱节   质量不一  覆盖不全   经常过时   │
│                                                         │
└─────────────────────────────────────────────────────────┘

┌─────────────────────────────────────────────────────────┐
│                   SDD 开发流程                          │
├─────────────────────────────────────────────────────────┤
│                                                         │
│  OpenSpec 规范 → AI 生成代码 → 测试验证 → 规范更新      │
│       ↓            ↓           ↓           ↓            │
│    机器可读     质量保证    自动验证    永远同步        │
│                                                         │
└─────────────────────────────────────────────────────────┘
```

### 2. OpenSpec（开放规范格式）

**定义：** 一种用 YAML/Markdown 编写的规范格式

**核心组件：**

```yaml
# 1. 项目元数据
meta:
  name: 项目名称
  version: 1.0.0
  description: 项目描述

# 2. 功能规范
spec:
  features:
    - id: F001
      name: 用户登录
      inputs: [...]
      outputs: [...]
      constraints: [...]

# 3. 数据模型
  models:
    - name: User
      fields:
        - name: id
          type: string
        - name: email
          type: string

# 4. API 接口
  apis:
    - path: /api/users
      method: POST
      request: {...}
      response: {...}

# 5. 业务规则
  rules:
    - id: R001
      condition: 密码错误 5 次
      action: 锁定账户

# 6. 测试用例
  tests:
    unit_tests: [...]
    integration_tests: [...]
```

**特点：**

| 特点 | 说明 | Java 类比 |
|------|------|----------|
| 人类可读 | YAML/Markdown | 像写配置 |
| 机器可解析 | 可验证、可生成 | 像注解 |
| 版本管理 | Git 友好 | 像代码 |
| 模块化 | 可拆分、可组合 | 像 Maven 模块 |

### 3. Qoder（AI 编程助手）

**定义：** 基于 OpenSpec 规范的 AI Coding Agent

**能力：**

```
1. 理解规范 → 读取 OpenSpec，理解业务意图
2. 生成代码 → 生成符合规范的代码
3. 添加注释 → 自动添加 JavaDoc
4. 生成测试 → 基于规范生成单元测试
5. 代码审查 → 检查代码是否符合规范
```

**工作流程：**

```
┌──────────────┐
│  OpenSpec    │  规范文件
│  规范        │
└──────┬───────┘
       │
       ↓
┌──────────────┐
│  Qoder AI    │  理解规范
│              │  生成代码
└──────┬───────┘
       │
       ↓
┌──────────────┐
│  Java 代码    │  符合规范
│  + 测试      │  带注释
└──────────────┘
```

---

## Java 开发者的 SDD 实践

### 对比理解

如果你熟悉以下 Java 概念，理解 SDD 很容易：

| Java 概念 | SDD 对应 | 说明 |
|----------|----------|------|
| **Interface** | **OpenSpec 规范** | 定义契约，不关心实现 |
| **JavaDoc** | **规范描述** | 说明意图和用法 |
| **Annotation** | **规范约束** | 添加元数据和规则 |
| **Maven/Gradle** | **规范模块化** | 组织和管理 |
| **Unit Test** | **规范测试** | 验证是否符合 |
| **Swagger/OpenAPI** | **API 规范** | 描述接口 |

### Java 项目结构对比

**传统 Java 项目：**

```
my-project/
├── src/
│   ├── main/
│   │   ├── java/
│   │   └── resources/
│   └── test/
├── pom.xml
└── README.md
```

**SDD + Java 项目：**

```
my-project/
├── .openspec/          # ← 新增：规范目录
│   ├── project.yaml
│   ├── features/
│   ├── models/
│   └── apis/
├── src/
│   ├── main/
│   │   ├── java/
│   │   └── resources/
│   └── test/
├── pom.xml
├── README.md
└── docs/              # ← 从规范自动生成
```

### 实战示例：用户管理

#### 步骤 1：编写规范

创建 `.openspec/features/user-management.yaml`：

```yaml
meta:
  id: F001
  name: 用户管理
  version: 1.0.0
  description: 用户注册、登录、信息管理

spec:
  features:
    - id: F001-01
      name: 用户注册
      description: 新用户注册账号
      
      inputs:
        - name: username
          type: string
          min_length: 3
          max_length: 20
          pattern: "^[a-zA-Z0-9_]+$"
          required: true
          
        - name: email
          type: string
          format: email
          required: true
          
        - name: password
          type: string
          min_length: 8
          max_length: 32
          required: true
      
      outputs:
        - name: user_id
          type: string
          format: uuid
        - name: created_at
          type: datetime
      
      constraints:
        - 用户名不能重复
        - 邮箱不能重复
        - 密码必须加密存储
      
      business_rules:
        - R001: 用户名只能包含字母、数字、下划线
        - R002: 密码必须包含大小写字母和数字
        - R003: 注册成功发送欢迎邮件
      
      acceptance_criteria:
        - 有效输入能成功注册
        - 用户名重复返回明确错误
        - 邮箱重复返回明确错误
        - 密码不符合要求返回明确错误
```

#### 步骤 2：AI 生成代码

使用 Qoder 生成 Java 代码：

```bash
qoder generate --feature F001 --lang java
```

生成的代码：

```java
// src/main/java/com/example/user/UserService.java
package com.example.user;

import java.time.LocalDateTime;
import java.util.UUID;

/**
 * 用户服务
 * 
 * 功能：用户注册、登录、信息管理
 * 规范版本：1.0.0
 * 
 * @author Qoder AI
 * @since 2026-03-11
 */
public interface UserService {
    
    /**
     * 用户注册
     * 
     * @param request 注册请求，包含用户名、邮箱、密码
     * @return 注册结果，包含用户 ID 和创建时间
     * @throws UserAlreadyExistsException 用户名或邮箱已存在
     * @throws InvalidPasswordException 密码不符合要求
     * @throws InvalidUsernameException 用户名不符合要求
     */
    RegisterResponse register(RegisterRequest request) 
        throws UserAlreadyExistsException, 
               InvalidPasswordException, 
               InvalidUsernameException;
    
    /**
     * 用户登录
     * 
     * @param email 邮箱
     * @param password 密码
     * @return 登录结果，包含用户信息和 Token
     * @throws UserNotFoundException 用户不存在
     * @throws InvalidPasswordException 密码错误
     */
    LoginResponse login(String email, String password)
        throws UserNotFoundException, InvalidPasswordException;
}
```

#### 步骤 3：生成实现类

```java
// src/main/java/com/example/user/UserServiceImpl.java
package com.example.user;

import org.springframework.stereotype.Service;
import org.springframework.beans.factory.annotation.Autowired;
import java.time.LocalDateTime;
import java.util.UUID;
import java.util.regex.Pattern;

/**
 * 用户服务实现
 * 
 * 基于 OpenSpec 规范生成
 * 规范版本：1.0.0
 */
@Service
public class UserServiceImpl implements UserService {
    
    // 用户名验证正则：只能包含字母、数字、下划线
    private static final Pattern USERNAME_PATTERN = 
        Pattern.compile("^[a-zA-Z0-9_]+$");
    
    // 密码验证正则：必须包含大小写字母和数字
    private static final Pattern PASSWORD_PATTERN = 
        Pattern.compile("^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d).+$");
    
    @Autowired
    private UserRepository userRepository;
    
    @Autowired
    private EmailService emailService;
    
    @Override
    public RegisterResponse register(RegisterRequest request) 
        throws UserAlreadyExistsException, 
               InvalidPasswordException, 
               InvalidUsernameException {
        
        // 验证用户名（业务规则 R001）
        if (!USERNAME_PATTERN.matcher(request.getUsername()).matches()) {
            throw new InvalidUsernameException(
                "用户名只能包含字母、数字、下划线");
        }
        
        // 验证密码（业务规则 R002）
        if (!PASSWORD_PATTERN.matcher(request.getPassword()).matches()) {
            throw new InvalidPasswordException(
                "密码必须包含大小写字母和数字");
        }
        
        // 检查用户名是否已存在
        if (userRepository.existsByUsername(request.getUsername())) {
            throw new UserAlreadyExistsException(
                "用户名已存在：" + request.getUsername());
        }
        
        // 检查邮箱是否已存在
        if (userRepository.existsByEmail(request.getEmail())) {
            throw new UserAlreadyExistsException(
                "邮箱已存在：" + request.getEmail());
        }
        
        // 创建用户
        User user = new User();
        user.setId(UUID.randomUUID().toString());
        user.setUsername(request.getUsername());
        user.setEmail(request.getEmail());
        user.setPasswordHash(encodePassword(request.getPassword()));
        user.setCreatedAt(LocalDateTime.now());
        
        userRepository.save(user);
        
        // 发送欢迎邮件（业务规则 R003）
        emailService.sendWelcomeEmail(user.getEmail(), user.getUsername());
        
        // 返回结果
        return new RegisterResponse(user.getId(), user.getCreatedAt());
    }
    
    @Override
    public LoginResponse login(String email, String password)
        throws UserNotFoundException, InvalidPasswordException {
        
        // 查找用户
        User user = userRepository.findByEmail(email)
            .orElseThrow(() -> new UserNotFoundException(
                "用户不存在：" + email));
        
        // 验证密码
        if (!verifyPassword(password, user.getPasswordHash())) {
            throw new InvalidPasswordException("密码错误");
        }
        
        // 生成 Token
        String token = generateToken(user);
        
        return new LoginResponse(user, token);
    }
    
    // 密码加密（约束：密码必须加密存储）
    private String encodePassword(String password) {
        // TODO: 使用 BCrypt 加密
        return password; // 示例代码
    }
    
    // 密码验证
    private boolean verifyPassword(String password, String hash) {
        // TODO: 使用 BCrypt 验证
        return true; // 示例代码
    }
    
    // 生成 Token
    private String generateToken(User user) {
        // TODO: 使用 JWT 生成 Token
        return "token_" + user.getId(); // 示例代码
    }
}
```

#### 步骤 4：生成测试

```java
// src/test/java/com/example/user/UserServiceTest.java
package com.example.user;

import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.DisplayName;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

import static org.junit.jupiter.api.Assertions.*;

/**
 * 用户服务测试
 * 
 * 基于 OpenSpec 规范生成
 * 覆盖所有验收标准
 */
@SpringBootTest
class UserServiceTest {
    
    @Autowired
    private UserService userService;
    
    @Autowired
    private UserRepository userRepository;
    
    @Test
    @DisplayName("F001-01-TC01: 成功注册新用户")
    void testRegisterSuccess() {
        // 准备数据
        RegisterRequest request = new RegisterRequest();
        request.setUsername("test_user");
        request.setEmail("test@example.com");
        request.setPassword("Test1234");
        
        // 执行
        RegisterResponse response = userService.register(request);
        
        // 验证
        assertNotNull(response.getUserId());
        assertNotNull(response.getCreatedAt());
        
        // 清理
        userRepository.deleteAll();
    }
    
    @Test
    @DisplayName("F001-01-TC02: 用户名重复注册失败")
    void testRegisterDuplicateUsername() {
        // 准备数据 - 先注册一个用户
        RegisterRequest request1 = new RegisterRequest();
        request1.setUsername("test_user");
        request1.setEmail("test1@example.com");
        request1.setPassword("Test1234");
        userService.register(request1);
        
        // 尝试用相同用户名注册
        RegisterRequest request2 = new RegisterRequest();
        request2.setUsername("test_user"); // 重复
        request2.setEmail("test2@example.com");
        request2.setPassword("Test1234");
        
        // 验证 - 应该抛出异常
        assertThrows(UserAlreadyExistsException.class, () -> {
            userService.register(request2);
        });
        
        // 清理
        userRepository.deleteAll();
    }
    
    @Test
    @DisplayName("F001-01-TC03: 邮箱重复注册失败")
    void testRegisterDuplicateEmail() {
        // 准备数据
        RegisterRequest request1 = new RegisterRequest();
        request1.setUsername("user1");
        request1.setEmail("test@example.com");
        request1.setPassword("Test1234");
        userService.register(request1);
        
        // 尝试用相同邮箱注册
        RegisterRequest request2 = new RegisterRequest();
        request2.setUsername("user2");
        request2.setEmail("test@example.com"); // 重复
        request2.setPassword("Test1234");
        
        // 验证
        assertThrows(UserAlreadyExistsException.class, () -> {
            userService.register(request2);
        });
        
        // 清理
        userRepository.deleteAll();
    }
    
    @Test
    @DisplayName("F001-01-TC04: 用户名格式错误")
    void testRegisterInvalidUsername() {
        RegisterRequest request = new RegisterRequest();
        request.setUsername("invalid@user"); // 包含@
        request.setEmail("test@example.com");
        request.setPassword("Test1234");
        
        assertThrows(InvalidUsernameException.class, () -> {
            userService.register(request);
        });
    }
    
    @Test
    @DisplayName("F001-01-TC05: 密码格式错误")
    void testRegisterInvalidPassword() {
        RegisterRequest request = new RegisterRequest();
        request.setUsername("test_user");
        request.setEmail("test@example.com");
        request.setPassword("123456"); // 只有数字
        
        assertThrows(InvalidPasswordException.class, () -> {
            userService.register(request);
        });
    }
}
```

---

## Qoder 实战

### 安装 Qoder

```bash
# 方法 1：使用 pip
pip install qoder-cli

# 方法 2：下载二进制
wget https://github.com/qoder-ai/qoder/releases/latest/download/qoder-linux
chmod +x qoder-linux
sudo mv qoder-linux /usr/local/bin/qoder

# 验证安装
qoder --version
```

### 初始化项目

```bash
# 创建项目
mkdir my-sdd-project
cd my-sdd-project

# 初始化
qoder init --lang java --name my-project

# 生成目录结构
# .openspec/
# ├── project.yaml
# ├── features/
# ├── models/
# └── apis/
```

### 编写规范

编辑 `.openspec/features/user.yaml`：

```yaml
meta:
  id: F001
  name: 用户管理
  version: 1.0.0

spec:
  features:
    - id: F001-01
      name: 用户注册
      description: 新用户注册账号
      # ... 完整规范
```

### 生成代码

```bash
# 生成单个功能
qoder generate --feature F001-01 --lang java

# 生成整个项目
qoder generate --all --lang java

# 生成测试
qoder generate --tests --lang java

# 生成文档
qoder docs --format markdown
```

### 验证规范

```bash
# 验证规范语法
qoder validate

# 检查规范完整性
qoder check

# 查看规范统计
qoder stats
```

---

## 迁移指南

### 从传统 Java 项目迁移到 SDD

#### 阶段 1：试点（1-2 周）

```
1. 选择一个小功能模块
2. 编写 OpenSpec 规范
3. 用 Qoder 生成代码
4. 对比手动代码
5. 团队 review
```

#### 阶段 2：推广（2-4 周）

```
1. 培训团队成员
2. 制定规范编写标准
3. 集成到 CI/CD
4. 新项目使用 SDD
```

#### 阶段 3：全面采用（1-2 月）

```
1. 老项目逐步迁移
2. 规范审查纳入 code review
3. 建立规范库
4. 持续优化
```

### 与现有工具集成

#### Spring Boot

```yaml
# .openspec/project.yaml
meta:
  name: my-spring-project
  framework: spring-boot-3
  
spec:
  # Qoder 会生成 Spring 风格的代码
  # - @Service
  # - @RestController
  # - @Entity
  # - Spring Data JPA
```

#### Maven/Gradle

```xml
<!-- pom.xml -->
<dependencies>
    <!-- Qoder 运行时（可选） -->
    <dependency>
        <groupId>io.qoder</groupId>
        <artifactId>qoder-runtime</artifactId>
        <version>1.0.0</version>
    </dependency>
</dependencies>
```

#### CI/CD

```yaml
# .github/workflows/ci.yml
name: CI

on: [push, pull_request]

jobs:
  validate:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3
      
      - name: Validate OpenSpec
        run: qoder validate
      
      - name: Generate Code
        run: qoder generate --all
      
      - name: Run Tests
        run: mvn test
```

---

## FAQ

### Q1: SDD 会增加工作量吗？

**短期：** 是的，需要学习编写规范

**长期：** 不会，反而减少：

```
传统：需求 → 设计 → 编码 → 测试 → 文档（5 步）
SDD:   规范 → 生成 → 测试（3 步）

节省：
- 设计时间（规范即设计）
- 编码时间（AI 生成）
- 文档时间（自动生成）
```

### Q2: 规范会不会很复杂？

**不会**，OpenSpec 设计原则：

```
✅ 简单：YAML 格式，像写配置
✅ 渐进：从简单开始，逐步完善
✅ 复用：模块化，可组合
```

**示例对比：**

```java
// Java 代码（复杂）
@Service
public class UserServiceImpl implements UserService {
    @Autowired
    private UserRepository userRepository;
    
    @Override
    @Transactional
    public RegisterResponse register(RegisterRequest request) 
        throws UserAlreadyExistsException {
        // 50 行代码...
    }
}
```

```yaml
# OpenSpec 规范（简单）
features:
  - name: 用户注册
    inputs:
      - name: username
        type: string
    outputs:
      - name: user_id
        type: string
```

### Q3: AI 生成的代码可靠吗？

**分情况：**

```
✅ 可靠：
- 标准 CRUD
- 业务逻辑清晰
- 规范完整

⚠️ 需要审查：
- 复杂业务逻辑
- 性能敏感代码
- 安全相关代码
```

**最佳实践：**

```
1. AI 生成初稿
2. 人类审查优化
3. 测试验证
4. 持续改进
```

### Q4: 如何处理复杂业务逻辑？

**方法 1：分步规范**

```yaml
# 先写高层规范
features:
  - name: 订单处理
    steps:
      - 验证订单
      - 扣减库存
      - 创建支付
      - 发送通知

# 再写详细规范
sub_features:
  - name: 验证订单
    rules: [...]
```

**方法 2：混合开发**

```
规范生成：标准代码（80%）
手写代码：复杂逻辑（20%）
```

### Q5: 团队如何协作？

**规范审查流程：**

```
1. 开发者编写规范
2. 提交 PR
3. 团队审查规范
   - 业务逻辑是否正确
   - 约束是否完整
   - 测试是否覆盖
4. 审查通过后生成代码
5. 代码审查（关注实现细节）
6. 合并
```

---

## 📊 总结

### SDD 核心价值

| 维度 | 传统开发 | SDD |
|------|----------|-----|
| 需求理解 | 容易偏差 | 规范明确 |
| 代码质量 | 依赖个人 | 规范保证 |
| 文档 | 容易过时 | 永远同步 |
| AI 协作 | 困难 | 天然友好 |
| 团队协作 | 沟通成本高 | 规范即契约 |

### 何时使用 SDD

**✅ 适合：**

- 新项目
- 接口驱动开发
- 需要 AI 协作
- 团队协作

**⚠️ 谨慎：**

- 探索性项目（需求不明确）
- 原型开发（快速迭代）
- 超小项目（一人开发）

### 下一步

1. **学习** — 阅读 [QODER-SPEC.md](./QODER-SPEC.md)
2. **实践** — 创建试点项目
3. **分享** — 团队内部分享经验
4. **优化** — 持续改进流程

---

## 🔗 参考资料

- [OpenSpec 官方文档](https://openspec.dev/)
- [Qoder 使用指南](./README.md)
- [完整规范示例](./example-todo-app.yaml)
- [SDD 最佳实践](./QODER-SPEC.md)

---

**📊 难度：** ⭐⭐⭐☆☆  
**📝 预计时间：** 60 分钟  
**🏷️ 标签：** #qoder #sdd #openspec #java #guide

**最后更新：** 2026-03-11 | **版本：** v1.0
