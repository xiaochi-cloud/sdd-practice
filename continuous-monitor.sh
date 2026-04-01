#!/bin/bash
# 持续监控和提交流程

LOG_FILE="logs/monitor.log"
CHECK_INTERVAL=300  # 5 分钟检查一次
MAX_DOCS=11  # 目标文档数

log() {
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] $1" | tee -a "$LOG_FILE"
}

# 检查文档完整性
check_docs_complete() {
    local docs_dir="docs/claude-code-architecture"
    local count=$(ls -1 "$docs_dir"/*.md 2>/dev/null | wc -l)
    
    log "📊 当前文档数：$count/$MAX_DOCS"
    
    if [ $count -lt $MAX_DOCS ]; then
        log "⚠️ 文档不完整，缺少 $((MAX_DOCS - count)) 个文档"
        return 1
    fi
    
    log "✅ 文档完整"
    return 0
}

# 检查文档质量（行数）
check_docs_quality() {
    local docs_dir="docs/claude-code-architecture"
    local min_lines=200
    local need_improve=0
    
    for doc in "$docs_dir"/*.md; do
        if [ -f "$doc" ]; then
            local lines=$(wc -l < "$doc")
            if [ $lines -lt $min_lines ]; then
                log "⚠️ $(basename $doc) 只有 $lines 行（需要 $min_lines 行）"
                need_improve=$((need_improve + 1))
            fi
        fi
    done
    
    if [ $need_improve -gt 0 ]; then
        log "⚠️ 有 $need_improve 个文档需要完善"
        return 1
    fi
    
    log "✅ 文档质量达标"
    return 0
}

# 主监控循环
main() {
    log "========================================="
    log "👁️ 持续监控系统启动"
    log "========================================="
    log "检查间隔：${CHECK_INTERVAL}秒"
    log "目标文档数：$MAX_DOCS"
    log "========================================="
    
    while true; do
        log ""
        log "=== 第 $(cat logs/monitor-count.txt 2>/dev/null || echo 0) 次检查 ==="
        
        # 递增计数
        local count=$(($(cat logs/monitor-count.txt 2>/dev/null || echo 0) + 1))
        echo $count > logs/monitor-count.txt
        
        # 检查文档完整性
        if ! check_docs_complete; then
            log "📝 触发文档创建流程..."
            # 这里可以调用创建脚本
        fi
        
        # 检查文档质量
        if ! check_docs_quality; then
            log "📝 触发文档完善流程..."
            # 这里可以调用完善脚本
        fi
        
        # 执行自动提交
        log "📦 执行自动提交..."
        bash auto-commit-system.sh
        
        # 显示通知
        if [ -f "logs/pending-commits.txt" ]; then
            log ""
            log "📢 待处理通知:"
            cat logs/pending-commits.txt
            log ""
        fi
        
        # 等待
        log "⏰ 等待 ${CHECK_INTERVAL}秒后继续监控..."
        sleep $CHECK_INTERVAL
    done
}

# 启动
main
