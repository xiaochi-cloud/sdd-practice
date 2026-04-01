#!/bin/bash
# 启动所有服务

echo "🚀 启动持续提交和自我修复系统..."

# 创建日志目录
mkdir -p logs

# 停止旧进程
echo "⏹️ 停止旧进程..."
pkill -f "continuous-monitor.sh" 2>/dev/null || true
pkill -f "auto-commit-system.sh" 2>/dev/null || true
sleep 2

# 启动监控服务
echo "👁️ 启动持续监控服务..."
nohup bash continuous-monitor.sh > logs/monitor-stdout.log 2>&1 &
MONITOR_PID=$!
echo "✅ 监控服务已启动 (PID: $MONITOR_PID)"

# 立即执行一次提交
echo ""
echo "📦 立即执行一次提交..."
bash auto-commit-system.sh

# 显示状态
echo ""
echo "========================================="
echo "✅ 系统启动完成"
echo "========================================="
echo "监控服务 PID: $MONITOR_PID"
echo "检查间隔：300 秒（5 分钟）"
echo "日志文件：logs/monitor.log"
echo "提交流程：logs/auto-commit.log"
echo "通知文件：logs/pending-commits.txt"
echo "========================================="
echo ""
echo "📊 查看状态命令:"
echo "  tail -f logs/monitor.log        # 实时监控日志"
echo "  tail -f logs/auto-commit.log    # 提交流程日志"
echo "  cat logs/pending-commits.txt    # 查看待处理通知"
echo "  ps aux | grep monitor           # 查看监控进程"
echo "========================================="

# 保存 PID
echo $MONITOR_PID > logs/monitor.pid
