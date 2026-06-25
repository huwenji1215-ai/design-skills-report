#!/bin/bash
# 执行前端构建
# 用法: bash /data_agent/scripts/build.sh <name>
#
# 沙箱路径: /data_agent/scripts/build.sh
# 注入时机: sandbox session 创建时
set -e

NAME="$1"

if [ -z "$NAME" ]; then
  echo "❌ 用法: bash $0 <name>"
  exit 1
fi

WEB_DIR="/data_agent/users/workspace/${NAME}/web"

if [ ! -d "$WEB_DIR" ]; then
  echo "❌ 项目目录不存在: ${WEB_DIR}"
  exit 1
fi

cd "$WEB_DIR"

echo "📦 开始构建 ${NAME}..."
pnpm run build
echo "✅ 构建完成"
