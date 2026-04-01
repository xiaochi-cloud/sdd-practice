#!/bin/bash
# 智能检测机制 - 持续迭代、完整创建

echo "🔍 [$(date +%H:%M)] 开始智能检测..."

DOCS_DIR="docs/claude-code-architecture"
SRC_DIR="src"

# 检测函数
check_and_create() {
    local file=$1
    local min_lines=$2
    local priority=$3
    
    if [ ! -f "$file" ] || [ $(wc -l < "$file" 2>/dev/null || echo 0) -lt $min_lines ]; then
        echo "📝 [优先级 $priority] 需要创建/完善：$file"
        return 0
    else
        echo "✅ 已完成：$file ($(wc -l < "$file") 行)"
        return 1
    fi
}

# 检测架构文档完整性
echo "=== 检测架构文档 ==="

NEED_WORK=0

# P0 - 核心文档（至少 500 行）
check_and_create "$DOCS_DIR/00-overview.md" 500 "P0" && NEED_WORK=1
check_and_create "$DOCS_DIR/01-agent-core.md" 500 "P0" && NEED_WORK=1
check_and_create "$DOCS_DIR/02-tool-system.md" 500 "P0" && NEED_WORK=1
check_and_create "$DOCS_DIR/03-context-manager.md" 500 "P0" && NEED_WORK=1
check_and_create "$DOCS_DIR/04-mcp-protocol.md" 500 "P0" && NEED_WORK=1

# P1 - 进阶文档（至少 300 行）
check_and_create "$DOCS_DIR/05-remote-execution.md" 300 "P1" && NEED_WORK=1
check_and_create "$DOCS_DIR/06-design-patterns.md" 300 "P1" && NEED_WORK=1
check_and_create "$DOCS_DIR/07-code-organization.md" 300 "P1" && NEED_WORK=1

# P2 - 补充文档（至少 200 行）
check_and_create "$DOCS_DIR/08-api-reference.md" 200 "P2" && NEED_WORK=1
check_and_create "$DOCS_DIR/09-performance.md" 200 "P2" && NEED_WORK=1
check_and_create "$DOCS_DIR/10-security.md" 200 "P2" && NEED_WORK=1

echo "---"

# 检测源代码实现
echo "=== 检测源代码实现 ==="

check_and_create "$SRC_DIR/agent/workflow.ts" 150 "P0" && NEED_WORK=1
check_and_create "$SRC_DIR/agent/intent.ts" 100 "P0" && NEED_WORK=1
check_and_create "$SRC_DIR/agent/planner.ts" 150 "P0" && NEED_WORK=1
check_and_create "$SRC_DIR/agent/executor.ts" 200 "P0" && NEED_WORK=1

echo "---"

if [ $NEED_WORK -eq 0 ]; then
    echo "✅ 所有内容已完成，无需迭代"
    exit 0
fi

echo "🎯 检测到需要完善的内容，开始智能创建..."
