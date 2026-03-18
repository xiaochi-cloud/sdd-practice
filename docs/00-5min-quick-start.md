# 5 分钟快速开始

> 快速体验 SDD 规范驱动开发

**预计时间：** 5 分钟  
**难度：** ⭐☆☆☆☆  
**前置要求：** 无

---

## 🎯 你将学到

- 什么是 SDD
- 如何查看示例
- 如何运行第一个示例

---

## 📋 步骤 1：克隆项目（1 分钟）

```bash
git clone https://github.com/xiaochi-cloud/sdd-practice.git
cd sdd-practice
```

---

## 📋 步骤 2：查看示例（2 分钟）

```bash
# 查看所有示例
ls examples/

# 输出：
# user-management    用户管理系统
# order-system       订单处理系统
# data-platform      数据分析平台
```

**示例说明：**

| 示例 | 功能 | 技术栈 |
|------|------|--------|
| user-management | 用户 CRUD | Spring Boot + MySQL |
| order-system | 订单处理 | Spring Boot + JWT |
| data-platform | 数据分析 | Python + Pandas |

---

## 📋 步骤 3：运行示例（2 分钟）

```bash
# 进入用户管理示例
cd examples/user-management

# 运行测试
mvn test

# 预期输出：
# Tests run: 5, Failures: 0, Errors: 0, Skipped: 0
# BUILD SUCCESS
```

**测试覆盖：**
- ✅ 用户注册
- ✅ 用户登录
- ✅ 用户信息更新
- ✅ 用户删除
- ✅ 密码加密

---

## 🎉 完成！

你已经成功运行了第一个 SDD 示例！

---

## 📚 下一步

- [01-30min-tutorial.md](./01-30min-tutorial.md) - 30 分钟完整教程
- [02-sdd-introduction.md](./02-sdd-introduction.md) - SDD 介绍
- [../examples/user-management/README.md](../examples/user-management/README.md) - 详细文档

---

## ❓ 常见问题

**Q: 需要安装 Java 吗？**

A: 是的，需要 Java 11+。运行 `java -version` 检查。

**Q: 测试失败怎么办？**

A: 检查 Maven 配置，运行 `mvn clean test`。

**Q: 如何贡献？**

A: 查看 [../community/contribute/how-to-contribute.md](../community/contribute/how-to-contribute.md)

---

**最后更新：** 2026-03-18  
**维护者：** 池少团队
