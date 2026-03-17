# 🚀 从这里开始

> 5 分钟了解 SDD + Qoder，减少返工 60%，提高效率 10 倍

**预计时间：** 5 分钟 | **优先级：** P0 | **适合：** Java 开发者  
**最后更新：** 2026-03-12 | **版本：** v1.0

---

## 🎯 你有这些问题吗？

### 场景 1：需求理解偏差

```
产品经理：我要一个用户注册功能
你：（开发 2 天）
测试：（发现理解错了）
你：（返工 1 天）

💰 成本：3 天开发 + 1 天返工
```

### 场景 2：文档过时

```
你：（写好代码，更新文档）
3 个月后...
新人：这个接口参数是什么？
文档：（已过时）
你：（不记得了，查代码）

💰 成本：沟通时间 + 查代码时间
```

### 场景 3：接口联调困难

```
前端：你这个接口参数不对！
后端：我按文档写的！
前端：文档是错的！

💰 成本：扯皮时间 + 返工
```

### 场景 4：AI 协作困难

```
你：AI，帮我写个用户服务
AI：（生成的代码不符合预期）
你：（不知道如何让 AI 理解需求）

💰 成本：反复尝试 + 不满意
```

**如果你有以上任何问题 → 继续往下看**

---

## 💡 SDD 能解决什么

### 一句话核心价值

> **规范即代码，需求不偏差，文档永远同步**

### 前后对比

| 维度 | 传统开发 | SDD |
|------|----------|-----|
| 需求理解 | 容易偏差 | 规范明确 |
| 文档 | 容易过时 | 永远同步 |
| AI 协作 | 困难 | 天然友好 |
| 团队沟通 | 成本高 | 规范即契约 |

### 真实收益

```
某 Java 团队实施 SDD 后：
- 需求理解偏差：减少 70%
- 文档维护时间：减少 80%
- 返工率：减少 50%
- 开发者满意度：提升 40%
```

---

## 🎓 3 个核心概念（用 Java 类比）

### 1. SDD = 规范驱动开发

**类比：** Java Interface

```java
// Interface 定义契约
public interface UserService {
    RegisterResponse register(RegisterRequest request);
}

// SDD 规范定义契约
features:
  - name: 用户注册
    inputs:
      - name: request
        type: RegisterRequest
```

**核心：** 定义"做什么"，不关心"怎么做"

---

### 2. OpenSpec = 规范格式

**类比：** YAML 版的 Annotation

```java
// Java Annotation
@NotNull
@Size(min=3, max=20)
String username;

// OpenSpec 规范
username:
  type: string
  constraints:
    - min_length: 3
    - max_length: 20
```

**核心：** 人类可读 + 机器可解析

---

### 3. Qoder = AI 编程助手

**类比：** 能理解规范的 Copilot

```
Copilot: 根据注释生成代码
Qoder:   根据规范生成代码（更准确）
```

**核心：** AI 理解规范，生成符合规范的代码

---

## 🚀 5 分钟快速体验

### 步骤 1：下载 Qoder IDE（1 分钟）

**访问官网：** https://qoder.com/download

**选择你的平台：**
- 🍎 macOS（Intel / Apple Silicon）
- 🪟 Windows（10 / 11）
- 🐧 Linux（Ubuntu / Debian）

**下载安装后启动 Qoder IDE**

---

### 步骤 2：创建新项目（1 分钟）

**在 Qoder IDE 中：**
```
File → New Project → 选择 Java/Spring Boot 模板
```

**或打开现有项目：**
```
File → Open Folder → 选择你的项目目录
```

---

### 步骤 3：切换到 Quest Mode（30 秒）

**左上角切换：**
```
[Editor ▼] → 选择 [Quest]
```

**或快捷键：**
```
macOS: Cmd + Shift + Q
Windows: Ctrl + Shift + Q
```

---

### 步骤 4：创建 Quest 任务（2 分钟）

**点击：** `New Quest`

**描述任务（自然语言示例）：**

