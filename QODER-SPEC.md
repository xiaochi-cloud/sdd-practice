# Qoder 项目规范 - SDD 最佳实践

> 🎯 一句话核心：**用 OpenSpec 格式编写规范，让 AI 理解项目意图，实现规范驱动开发**

**版本：** v0.1 | **创建日期：** 2026-03-11 | **适用：** AI Coding Agent 项目

---

## 📋 目录

1. [什么是 Qoder](#什么是-qoder)
2. [SDD 核心理念](#sdd-核心理念)
3. [OpenSpec 规范格式](#openspec-规范格式)
4. [项目结构规范](#项目结构规范)
5. [规范编写模板](#规范编写模板)
6. [AI 协作流程](#ai-协作流程)
7. [最佳实践](#最佳实践)
8. [示例项目](#示例项目)

---

## 什么是 Qoder

### 定义

**Qoder** 是一个基于规范的开发（Specification-Driven Development, SDD）框架，使用 OpenSpec 格式编写项目规范，让 AI Coding Agent 理解项目意图并自动生成代码。

### 核心价值

```
传统开发：需求 → 设计 → 编码 → 测试
           ↓ 容易信息丢失
           
SDD 开发：规范 (OpenSpec) → AI 生成代码 → 测试
           ↓ 规范即代码，意图不丢失
```

### 为什么需要 SDD

| 问题 | 传统开发 | SDD |
|------|----------|-----|
| 需求理解偏差 | 常见 | 规范明确，减少偏差 |
| 代码质量 | 依赖个人能力 | 规范保证一致性 |
| 维护成本 | 高（文档过时） | 低（规范即文档） |
| AI 协作 | 困难（上下文缺失） | 容易（规范提供上下文） |

---

## SDD 核心理念

### 1. 规范先行

```
❌ 错误：先写代码，后补文档
✅ 正确：先写规范，再生成代码
```

**流程：**
```
1. 编写 OpenSpec 规范
2. AI 理解规范
3. AI 生成代码
4. 测试验证
5. 规范更新（如有变更）
```

### 2. 规范即代码

- 规范文件版本管理（Git）
- 规范审查 = 代码审查
- 规范变更 = 代码变更

### 3. 机器可读

- 人类可读（Markdown/YAML）
- 机器可解析（JSON Schema）
- 可自动化（CI/CD 集成）

### 4. 渐进式完善

```
v0.1: 核心功能规范
  ↓
v0.2: 添加 API 规范
  ↓
v0.3: 添加数据模型
  ↓
v1.0: 完整规范
```

---

## OpenSpec 规范格式

### 规范结构

```yaml
# OpenSpec v1.0
meta:
  name: 项目名称
  version: 1.0.0
  description: 项目描述
  author: 作者

spec:
  # 功能规范
  features:
    - id: F001
      name: 功能名称
      description: 功能描述
      inputs: [...]
      outputs: [...]
      constraints: [...]
  
  # 数据模型
  models:
    - name: 模型名
      fields:
        - name: 字段名
          type: 类型
          required: true
  
  # API 规范
  apis:
    - path: /api/endpoint
      method: GET/POST
      request: {...}
      response: {...}
  
  # 业务规则
  rules:
    - id: R001
      condition: 条件
      action: 动作
```

### 规范要素

| 要素 | 说明 | 必需 |
|------|------|------|
| meta | 元数据（名称、版本等） | ✅ |
| features | 功能列表 | ✅ |
| models | 数据模型 | ✅ |
| apis | API 接口 | 可选 |
| rules | 业务规则 | 可选 |
| tests | 测试用例 | 可选 |

---

## 项目结构规范

### 标准目录

```
project-name/
├── .openspec/              # OpenSpec 规范目录
│   ├── project.yaml        # 项目规范
│   ├── features/           # 功能规范
│   │   ├── F001-user-auth.yaml
│   │   └── F002-data-process.yaml
│   ├── models/             # 数据模型
│   │   └── schema.yaml
│   └── apis/               # API 规范
│       └── endpoints.yaml
│
├── src/                    # 源代码
│   ├── generated/          # AI 生成的代码
│   └── custom/             # 手写代码
│
├── tests/                  # 测试代码
│   ├── unit/               # 单元测试
│   └── integration/        # 集成测试
│
├── docs/                   # 文档
│   ├── api.md              # API 文档
│   └── user-guide.md       # 用户指南
│
├── scripts/                # 脚本工具
│   ├── generate.py         # 代码生成脚本
│   └── validate.py         # 规范验证脚本
│
└── README.md               # 项目说明
```

### 文件命名规范

| 类型 | 命名规则 | 示例 |
|------|----------|------|
| 规范文件 | `类型 - 名称.yaml` | `feature-user-auth.yaml` |
| 代码文件 | `功能_模块.py` | `user_auth_service.py` |
| 测试文件 | `test_功能.py` | `test_user_auth.py` |
| 文档文件 | `名称.md` | `api-doc.md` |

---

## 规范编写模板

### 模板 1：功能规范

```yaml
# feature-xxx.yaml
meta:
  id: F001
  name: 用户认证
  version: 1.0.0
  priority: high

description: |
  实现用户登录、注册、登出功能
  支持邮箱和密码认证

inputs:
  - name: email
    type: string
    format: email
    required: true
  - name: password
    type: string
    min_length: 8
    required: true

outputs:
  - name: token
    type: string
    description: JWT 访问令牌
  - name: user_id
    type: string
    description: 用户 ID

constraints:
  - 密码必须加密存储
  - Token 有效期 24 小时
  - 支持刷新 Token

business_rules:
  - R001: 连续 5 次密码错误，锁定账户 30 分钟
  - R002: 新用户需要邮箱验证

acceptance_criteria:
  - 正确密码能成功登录
  - 错误密码返回明确错误
  - Token 可验证用户身份
```

### 模板 2：数据模型

```yaml
# model-xxx.yaml
meta:
  name: User
  version: 1.0.0
  description: 用户模型

fields:
  - name: id
    type: string
    format: uuid
    primary_key: true
    description: 用户 ID
  
  - name: email
    type: string
    format: email
    unique: true
    required: true
    description: 邮箱地址
  
  - name: password_hash
    type: string
    required: true
    description: 密码哈希
  
  - name: created_at
    type: datetime
    default: now()
    description: 创建时间
  
  - name: updated_at
    type: datetime
    default: now()
    description: 更新时间

relationships:
  - type: one-to-many
    target: Order
    field: user_id

indexes:
  - fields: [email]
    unique: true
  - fields: [created_at]
```

### 模板 3：API 规范

```yaml
# api-xxx.yaml
meta:
  name: User API
  version: 1.0.0

endpoints:
  - path: /api/v1/users
    method: POST
    name: 创建用户
    description: 注册新用户
    
    request:
      content_type: application/json
      body:
        email: string
        password: string
    
    response:
      success:
        status: 201
        body:
          user_id: string
          token: string
      error:
        status: 400
        body:
          error: string
          message: string
    
    errors:
      - code: USER_EXISTS
        message: 用户已存在
      - code: INVALID_EMAIL
        message: 邮箱格式无效
```

---

## AI 协作流程

### 完整流程

```
┌─────────────────────────────────────────────────────────────┐
│                  SDD + AI 协作流程                          │
├─────────────────────────────────────────────────────────────┤
│                                                             │
│  1. 编写规范                                                 │
│     ┌───────────┐                                           │
│     │ OpenSpec  │                                           │
│     └─────┬─────┘                                           │
│           │                                                 │
│           ↓                                                 │
│  2. AI 理解规范                                              │
│     ┌───────────┐                                           │
│     │ 解析规范  │                                           │
│     │ 提取意图  │                                           │
│     └─────┬─────┘                                           │
│           │                                                 │
│           ↓                                                 │
│  3. AI 生成代码                                              │
│     ┌───────────┐                                           │
│     │ 生成代码  │                                           │
│     │ 添加注释  │                                           │
│     └─────┬─────┘                                           │
│           │                                                 │
│           ↓                                                 │
│  4. 测试验证                                                 │
│     ┌───────────┐                                           │
│     │ 运行测试  │                                           │
│     │ 验证规范  │                                           │
│     └─────┬─────┘                                           │
│           │                                                 │
│           ↓                                                 │
│  5. 迭代优化                                                 │
│     ┌───────────┐                                           │
│     │ 更新规范  │                                           │
│     │ 重新生成  │                                           │
│     └───────────┘                                           │
│                                                             │
└─────────────────────────────────────────────────────────────┘
```

### Prompt 模板

**让 AI 理解规范：**

```
你是一位资深软件工程师，请根据以下 OpenSpec 规范生成代码。

【规范内容】
[粘贴 OpenSpec YAML]

【要求】
1. 使用 Python 3.9+
2. 遵循 PEP 8 规范
3. 添加类型注解
4. 包含文档字符串
5. 实现所有功能点

【输出格式】
- 代码文件：src/generated/xxx.py
- 测试文件：tests/test_xxx.py
- 说明文件：docs/xxx.md
```

**让 AI 验证规范：**

```
请审查以下 OpenSpec 规范：

【规范内容】
[粘贴 OpenSpec YAML]

【审查要点】
1. 规范是否完整（输入、输出、约束）
2. 是否有歧义或冲突
3. 是否遗漏边界情况
4. 业务规则是否清晰
5. 测试用例是否覆盖

【输出】
- 问题列表
- 改进建议
- 补充内容
```

---

## 最佳实践

### 1. 规范编写

✅ **应该做的：**

- 用简单清晰的语言
- 提供具体示例
- 定义验收标准
- 版本管理规范
- 保持规范更新

❌ **不应该做的：**

- 模糊描述（"处理数据"）
- 遗漏边界情况
- 规范与代码脱节
- 过度设计

### 2. AI 协作

✅ **应该做的：**

- 提供完整上下文
- 分步骤生成（功能 → 模块 → 代码）
- 审查 AI 输出
- 迭代优化

❌ **不应该做的：**

- 一次性生成全部代码
- 盲目信任 AI 输出
- 不测试就使用

### 3. 质量保证

✅ **应该做的：**

- 规范审查（同行评审）
- 自动化测试
- 持续集成
- 文档同步更新

---

## 示例项目

### 项目：待办事项管理

**规范文件：** `.openspec/project.yaml`

```yaml
meta:
  name: Todo App
  version: 1.0.0
  description: 个人待办事项管理应用

spec:
  features:
    - id: F001
      name: 创建待办
      description: 用户可以创建新的待办事项
      inputs:
        - name: title
          type: string
          max_length: 200
          required: true
        - name: description
          type: string
          required: false
        - name: due_date
          type: date
          required: false
      outputs:
        - name: todo_id
          type: string
      constraints:
        - 标题不能为空
        - 标题长度不超过 200 字符
    
    - id: F002
      name: 完成待办
      description: 标记待办事项为已完成
      inputs:
        - name: todo_id
          type: string
          required: true
      outputs:
        - name: success
          type: boolean
      constraints:
        - 只能完成未完成的待办
  
  models:
    - name: Todo
      fields:
        - name: id
          type: string
          format: uuid
        - name: title
          type: string
        - name: description
          type: string
        - name: status
          type: enum
          values: [pending, completed, cancelled]
        - name: created_at
          type: datetime
        - name: completed_at
          type: datetime
  
  apis:
    - path: /api/todos
      method: POST
      request:
        title: string
        description: string
      response:
        todo_id: string
    
    - path: /api/todos/{id}
      method: GET
      response:
        todo: Todo
```

---

## 📊 检查清单

### 规范审查清单

- [ ] 元数据完整（名称、版本、描述）
- [ ] 功能定义清晰
- [ ] 输入输出明确
- [ ] 约束条件完整
- [ ] 业务规则无歧义
- [ ] 数据模型合理
- [ ] API 设计一致
- [ ] 验收标准可测试

### AI 生成代码审查清单

- [ ] 代码符合规范
- [ ] 类型注解完整
- [ ] 错误处理正确
- [ ] 测试覆盖关键路径
- [ ] 文档字符串清晰
- [ ] 遵循编码规范

---

## 🔗 延伸学习

- [OpenSpec 官方文档](https://openspec.dev/)
- [SDD 最佳实践](https://specification-driven-development.org/)
- [AI Coding Agent 指南](../../01-knowledge/claude-deep-dive/)

---

**📊 难度：** ⭐⭐⭐⭐☆  
**📝 预计时间：** 60 分钟  
**🏷️ 标签：** #qoder #sdd #openspec #best-practices

**最后更新：** 2026-03-11 | **版本：** v0.1
