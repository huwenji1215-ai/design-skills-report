#!/usr/bin/env bash
# 确保 node 20 + pnpm 9 可用
# 用法: bash ./scripts/setup-node.sh

set -e

# 1. 检查 nvm 是否可用；若无则自动安装
if ! command -v nvm &>/dev/null && [ ! -f "$HOME/.nvm/nvm.sh" ]; then
  echo "nvm 未找到，正在安装..."
  curl -fsSL https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash \
    || curl -fsSL https://gitee.com/mirrors/nvm/raw/v0.39.7/install.sh | bash
fi

# 2. 加载 nvm
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && source "$NVM_DIR/nvm.sh"

# 3. 确保 node 20 已安装并激活
if ! nvm ls 20.18.2 2>/dev/null | grep -q "20.18.2"; then
  nvm install 20.18.2
fi
nvm alias default 20.18.2
nvm use 20.18.2

# 4. 确保 pnpm 9 已安装
if ! command -v pnpm &>/dev/null || ! pnpm -v | grep -q "^9\."; then
  npm install -g pnpm@9.15.5
fi

echo "=== 环境就绪 ==="
node -v && pnpm -v
