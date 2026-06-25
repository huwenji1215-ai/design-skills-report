#!/bin/bash
# 安装依赖 + 启动 dev server
# 用法: bash /data_agent/scripts/install-and-start.sh <name>
#
# 沙箱路径: /data_agent/scripts/install-and-start.sh
# 注入时机: sandbox session 创建时
set -e

NAME="$1"

if [ -z "$NAME" ]; then
  echo "❌ 用法: bash $0 <name>"
  exit 1
fi

WEB_DIR="/data_agent/users/workspace/${NAME}/web"

if [ ! -d "$WEB_DIR" ]; then
  echo "❌ 目录不存在: ${WEB_DIR}"
  exit 1
fi

echo "=== [1/2] 安装依赖 ==="
cd "$WEB_DIR"
npm config set registry https://npm.corp.kuaishou.com/
CI=true pnpm install --no-frozen-lockfile

echo "=== [2/2] 启动 dev server ==="
nohup ./node_modules/.bin/rsbuild dev > "/tmp/dev-${NAME}.log" 2>&1 &
DEV_PID=$!
echo "dev server PID: ${DEV_PID}, 日志: /tmp/dev-${NAME}.log"

# 等待 dev server 启动
sleep 5
if tail -20 "/tmp/dev-${NAME}.log" | grep -q "Local:"; then
  echo "✅ dev server 已启动"
  tail -5 "/tmp/dev-${NAME}.log"
else
  echo "⚠️  dev server 可能还在启动中,请检查日志: tail -f /tmp/dev-${NAME}.log"
fi