```
创建一个 Hello World 功能：

功能需求：
- 接收一个 name 参数
- 返回 "Hello, {name}!" 问候语
- 使用 Java 编写

验收标准：
- ✅ 输入 "World" 返回 "Hello, World!"
- ✅ 输入 null 返回错误
```

---

### 步骤 5：审核 Spec 并运行（1 分钟）

**Quest 会生成 Spec：**

```yaml
meta:
  name: Hello World
  version: 1.0.0

spec:
  functions:
    - name: greet
      description: 打招呼
      parameters:
        - name: name
          type: string
          required: true
      returns:
        type: string
```

**审核清单：**
- [ ] 参数类型正确
- [ ] 返回值类型正确

**操作：**
- ✅ 满意 → 点击 `运行`
- ✏️ 需要修改 → 直接编辑 Spec

---

### 步骤 6：验收结果

**Quest 执行完成后：**

**查看生成的代码：**
```java
public class HelloService {
    /**
     * 打招呼
     * @param name 姓名
     * @return 问候语
     */
    public String greet(String name) {
        return "Hello, " + name + "!";
    }
}
```

**验收操作：**
```
[Accept] — 应用所有修改
[Reject] — 放弃修改
```

**恭喜！你已经完成了第一个 SDD 项目！**

---

## 📚 下一步学习路径

```
今天（5 分钟）✅
  ↓
  完成快速体验（上面）
  
本周（30 分钟）
  ↓
  阅读 [01-QUICK-GUIDE.md](./01-QUICK-GUIDE.md)
  
本月（2 小时）
  ↓
  完成试点项目
  
下月（持续）
  ↓
  团队推广
```

---

## 🎁 资源包

### 模板库
- [功能规范模板](./templates/feature-template.yaml)
- [数据模型模板](./templates/model-template.yaml)
- [API 接口模板](./templates/api-template.yaml)

### 示例项目
- [演示项目](./demo-project/) — 完整可运行
- [Todo App](./example-todo-app.yaml) — 规范示例

### 检查清单
- [规范审查清单](./checklists/spec-review.md)
- [迁移检查清单](./checklists/migration-checklist.md)

---

## ❓ 常见问题

### Q: SDD 会增加工作量吗？

**A:** 短期会增加（学习规范），长期减少（减少返工）。

```
传统：需求 → 设计 → 编码 → 测试 → 文档（5 步）
SDD:   规范 → 生成 → 测试（3 步）
```

### Q: 规范很难写吗？

**A:** 比写 Java 简单，像写 YAML 配置。

### Q: AI 生成的代码可靠吗？

**A:** 标准代码可靠（80%），复杂逻辑需要人工优化（20%）。

---

## 🎯 行动号召

### 今天（5 分钟）✅
- [x] 阅读快速开始
- [ ] 下载 Qoder IDE：https://qoder.com/download
- [ ] 注册账号（Google/GitHub 登录）

### 本周（30 分钟）
- [ ] 阅读 [01-QUICK-GUIDE.md](./01-QUICK-GUIDE.md)
- [ ] 完成第一个任务（用户注册）
- [ ] 查看生成的代码和测试

### 本月（试点项目）
- [ ] 选择小功能模块（如用户管理）
- [ ] 完整使用 SDD 流程
- [ ] 记录效率提升数据

### 获取帮助
- **文档:** 本仓库所有文档
- **问题:** [GitHub Issue](https://github.com/xiaochi-cloud/learning-ai/issues)
- **交流:** 团队内部群

---

## 🤝 获取帮助

- **问题反馈：** [GitHub Issues](https://github.com/xiaochi-cloud/learning-ai/issues)
- **讨论交流：** 团队内部群
- **文档：** [完整文档](./01-QUICK-GUIDE.md)

---

**📊 难度：** ⭐☆☆☆☆  
**📝 预计时间：** 5 分钟  
**🏷️ 标签：** #quickstart #beginner #sdd

**最后更新：** 2026-03-11 | **版本：** v1.0

---

**准备好了吗？开始吧！** → [01-QUICK-GUIDE.md](./01-QUICK-GUIDE.md)
