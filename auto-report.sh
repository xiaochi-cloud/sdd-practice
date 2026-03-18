#!/bin/bash
# SDD 实战平台自动汇报脚本

TIMESTAMP=$(date +%H:%M)
TODAY_COMMITS=$(git log --since='00:00' --oneline | wc -l)
TOTAL_FILES=$(find . -type f -name "*.java" -o -name "*.yaml" -o -name "*.md" | wc -l)

# 获取最新提交
LATEST=$(git log -1 --oneline)

# 生成汇报
cat << EOF
📊 **SDD 进度汇报** | $TIMESTAMP

✅ **今日提交：** $TODAY_COMMITS 次
📁 **总文件数：** $TOTAL_FILES 个
📝 **最新提交：** $LATEST

🔄 **迭代状态：** 持续进行中
⏰ **下次汇报：** 30 分钟后

---
EOF

# 发送到钉钉群（需要配置 webhook）
# curl -X POST "WEBHOOK_URL" -H "Content-Type: application/json" -d "{\"msgtype\":\"markdown\",\"markdown\":{\"title\":\"SDD 进度汇报\",\"text\":\"$(cat <<EOF
# ...汇报内容
# EOF
# )\"}}"

echo "✅ 汇报已生成：$(date +%H:%M)"
