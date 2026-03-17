# Qoder + SDD + OpenSpec

## 规范驱动开发最佳实践

### 让 AI 理解你的意图，生成高质量代码

**分享人：** 池少  
**时间：** 2026-03-12  
**时长：** 60-90 分钟

---

## 关于我

**池少**

- Java 程序员
- AI 应用开发者
- Learning AI 项目作者

**GitHub:** [xiaochi-cloud/learning-ai](https://github.com/xiaochi-cloud/learning-ai)

**今天你会学到：**
1. SDD 如何解决你的开发痛点
2. 5 分钟上手 SDD
3. 完整实战演示
4. 如何团队落地

---

## 今天的内容

**核心价值（3 个）：**
1. 减少返工 60%
2. 提高效率 10 倍
3. 文档永远同步

**议程：**
1. 为什么需要 SDD（10 分钟）
2. Qoder 核心能力（15 分钟）
3. 现场演示（10 分钟）
4. 团队落地（15 分钟）
5. Q&A（10 分钟）

---

## 📋 今天议程

```
Part 1: 为什么需要 SDD（10 分钟）
  - 痛点场景
  - SDD 价值（减少返工 60%）

Part 2: Qoder 核心能力（15 分钟）
  - Quest Mode 自主编程
  - Spec 驱动开发
  - 效率提升 10 倍

Part 3: 现场演示（10 分钟）
  - 用户注册功能
  - 10 分钟完成

Part 4: 团队落地（15 分钟）
  - 3 阶段迁移
  - 支持政策

Q&A（10 分钟）
```

---

# Part 1

## 为什么需要 SDD

---

## 传统 Java 开发的痛点

### 场景 1：需求理解偏差

```
产品经理：我要一个用户注册功能，要安全的
你：（开发 2 天，用 MD5 加密密码）
测试：密码强度不够，要用 BCrypt
你：（返工 1 天）

💰 成本：3 天开发 + 1 天返工 = 4 天
```

### 场景 2：文档过时

```
你：（写好代码，更新文档）
3 个月后...
新人：这个接口参数是什么？
文档：（已过时）
你：（不记得了，查代码 30 分钟）

💰 成本：沟通时间 + 查代码时间
```

### 场景 3：接口联调

```
前端：你这个接口参数不对！
后端：我按文档写的！
前端：文档是错的！
产品：别吵了，重新对需求

💰 成本：扯皮 1 小时 + 返工 2 小时
```

### 场景 4：AI 协作

```
你：AI，帮我写个用户服务
AI：（生成的代码不符合预期）
你：（反复尝试 5 次，还是不满意）

💰 成本：时间 + 挫败感
```

---

## 传统 Java 开发的痛点（续）

❌ **代码质量参差不齐**

不同人写的代码风格迥异，review 困难

❌ **AI 协作困难**

让 AI 写代码，但 AI 不理解业务意图

```java
// AI，帮我写个用户服务
// ... AI 生成的代码不符合预期 ...
// 为什么？AI 不理解你的业务意图
```

---

## SDD 带来的改变

### 对比

| 维度 | 传统开发 | SDD | 改进 |
|------|----------|-----|------|
| 需求理解 | 容易偏差 | 规范明确 | ↓70% |
| 文档 | 容易过时 | 永远同步 | ↓80% 维护 |
| AI 协作 | 困难 | 天然友好 | ↑50% 效率 |
| 团队沟通 | 成本高 | 规范即契约 | ↓30% |

### 真实案例

```
某电商团队实施 SDD 后：
- 返工率：从 40% → 20%
- Bug 率：从 15% → 7%
- 交付周期：从 2 周 → 1 周
- 开发者满意度：从 3.5 → 4.5/5
```

---

## 开发流程对比

### 传统开发

```
需求文档 → 设计文档 → 编码 → 测试 → 文档（可选）
   ↓         ↓         ↓      ↓         ↓
 容易丢失   可能脱节   质量不一  覆盖不全   经常过时
```

### SDD 开发

```
OpenSpec 规范 → AI 生成代码 → 测试验证 → 规范更新
      ↓            ↓           ↓           ↓
   机器可读     质量保证    自动验证    永远同步
```

---

# Part 2

## 核心概念详解

---

## 什么是 SDD？

**SDD = Specification-Driven Development**

**中文：规范驱动开发**

**核心思想：**

> 先编写规范（Spec），再基于规范开发

**类比：**

- Java Interface vs Implementation
- 建筑设计图 vs 施工
- 乐谱 vs 演奏

**Spec 格式：**

1. **自然语言**（推荐用于简单功能）
   - 像写需求文档
   - 快速上手

2. **OpenSpec YAML**（推荐用于复杂功能）
   - 结构化规范
   - 可生成完整代码
   - 开源标准：github.com/Fission-AI/OpenSpec

---

## 什么是 OpenSpec？

**OpenSpec = Open Specification Format**

**中文：开放规范格式**

**定义：** 一种用 YAML/Markdown 编写的规范格式

**特点：**

| 特点 | 说明 | Java 类比 |
|------|------|----------|
| 人类可读 | YAML/Markdown | 像写配置 |
| 机器可解析 | 可验证、可生成 | 像注解 |
| 版本管理 | Git 友好 | 像代码 |
| 模块化 | 可拆分、可组合 | 像 Maven 模块 |

---

## OpenSpec 核心组件

```yaml
# 1. 项目元数据
meta:
  name: 项目名称
  version: 1.0.0

# 2. 功能规范
spec:
  features:
    - id: F001
      name: 用户登录
      inputs: [...]
      outputs: [...]

# 3. 数据模型
  models:
    - name: User
      fields: [...]

# 4. API 接口
  apis:
    - path: /api/users
      method: POST

# 5. 业务规则
  rules:
    - id: R001
      condition: ...
      action: ...

# 6. 测试用例
  tests:
    unit_tests: [...]
```

---

## 什么是 Qoder？

**Qoder = Agentic 编码平台**

**定义：** 面向真实软件开发的 Agentic 编码平台

**核心能力：**

1. 代码智能生成
2. 智能问答
3. 多文件修改
4. **Quest Mode**（自主编程）⭐

**产品形态：**

- Qoder IDE（桌面应用）⭐
- Qoder 插件（JetBrains）
- Qoder CLI（终端工具）

---

## Qoder Quest Mode 工作流程

```
┌──────────────┐
│  描述目标    │  自然语言
│  (自然语言)  │  或 OpenSpec
└──────┬───────┘
       │
       ↓
┌──────────────┐
│  Quest 澄清  │  选择题
│  需求        │  确保理解
└──────┬───────┘
       │
       ↓
┌──────────────┐
│  生成 Spec   │  结构化文档
│  (可审核)    │  可修改
└──────┬───────┘
       │
       ↓
┌──────────────┐
│  自主编程    │  端到端完成
│  (Agent)     │  多文件修改
└──────┬───────┘
       │
       ↓
┌──────────────┐
│  验收结果    │  Accept/Reject
│  (应用修改)  │  或放弃
└──────────────┘
```

---

# Part 3

## Java 开发者实践

---

## 对比理解

如果你熟悉以下 Java 概念，理解 SDD 很容易：

| Java 概念 | SDD 对应 | 说明 |
|----------|----------|------|
| **Interface** | **OpenSpec 规范** | 定义契约，不关心实现 |
| **JavaDoc** | **规范描述** | 说明意图和用法 |
| **Annotation** | **规范约束** | 添加元数据和规则 |
| **Maven/Gradle** | **规范模块化** | 组织和管理 |
| **Unit Test** | **规范测试** | 验证是否符合 |
| **Swagger/OpenAPI** | **API 规范** | 描述接口 |

---

## 项目结构对比

### 传统 Java 项目

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

### SDD + Java 项目

```
my-project/
├── .openspec/          # ← 新增
│   ├── project.yaml
│   ├── features/
│   ├── models/
│   └── apis/
├── src/
│   ├── main/...
│   └── test/...
├── pom.xml
├── README.md
└── docs/              # ← 自动生成
```

---

## 实战：用户管理（1/4）

### 步骤 1：编写规范

`.openspec/features/user-management.yaml`

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
      
      inputs:
        - name: username
          type: string
          min_length: 3
          max_length: 20
          required: true
          
        - name: email
          type: string
          format: email
          required: true
          
        - name: password
          type: string
          min_length: 8
          required: true
      
      outputs:
        - name: user_id
          type: string
          format: uuid
        - name: created_at
          type: datetime
```

---

## 实战：用户管理（2/4）

### 步骤 2：AI 生成接口

```bash
qoder generate --feature F001-01 --lang java
```

生成的接口：

```java
/**
 * 用户服务
 * 功能：用户注册、登录、信息管理
 */
public interface UserService {
    
    /**
     * 用户注册
     * @param request 注册请求
     * @return 注册结果
     */
    RegisterResponse register(RegisterRequest request);
    
    /**
     * 用户登录
     * @param email 邮箱
     * @param password 密码
     * @return 登录结果
     */
    LoginResponse login(String email, String password);
}
```

---

## 实战：用户管理（3/4）

### 步骤 3：生成实现类

```java
@Service
public class UserServiceImpl implements UserService {
    
    @Autowired
    private UserRepository userRepository;
    
    @Override
    public RegisterResponse register(RegisterRequest request) {
        // 验证用户名
        if (!USERNAME_PATTERN.matcher(request.getUsername()).matches()) {
            throw new InvalidUsernameException("用户名格式错误");
        }
        
        // 验证密码
        if (!PASSWORD_PATTERN.matcher(request.getPassword()).matches()) {
            throw new InvalidPasswordException("密码格式错误");
        }
        
        // 检查重复
        if (userRepository.existsByUsername(request.getUsername())) {
            throw new UserAlreadyExistsException("用户名已存在");
        }
        
        // 创建用户
        User user = new User();
        user.setId(UUID.randomUUID().toString());
        user.setUsername(request.getUsername());
        user.setEmail(request.getEmail());
        user.setPasswordHash(encodePassword(request.getPassword()));
        user.setCreatedAt(LocalDateTime.now());
        
        userRepository.save(user);
        
        return new RegisterResponse(user.getId(), user.getCreatedAt());
    }
}
```

---

## 实战：用户管理（4/4）

### 步骤 4：生成测试

```java
@SpringBootTest
class UserServiceTest {
    
    @Autowired
    private UserService userService;
    
    @Test
    @DisplayName("成功注册新用户")
    void testRegisterSuccess() {
        RegisterRequest request = new RegisterRequest();
        request.setUsername("test_user");
        request.setEmail("test@example.com");
        request.setPassword("Test1234");
        
        RegisterResponse response = userService.register(request);
        
        assertNotNull(response.getUserId());
        assertNotNull(response.getCreatedAt());
    }
    
    @Test
    @DisplayName("用户名重复注册失败")
    void testRegisterDuplicateUsername() {
        // ... 测试代码
    }
}
```

---

# Part 4

## Qoder 实战演示

---

## 安装 Qoder

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

---

## 快速开始

```bash
# 1. 创建项目
mkdir my-sdd-project
cd my-sdd-project

# 2. 初始化
qoder init --lang java --name my-project

# 3. 编写规范
# 编辑 .openspec/features/user.yaml

# 4. 生成代码
qoder generate --feature F001 --lang java

# 5. 运行测试
qoder test

# 6. 生成文档
qoder docs --format markdown
```

---

## 常用命令

```bash
# 验证规范
qoder validate

# 生成代码
qoder generate --all
qoder generate --feature F001
qoder generate --tests

# 检查规范
qoder check

# 查看统计
qoder stats

# 生成文档
qoder docs --format html
qoder docs --format markdown

# 帮助
qoder --help
```

---

# Part 5

## 迁移指南

---

## 迁移路线

### 阶段 1：试点（1-2 周）

```
1. 选择一个小功能模块
2. 编写 OpenSpec 规范
3. 用 Qoder 生成代码
4. 对比手动代码
5. 团队 review
```

### 阶段 2：推广（2-4 周）

```
1. 培训团队成员
2. 制定规范编写标准
3. 集成到 CI/CD
4. 新项目使用 SDD
```

### 阶段 3：全面采用（1-2 月）

```
1. 老项目逐步迁移
2. 规范审查纳入 code review
3. 建立规范库
4. 持续优化
```

---

## 与现有工具集成

### Spring Boot

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

### Maven

```xml
<dependencies>
    <dependency>
        <groupId>io.qoder</groupId>
        <artifactId>qoder-runtime</artifactId>
        <version>1.0.0</version>
    </dependency>
</dependencies>
```

---

## CI/CD 集成

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

# Part 6

## FAQ

---

## Q1: SDD 会增加工作量吗？

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

---

## Q2: 规范会不会很复杂？

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
    public RegisterResponse register(RegisterRequest request) {
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
```

---

## Q3: AI 生成的代码可靠吗？

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

---

## Q4: 如何处理复杂业务逻辑？

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

---

## Q5: 团队如何协作？

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

## 总结

### SDD 核心价值

| 维度 | 传统开发 | SDD |
|------|----------|-----|
| 需求理解 | 容易偏差 | 规范明确 |
| 代码质量 | 依赖个人 | 规范保证 |
| 文档 | 容易过时 | 永远同步 |
| AI 协作 | 困难 | 天然友好 |
| 团队协作 | 沟通成本高 | 规范即契约 |

---

## 何时使用 SDD

**✅ 适合：**

- 新项目
- 接口驱动开发
- 需要 AI 协作
- 团队协作

**⚠️ 谨慎：**

- 探索性项目（需求不明确）
- 原型开发（快速迭代）
- 超小项目（一人开发）

---

## 下一步

1. **学习** — 阅读详细文档
2. **实践** — 创建试点项目
3. **分享** — 团队内部分享
4. **优化** — 持续改进流程

---

## 参考资料

- **详细文档：** [guide-for-java-team.md](./guide-for-java-team.md)
- **规范指南：** [QODER-SPEC.md](./QODER-SPEC.md)
- **示例项目：** [example-todo-app.yaml](./example-todo-app.yaml)
- **快速开始：** [README.md](./README.md)

---

# Q&A

## 谢谢！

**GitHub:** [xiaochi-cloud/learning-ai](https://github.com/xiaochi-cloud/learning-ai)

**问题？**

---

**备注：**

- 本 PPT 使用 Markdown 格式，可用 Markdown Viewer 或转为 PPT
- 建议配合现场演示效果更佳
- 演示时间：60-90 分钟（含 Q&A）
