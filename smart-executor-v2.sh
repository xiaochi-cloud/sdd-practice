#!/bin/bash
# 智能执行器 v2 - 集成自动提交机制

echo "🤖 [$(date +%H:%M)] 智能执行器 v2 启动..."

MAX_ITERATIONS=20
ITERATION=0

while [ $ITERATION -lt $MAX_ITERATIONS ]; do
    ITERATION=$((ITERATION + 1))
    
    echo ""
    echo "=== 第 $ITERATION 次迭代 ==="
    echo "时间：$(date +%H:%M:%S)"
    echo ""
    
    # 1. 智能检测
    echo "🔍 步骤 1: 智能检测..."
    DETECT_RESULT=$(bash smart-detect.sh 2>&1)
    echo "$DETECT_RESULT" | head -20
    
    # 检查是否完成
    if echo "$DETECT_RESULT" | grep -q "所有内容已完成"; then
        echo ""
        echo "✅ 所有内容已完成，停止迭代"
        break
    fi
    
    # 2. 智能创建
    echo ""
    echo "🤖 步骤 2: 智能创建..."
    bash smart-create.sh 2>&1 | tail -5
    
    # 3. 自动提交
    echo ""
    echo "📦 步骤 3: 自动提交..."
    bash auto-commit.sh 2>&1 | grep -E "(检测到|提交|推送|无变更)"
    
    # 4. 等待
    WAIT_TIME=60
    echo ""
    echo "⏰ 步骤 4: 等待 $WAIT_TIME 秒后继续..."
    sleep $WAIT_TIME
done

echo ""
echo "✅ [$(date +%H:%M)] 智能执行完成"
echo "总迭代次数：$ITERATION"
