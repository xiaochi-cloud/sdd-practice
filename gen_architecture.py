from PIL import Image, ImageDraw, ImageFont

# 创建图片
w, h = 1920, 1080
img = Image.new('RGB', (w, h), '#1a1a2e')
d = ImageDraw.Draw(img)

# 标题
d.text((w//2-250, 30), "SDD + Qoder 技术架构图", fill='#00d4ff')

# 7 层架构
layers = [
    ("👥 用户层", "#667eea", "Java 开发者 | Python 开发者 | 前端开发者 | 团队管理者"),
    ("💻 交互层", "#f093fb", "Qoder IDE | JetBrains 插件 | VS Code 插件 | CLI 工具"),
    ("⚙️ 核心引擎层", "#4facfe", "Quest Mode 引擎 | Spec 驱动引擎 | 意图识别 | 代码生成 | 质量验证"),
    ("🤖 AI 模型层", "#fa709a", "Claude 3.5 | GPT-4.5 | Qwen 2.5 | CodeLlama"),
    ("🚀 执行环境层", "#30cfd0", "Local | Parallel | Remote | Sandbox"),
    ("🔌 工具集成层", "#a8edea", "Skills | MCP | CI/CD"),
    ("💾 数据层", "#ff9a9e", "Spec 存储 | 代码仓库 | 知识库 | 日志监控"),
]

y = 100
for i, (name, color, content) in enumerate(layers):
    y1 = y + i * 130
    y2 = y1 + 100
    # 背景
    d.rectangle([100, y1, w-100, y2], fill=color)
    # 文字
    d.text((130, y1+15), name, fill='#000')
    d.text((300, y1+35), content, fill='#333')
    # 箭头
    if i < 6:
        d.line([(w//2, y2+5), (w//2, y2+30)], fill='#fff', width=3)

# 保存
img.save('architecture.png')
print("✅ 图片已生成：architecture.png")
