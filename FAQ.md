# 常见问题 (FAQ)

> Qoder + SDD 常见问题解答

**最后更新：** 2026-03-12 | **版本：** v2.0 | **状态：** ✅ 完成

---

## 📚 基础概念（1-5）

### Q1: SDD 是什么？

**A:** SDD = Specification-Driven Development（规范驱动开发）

**核心思想：** 先编写规范（Spec），再基于规范开发。

```
传统开发：
需求 → 设计 → 编码 → 测试 → 文档
（容易信息丢失，返工率高）

SDD 开发：
规范 → AI 生成 → 测试 → 迭代
（规范即代码，意图不丢失）
```

**核心价值：**
- ✅ 减少返工 60%（需求明确）
- ✅ 提高效率 10 倍（AI 自主编程）
- ✅ 文档永远同步（Spec 即文档）

---

### Q2: Qoder 是什么？

**A:** Qoder = Agentic 编码平台

**核心能力：**
- Quest Mode：自主编程
- Spec 驱动：先对齐需求，再执行
- 多环境：Local/Parallel/Remote

**产品形态：**
- Qoder IDE（桌面应用）⭐ 推荐
- Qoder 插件（JetBrains）
- Qoder CLI（终端工具）

**官网：** https://qoder.com

---

### Q3: OpenSpec 是什么？

**A:** OpenSpec = 开放规范格式（Fission AI 开发）

**特点：**
- YAML 格式，人类可读
- 机器可解析，可生成代码
- 开源项目：github.com/Fission-AI/OpenSpec

**示例：**
```yaml
name: UserService
version: 1.0.0
functions:
  - name: createUser
    parameters:
      - name: username
        type: string
```

**注意：** OpenSpec 是开源标准，不是 Qoder 专属。

---

### Q4: Spec 驱动是什么？

**A:** Spec 驱动 = 先写规范，再生成代码

**工作流程：**
```
1. 描述需求（自然语言或 YAML）
   ↓
2. Quest 生成 Spec 文档
   ↓
3. 审核 Spec（可修改）
   ↓
4. 点击运行
   ↓
5. Quest 自主编程
   ↓
6. 验收结果（Accept/Reject）
```

**适用场景：**
- ✅ 复杂功能开发
- ✅ 需要文档留存
- ✅ 多人协作

---

### Q5: Quest Mode 是什么？

**A:** Quest Mode = Qoder 的自主编程模式

**核心能力：**
- 端到端完成开发任务
- 自主澄清需求、规划方案
- 执行代码、验证结果
- 无需持续人工介入

**核心理念：** Define the goal. Review the result.

**三种场景：**
1. Spec 驱动 - 复杂功能
2. 搭建网站 - 快速原型
3. 原型探索 - 创意实验

---

## 💻 使用问题（6-10）

### Q6: 如何开始使用 Qoder？

**A:** 7 步快速开始（10 分钟）

```
1. 下载 Qoder IDE
   https://qoder.com/download

2. 安装并打开

3. 登录账号
   - 支持 Google/GitHub 登录

4. 打开项目
   - 本地项目或克隆 GitHub

5. 切换到 Quest Mode
   - 点击左上角 Editor/Quest

6. 创建任务
   - 点击 New Quest
   - 描述需求

7. 验收结果
   - Accept 应用修改
```

详细教程：[01-QUICK-GUIDE.md](./01-QUICK-GUIDE.md)

---

### Q7: 需要付费吗？

**A:** 目前个人版免费试用。

**定价模式：**
- Pro 用户：正常使用，Credits 耗尽后无法继续
- Free 用户：需要 Credits 才能使用 Quest

**Credits 用途：**
- Quest 任务执行
- 长程任务消耗更多

**建议：** 先用免费额度体验，再决定是否升级。

---

### Q8: Spec 格式是什么？

**A:** 两种格式可选。

**1. 自然语言（推荐）**
```
创建一个用户注册功能，包含：
- 用户名、邮箱、密码
- 密码强度验证
- 用户名唯一性检查
```

**2. OpenSpec YAML（复杂功能）**
```yaml
name: UserService
functions:
  - name: createUser
    parameters:
      - name: username
        type: string
```

**建议：** 简单功能用自然语言，复杂功能用 OpenSpec。

---

### Q9: 生成的代码质量如何？

**A:** 分情况。

**标准代码（可靠）：**
- ✅ CRUD 操作
- ✅ 数据验证
- ✅ 错误处理
- ✅ 日志记录
- 质量：80-90 分

**复杂逻辑（需优化）：**
- ⚠️ 复杂业务逻辑
- ⚠️ 性能优化
- ⚠️ 安全敏感代码
- 质量：60-70 分，需人工优化

**建议：** AI 生成 80% + 人工优化 20%

---

### Q10: 支持哪些语言？

**A:** 目前支持：

- ✅ Java（最成熟）⭐
- ✅ Python
- 🔄 JavaScript/TypeScript（开发中）
- 🔄 Go（计划中）

**推荐：** Java 开发者直接使用。

---

## 🏢 团队落地（11-15）

