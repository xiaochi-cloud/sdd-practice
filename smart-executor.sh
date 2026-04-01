#!/bin/bash
# 智能执行器 - 持续迭代直到所有内容完整

echo "🤖 [$(date +%H:%M)] 智能执行器启动..."

MAX_ITERATIONS=10
ITERATION=0

while [ $ITERATION -lt $MAX_ITERATIONS ]; do
    ITERATION=$((ITERATION + 1))
    
    echo "=== 第 $ITERATION 次迭代 ==="
    
    # 运行智能检测
    DETECT_RESULT=$(./smart-detect.sh 2>&1)
    echo "$DETECT_RESULT"
    
    # 检查是否完成
    if echo "$DETECT_RESULT" | grep -q "所有内容已完成"; then
        echo "✅ 所有内容已完成，停止迭代"
        break
    fi
    
    # 运行智能创建
    ./smart-create.sh
    
    # Git 提交
    CHANGES=$(git status --porcelain | wc -l)
    if [ $CHANGES -gt 0 ]; then
        git add -A
        git commit -m "feat: 智能迭代 #$ITERATION - 完善架构文档"
        echo "✅ 提交完成：$CHANGES 个文件变更"
    else
        echo "⏸️ 无变更"
    fi
    
    # 等待 30 秒后继续检测
    echo "⏰ 等待 30 秒后继续检测..."
    sleep 30
done

echo "✅ [$(date +%H:%M)] 智能执行完成"
