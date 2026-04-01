#!/bin/bash
# 自动提交机制 - 持续检测、创建、提交

echo "🔄 [$(date +%H:%M)] 自动提交机制启动..."

DOCS_DIR="docs/claude-code-architecture"

# 文档列表（按优先级）
declare -a DOCS=(
    "00-overview.md:500"
    "01-agent-core.md:500"
    "02-tool-system.md:500"
    "03-context-manager.md:500"
    "04-mcp-protocol.md:500"
    "05-remote-execution.md:300"
    "06-design-patterns.md:300"
    "07-code-organization.md:300"
    "08-api-reference.md:200"
    "09-performance.md:200"
    "10-security.md:200"
)

# 检查并创建文档
for doc_info in "${DOCS[@]}"; do
    doc_name="${doc_info%%:*}"
    min_lines="${doc_info##*:}"
    doc_path="$DOCS_DIR/$doc_name"
    
    # 检查文件是否存在且达到行数要求
    if [ ! -f "$doc_path" ]; then
        echo "📝 创建 $doc_name..."
        # 文件不存在，需要创建（由 smart-create.sh 处理）
        continue
    fi
    
    current_lines=$(wc -l < "$doc_path")
    if [ $current_lines -lt $min_lines ]; then
        echo "⚠️ $doc_name 需要完善（当前 $current_lines 行，需要 $min_lines 行）"
        continue
    fi
    
    echo "✅ $doc_name 已完成（$current_lines 行）"
done

echo "---"

# 检查是否有变更
CHANGES=$(git status --porcelain | wc -l)

if [ $CHANGES -gt 0 ]; then
    echo "📦 检测到 $CHANGES 个文件变更，开始提交..."
    
    # Git 配置
    git config user.name "池少团队"
    git config user.email "chishao@example.com"
    
    # Git 提交
    git add -A
    TIMESTAMP=$(date +%Y%m%d-%H%M%S)
    git commit -m "auto: 持续迭代提交 $TIMESTAMP
    
🤖 自动提交机制
📊 变更文件：$CHANGES 个
⏰ 提交时间：$(date +%H:%M)
🔄 迭代轮次：自动检测"
    
    if [ $? -eq 0 ]; then
        echo "✅ 提交成功"
        
        # 自动推送
        echo "🚀 推送到 GitHub..."
        GIT_SSH_COMMAND="ssh -i ~/.ssh/github_openclaw -o IdentitiesOnly=yes" git push -u origin main
        
        if [ $? -eq 0 ]; then
            echo "✅ 推送成功"
        else
            echo "⚠️ 推送失败，下次重试"
        fi
    else
        echo "⚠️ 提交失败"
    fi
else
    echo "⏸️ 无变更，跳过提交"
fi

echo "✅ [$(date +%H:%M)] 自动提交完成"
