# 📖 快速上手指南

> 30 分钟学会 SDD + Qoder，开始规范驱动开发

**预计时间：** 30 分钟 | **优先级：** P0 | **适合：** Java 开发者

---

## 🎯 学完你能做什么

完成本指南后，你将能够：

- ✅ 编写 OpenSpec 规范
- ✅ 用 Qoder 生成 Java 代码
- ✅ 生成单元测试
- ✅ 运行和验证

---

## 📋 前置要求

- ✅ Java 基础（1 年以上）
- ✅ Spring Boot 基础
- ✅ Maven/Gradle 基础
- ✅ 命令行基础

**不需要：** AI 经验、规范编写经验

---

## 🚀 完整流程（30 分钟）

### 步骤 1：环境准备（5 分钟）

#### 1.1 安装 Java 环境

```bash
# 验证 Java
java -version  # 需要 Java 11+

# 如未安装
# macOS
brew install openjdk@11

# Ubuntu
sudo apt install openjdk-11-jdk
```

#### 1.2 安装 Qoder CLI

```bash
# 方法 1：pip 安装
pip install qoder-cli

# 方法 2：下载二进制
wget https://github.com/qoder-ai/qoder/releases/latest/download/qoder-linux
chmod +x qoder-linux
sudo mv qoder-linux /usr/local/bin/qoder

# 验证安装
qoder --version  # 应显示版本号
```

#### 1.3 安装 IDE 插件（可选）

```
IntelliJ IDEA:
1. File → Settings → Plugins
2. 搜索 "OpenSpec"
3. 安装并重启
```

---

### 步骤 2：创建项目（5 分钟）

#### 2.1 初始化项目

```bash
# 创建项目目录
mkdir todo-app
cd todo-app

# 初始化 SDD 项目
qoder init --lang java --name todo-app

# 查看目录结构
tree -L 2
# .openspec/
# ├── project.yaml
# ├── features/
# ├── models/
# └── apis/
# pom.xml
# README.md
```

#### 2.2 理解目录结构

```
todo-app/
├── .openspec/          # 规范目录（核心）
│   ├── project.yaml    # 项目规范
│   ├── features/       # 功能规范
│   ├── models/         # 数据模型
│   └── apis/           # API 接口
├── src/
│   ├── main/java/      # 源代码（生成）
│   └── test/java/      # 测试代码（生成）
├── pom.xml             # Maven 配置
└── README.md           # 项目说明
```

---

### 步骤 3：编写第一个规范（10 分钟）

#### 3.1 创建功能规范

创建文件 `.openspec/features/create-todo.yaml`：

```yaml
meta:
  id: F001
  name: 创建待办
  version: 1.0.0
  description: 用户可以创建新的待办事项

spec:
  features:
    - id: F001-01
      name: 创建待办事项
      description: 用户创建新的待办
      
      inputs:
        - name: title
          type: string
          min_length: 1
          max_length: 200
          required: true
          description: 待办标题
          
        - name: description
          type: string
          max_length: 1000
          required: false
          description: 待办描述
          
        - name: priority
          type: enum
          values: [low, medium, high]
          default: medium
          required: false
          description: 优先级
      
      outputs:
        - name: todo_id
          type: string
          format: uuid
          description: 待办 ID
        - name: created_at
          type: datetime
          description: 创建时间
      
      constraints:
        - 标题不能为空
        - 标题长度不超过 200 字符
        - 优先级默认中等
      
      business_rules:
        - R001: 同一天不能有重复标题的待办
      
      acceptance_criteria:
        - 有效输入能成功创建待办
        - 返回待办 ID 和创建时间
        - 标题为空返回明确错误
```

#### 3.2 验证规范

```bash
# 验证规范语法
qoder validate

# 检查规范完整性
qoder check

# 查看规范统计
qoder stats
```

---

### 步骤 4：生成代码（5 分钟）

#### 4.1 生成 Java 代码

```bash
# 生成代码
qoder generate --feature F001-01 --lang java

# 查看生成的代码
tree src/
# src/
# ├── main/java/
# │   └── com/example/todo/
# │       ├── Todo.java
# │       ├── TodoService.java
# │       └── TodoServiceImpl.java
# └── test/java/
#     └── com/example/todo/
#         └── TodoServiceTest.java
```

#### 4.2 查看生成的代码

**接口：** `src/main/java/com/example/todo/TodoService.java`

```java
package com.example.todo;

import java.time.LocalDateTime;

/**
 * 待办服务
 * 功能：创建待办事项
 * 规范版本：1.0.0
 */
public interface TodoService {
    
    /**
     * 创建待办事项
     * 
     * @param title 标题（1-200 字符）
     * @param description 描述（可选）
     * @param priority 优先级（low/medium/high）
     * @return 待办 ID
     * @throws InvalidTitleException 标题无效
     */
    String createTodo(
        String title,
        String description,
        String priority
    ) throws InvalidTitleException;
}
```

