# 用户管理系统示例

> 完整的 SDD 实战项目

## 快速开始

```bash
# 克隆项目
git clone https://github.com/xiaochi-cloud/sdd-practice.git
cd sdd-practice/examples/user-management

# 安装依赖
mvn install

# 运行测试
mvn test

# 启动应用
mvn spring-boot:run
```

## 项目结构

```
user-management/
├── .openspec/          # SDD 规范
├── src/               # 源代码
├── tests/             # 测试代码
└── README.md
```

## 功能特性

- ✅ 用户注册（SDD 规范驱动）
- ✅ 用户登录（JWT 认证）
- ✅ 用户管理（CRUD 操作）
- ✅ 密码加密（BCrypt）
- ✅ 测试覆盖（80%+）

## 技术栈

- Spring Boot 3
- MySQL
- JWT
- BCrypt
- JUnit 5