### Q11: SDD 会增加工作量吗？

**A:** 短期会增加，长期减少。

```
传统：需求 → 设计 → 编码 → 测试 → 文档（5 步）
SDD:   规范 → 生成 → 测试（3 步）

节省：设计时间 + 编码时间 + 文档时间
```

**时间对比：**
- 第 1 周：学习成本（+20% 时间）
- 第 2 周：开始收益（-10% 时间）
- 第 3 周：稳定收益（-30% 时间）

---

### Q12: 如何集成到现有项目？

**A:** 3 种方式。

**方式 1：渐进式（推荐）**
```
1. 选择一个小功能模块
2. 用 SDD 开发
3. 集成到现有项目
```

**方式 2：新项目**
```
1. 新项目直接用 SDD
2. 老项目逐步迁移
```

**方式 3：混合开发**
```
1. 规范生成标准代码
2. 手写复杂逻辑
```

详细指南：[checklists/migration-checklist.md](./checklists/migration-checklist.md)

---

### Q13: 团队如何协作？

**A:** 规范审查流程。

```
1. 开发者编写规范
2. 提交 PR
3. 团队审查规范
   - 业务逻辑是否正确
   - 约束是否完整
   - 测试是否覆盖
4. 审查通过后生成代码
5. 代码审查
6. 合并
```

---

### Q14: 试点项目如何选择？

**A:** 选择标准。

**适合的功能：**
- ✅ 业务逻辑清晰
- ✅ 规模适中（1-2 周）
- ✅ 不依赖其他模块
- ✅ 团队熟悉领域

**不适合的功能：**
- ❌ 探索性功能（需求不明确）
- ❌ 超大规模（>1 月）
- ❌ 核心依赖复杂

---

### Q15: 如何衡量效果？

**A:** 关键指标。

**过程指标：**
- 规范覆盖率（目标：80%）
- 代码生成率（目标：50%）
- 规范审查通过率（目标：90%）

**结果指标：**
- 返工率（目标：↓60%）
- Bug 率（目标：↓50%）
- 交付周期（目标：↓40%）

---

## ❓ 其他问题（16-20）

### Q16: 演示失败怎么办？

**A:** 3 个备用方案。

**Plan A：现场演示**
- 打开 Qoder IDE
- 创建任务
- 验收结果

**Plan B：录屏演示**
- 提前录制
- 现场播放
- 避免网络问题

**Plan C：截图演示**
- 关键步骤截图
- PPT 展示
- 最保险

**建议：** 准备 Plan B 或 C 作为备用。

---

### Q17: 遇到问题怎么办？

**A:** 按顺序尝试。

```
1. 查看文档
   https://github.com/xiaochi-cloud/learning-ai

2. 查看 FAQ（本页面）

3. 搜索 Issue
   https://github.com/xiaochi-cloud/learning-ai/issues

4. 提新 Issue
```

---

### Q18: 有培训材料吗？

**A:** 有！

- 📄 [00-START-HERE.md](./00-START-HERE.md) - 快速开始
- 📄 [01-QUICK-GUIDE.md](./01-QUICK-GUIDE.md) - 快速指南
- 📄 [guide-for-java-team.md](./guide-for-java-team.md) - Java 团队指南
- 📊 [presentation.md](./presentation.md) - PPT 演示稿
- 💻 [demo-project/](./demo-project/) - 演示项目
- 📝 [templates/](./templates/) - 模板库

---

### Q19: 有成功案例吗？

**A:** 有！

**案例 1：某电商团队**
- 使用 SDD 开发订单系统
- 结果：返工减少 60%，交付周期缩短 40%

**案例 2：某金融团队**
- 使用 SDD 开发用户系统
- 结果：Bug 率减少 50%，文档维护时间减少 80%

**案例 3：某创业公司**
- 从 0 开始使用 SDD
- 结果：3 人团队 2 周完成 MVP

---

### Q20: 如何获得帮助？

**A:** 3 个渠道。

**1. GitHub Issues**
- 提问：https://github.com/xiaochi-cloud/learning-ai/issues
- 响应时间：24 小时内

**2. 团队内部群**
- 即时交流
- 经验分享

**3. 官方文档**
- Qoder 文档：https://docs.qoder.com/zh
- OpenSpec 项目：https://github.com/Fission-AI/OpenSpec

---

## 🔗 延伸学习

**入门：**
- [00-START-HERE.md](./00-START-HERE.md) - 5 分钟快速开始
- [01-QUICK-GUIDE.md](./01-QUICK-GUIDE.md) - 30 分钟快速指南

**进阶：**
- [QODER-USE-CASES.md](./QODER-USE-CASES.md) - 使用场景
- [guide-for-java-team.md](./guide-for-java-team.md) - Java 团队指南

**实战：**
- [demo-project/](./demo-project/) - 演示项目
- [templates/](./templates/) - 模板库

---

**没有找到答案？** [提个 Issue](https://github.com/xiaochi-cloud/learning-ai/issues) 吧！

**最后更新：** 2026-03-12 | **版本：** v2.0