**实现：** `src/main/java/com/example/todo/TodoServiceImpl.java`

```java
package com.example.todo;

import org.springframework.stereotype.Service;
import java.time.LocalDateTime;
import java.util.UUID;

/**
 * 待办服务实现
 * 基于 OpenSpec 规范生成
 */
@Service
public class TodoServiceImpl implements TodoService {
    
    @Override
    public String createTodo(
        String title,
        String description,
        String priority
    ) throws InvalidTitleException {
        
        // 验证标题（约束：1-200 字符）
        if (title == null || title.trim().isEmpty()) {
            throw new InvalidTitleException("标题不能为空");
        }
        
        if (title.length() > 200) {
            throw new InvalidTitleException("标题长度不能超过 200 字符");
        }
        
        // 创建待办
        String todoId = UUID.randomUUID().toString();
        LocalDateTime createdAt = LocalDateTime.now();
        
        // TODO: 保存到数据库
        
        return todoId;
    }
}
```

---

### 步骤 5：生成测试（3 分钟）

#### 5.1 生成单元测试

```bash
# 生成测试
qoder generate --tests --feature F001-01

# 查看测试代码
cat src/test/java/com/example/todo/TodoServiceTest.java
```

#### 5.2 运行测试

```bash
# 运行测试
mvn test

# 预期输出
[INFO] Tests run: 5, Failures: 0, Errors: 0, Skipped: 0
[INFO] BUILD SUCCESS
```

---

### 步骤 6：完善业务逻辑（2 分钟）

#### 6.1 添加数据库支持

编辑 `TodoServiceImpl.java`：

```java
@Service
public class TodoServiceImpl implements TodoService {
    
    @Autowired
    private TodoRepository todoRepository;  // 添加
    
    @Override
    public String createTodo(...) {
        // ... 验证代码
        
        // 创建待办对象
        Todo todo = new Todo();
        todo.setId(todoId);
        todo.setTitle(title);
        todo.setDescription(description);
        todo.setPriority(priority);
        todo.setCreatedAt(createdAt);
        todo.setStatus("pending");
        
        // 保存到数据库
        todoRepository.save(todo);  // 添加
        
        return todoId;
    }
}
```

#### 6.2 重新验证

```bash
# 重新运行测试
mvn test

# 确保所有测试通过
```

---

## ✅ 检查清单

完成本指南后，检查：

- [ ] Qoder CLI 安装成功
- [ ] 项目初始化成功
- [ ] 规范文件创建成功
- [ ] 规范验证通过
- [ ] 代码生成成功
- [ ] 测试生成成功
- [ ] 所有测试通过
- [ ] 能运行项目

**全部完成？恭喜！你已经掌握了 SDD 基础！**

---

## 🎁 模板库

### 功能规范模板

```yaml
meta:
  id: F001
  name: 功能名称
  version: 1.0.0
  description: 功能描述

spec:
  features:
    - inputs: [...]
      outputs: [...]
      constraints: [...]
      business_rules: [...]
      acceptance_criteria: [...]
```

### 数据模型模板

```yaml
meta:
  name: 模型名称
  version: 1.0.0

spec:
  fields:
    - name: 字段名
      type: 类型
      required: true/false
      description: 描述
```

### API 接口模板

```yaml
meta:
  name: API 名称
  version: 1.0.0

spec:
  endpoints:
    - path: /api/xxx
      method: GET/POST
      request: {...}
      response: {...}
```

---

## 📚 延伸学习

### 下一步

- [深入指南](./02-DEEP-GUIDE.md) — 完整理解 SDD
- [演示项目](./demo-project/) — 完整示例
- [PPT 演示稿](./03-PRESENTATION.md) — 团队分享

### 参考资料

- [OpenSpec 格式详解](./02-openspec-format.md)
- [SDD 最佳实践](./01-sdd-best-practices.md)
- [Java 团队指南](./guide-for-java-team.md)

---

## ❓ 常见问题

### Q: 生成的代码能修改吗？

**A:** 可以！生成的代码在 `src/generated/`，手写的在 `src/custom/`。

### Q: 规范可以迭代吗？

**A:** 可以！修改规范后重新运行 `qoder generate`。

### Q: 如何团队协作？

**A:** 规范审查 → 生成代码 → 代码审查 → 合并。

---

## 🎯 行动号召

### 今天
- [x] 完成快速指南 ✅
- [ ] 创建自己的第一个规范

### 本周
- [ ] 完成一个小功能（如用户注册）
- [ ] 生成代码并运行

### 本月
- [ ] 试点项目上线
- [ ] 团队内部分享

---

**📊 难度：** ⭐⭐☆☆☆  
**📝 预计时间：** 30 分钟  
**🏷️ 标签：** #quickstart #guide #sdd #java

**最后更新：** 2026-03-11 | **版本：** v1.0

---

**完成快速指南了？继续深入学习！** → [02-DEEP-GUIDE.md](./02-DEEP-GUIDE.md)
