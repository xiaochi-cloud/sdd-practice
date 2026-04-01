#!/bin/bash
# 自动提交系统 - 完整机制（带提示、自我修复）

set -e  # 遇到错误立即退出

LOG_FILE="logs/auto-commit.log"
NOTIFICATION_FILE="logs/pending-commits.txt"
MAX_RETRIES=3

# 日志函数
log() {
    local msg="[$(date '+%Y-%m-%d %H:%M:%S')] $1"
    echo "$msg" | tee -a "$LOG_FILE"
}

# 通知函数（创建通知文件）
notify() {
    local msg="$1"
    echo "$msg" >> "$NOTIFICATION_FILE"
    log "📢 通知：$msg"
}

# 清除旧通知
clear_notifications() {
    if [ -f "$NOTIFICATION_FILE" ]; then
        rm "$NOTIFICATION_FILE"
    fi
}

# Git 配置
setup_git() {
    git config user.name "池少团队" 2>/dev/null || true
    git config user.email "chishao@example.com" 2>/dev/null || true
}

# 检查变更
check_changes() {
    local changes=$(git status --porcelain 2>/dev/null | wc -l)
    log "🔍 检测到 $changes 个文件变更"
    echo $changes
}

# 提交变更
commit_changes() {
    local timestamp=$(date +%Y%m%d-%H%M%S)
    local commit_msg="auto: 持续迭代提交 $timestamp"
    
    log "📦 开始提交..."
    git add -A
    
    if git commit -m "$commit_msg" > /dev/null 2>&1; then
        log "✅ 提交成功：$commit_msg"
        notify "✅ 提交成功：$commit_msg"
        return 0
    else
        log "⚠️ 提交失败（可能无变更）"
        return 1
    fi
}

# 推送到 GitHub
push_to_github() {
    log "🚀 开始推送到 GitHub..."
    
    if GIT_SSH_COMMAND="ssh -i ~/.ssh/github_openclaw -o IdentitiesOnly=yes" git push -u origin main > /dev/null 2>&1; then
        log "✅ 推送成功"
        notify "✅ 推送成功"
        return 0
    else
        log "❌ 推送失败"
        notify "❌ 推送失败，下次重试"
        return 1
    fi
}

# 自我修复机制
self_heal() {
    log "🔧 启动自我修复..."
    
    # 修复 1: Git 配置
    setup_git
    
    # 修复 2: 检查远程仓库
    if ! git remote -v | grep -q origin; then
        log "⚠️ 远程仓库未配置，尝试添加..."
        git remote add origin git@github.com:xiaochi-cloud/sdd-practice.git 2>/dev/null || true
    fi
    
    # 修复 3: 拉取最新代码
    log "📥 拉取最新代码..."
    GIT_SSH_COMMAND="ssh -i ~/.ssh/github_openclaw -o IdentitiesOnly=yes" git pull --rebase > /dev/null 2>&1 || true
    
    log "✅ 自我修复完成"
}

# 主流程
main() {
    log "========================================="
    log "🤖 自动提交系统启动"
    log "========================================="
    
    # 初始化
    mkdir -p logs
    clear_notifications
    setup_git
    
    # 检查变更
    local changes=$(check_changes 2>/dev/null)
    
    if [ "$changes" -gt 0 ]; then
        log "📝 检测到变更，开始提交流程..."
        
        # 尝试提交（最多重试 3 次）
        local retry=0
        while [ $retry -lt $MAX_RETRIES ]; do
            if commit_changes; then
                # 提交成功，尝试推送
                if push_to_github; then
                    log "✅ 提交流程完成"
                    exit 0
                else
                    # 推送失败，继续重试
                    retry=$((retry + 1))
                    log "⚠️ 推送失败，第 $retry 次重试..."
                    sleep 5
                fi
            else
                # 提交失败
                log "⚠️ 提交失败"
                exit 1
            fi
        done
        
        # 重试失败，启动自我修复
        log "❌ 重试失败，启动自我修复..."
        self_heal
        
        # 自我修复后再次尝试
        if commit_changes && push_to_github; then
            log "✅ 自我修复后提交成功"
        else
            log "❌ 自我修复后仍然失败，等待下次执行"
            notify "❌ 提交失败，需要人工介入"
        fi
    else
        log "⏸️ 无变更，跳过提交"
    fi
    
    log "========================================="
}

# 执行
main
