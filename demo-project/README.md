# Demo Project - 演示项目

> 可运行的 SDD 示例项目

**预计时间：** 15 分钟 | **难度：** ⭐⭐☆☆☆

---

## 🎯 项目说明

这是一个完整的 SDD 示例项目，包含：

- ✅ OpenSpec 规范
- ✅ Java 源代码
- ✅ 单元测试
- ✅ 可运行

---

## 📁 项目结构

```
demo-project/
├── .openspec/
│   ├── project.yaml          # 项目规范
│   ├── features/
│   │   └── user-register.yaml  # 用户注册规范
│   ├── models/
│   │   └── user.yaml         # 用户模型
│   └── apis/
│       └── user-api.yaml     # API 规范
├── src/
│   ├── main/java/
│   │   └── com/example/demo/
│   │       ├── User.java
│   │       ├── UserService.java
│   │       └── UserServiceImpl.java
│   └── test/java/
│       └── com/example/demo/
│           └── UserServiceTest.java
├── pom.xml
└── README.md
```

---

## 🚀 快速开始

### 步骤 1：查看规范

```bash
cd demo-project
cat .openspec/features/user-register.yaml
```

### 步骤 2：生成代码

```bash
qoder generate --all
```

### 步骤 3：运行测试

```bash
mvn test
```

### 步骤 4：运行项目

```bash
mvn spring-boot:run
```

---

## 📋 规范说明

### 功能：用户注册

**输入：**
- username（用户名）
- email（邮箱）
- password（密码）

**输出：**
- user_id（用户 ID）
- token（访问令牌）

**业务规则：**
- R001: 用户名唯一
- R002: 邮箱唯一
- R003: 密码强度
- R004: 自动登录

### 数据模型：User

**字段：**
- id（UUID）
- username（唯一）
- email（唯一）
- password_hash（BCrypt）
- status（active/inactive/banned）
- created_at
- updated_at
- last_login_at

---

## ✅ 验收标准

| 标准 | 测试方法 | 预期结果 |
|------|----------|----------|
| AC001 | 有效输入注册 | 201 Created + user_id + token |
| AC002 | 重复用户名 | 409 Conflict + USER_EXISTS |
| AC003 | 重复邮箱 | 409 Conflict + EMAIL_EXISTS |
| AC004 | 弱密码 | 400 Bad Request + WEAK_PASSWORD |
| AC005 | 无效用户名 | 400 Bad Request + INVALID_USERNAME |

---

## 🔍 代码说明

### UserService.java

```java
public interface UserService {
    /**
     * 用户注册
     * @param request 注册请求
     * @return 注册结果（user_id + token）
     */
    RegisterResponse register(RegisterRequest request);
}
```

### UserServiceImpl.java

```java
@Service
public class UserServiceImpl implements UserService {
    @Override
    public RegisterResponse register(RegisterRequest request) {
        // 1. 验证用户名格式（R001）
        // 2. 验证密码强度（R003）
        // 3. 检查用户名重复（R001）
        // 4. 检查邮箱重复（R002）
        // 5. 加密密码
        // 6. 保存用户
        // 7. 生成 Token（R004）
        // 8. 返回结果
    }
}
```

---

## 📚 延伸学习

- [00-START-HERE.md](../00-START-HERE.md) - 快速开始
- [01-QUICK-GUIDE.md](../01-QUICK-GUIDE.md) - 快速指南
- [templates/](../templates/) - 模板库

---

**最后更新：** 2026-03-11 | **版本：** v1.0
