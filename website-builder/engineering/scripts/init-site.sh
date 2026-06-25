#!/bin/bash
# 建站初始化脚本：clone 模板仓库 → 平铺 template01 → 写 README → git 配置 → 提交 → 推送 master → 切开发分支
# 用法: bash /data_agent/scripts/init-site.sh <name> <userName> <masterBranch> <featureBranch>
#
# 沙箱路径: /data_agent/scripts/init-site.sh
# 注入时机: sandbox session 创建时
set -e

NAME="$1"
USER_NAME="$2"
MASTER_BRANCH="$3"
FEATURE_BRANCH="$4"

if [ -z "$NAME" ] || [ -z "$USER_NAME" ] || [ -z "$MASTER_BRANCH" ] || [ -z "$FEATURE_BRANCH" ]; then
  echo "❌ 用法: bash $0 <name> <userName> <masterBranch> <featureBranch>"
  exit 1
fi

WORKSPACE="/data_agent/users/workspace"
PROJECT_PATH="${WORKSPACE}/${NAME}"
TEMPLATE_REPO="https://git.corp.kuaishou.com/ks-frontend/data/data-agent-template.git"

echo "=== [1/6] Clone 模板仓库 ==="
mkdir -p "$WORKSPACE"
rm -rf "$PROJECT_PATH"
cd "$WORKSPACE"
git clone "$TEMPLATE_REPO" "$NAME"

echo "=== [2/6] 切到站点 master 分支: ${MASTER_BRANCH} ==="
cd "$PROJECT_PATH"
git checkout -b "$MASTER_BRANCH"

echo "=== [3/6] 平铺 template01 到根目录 ==="
mv template01/* ./
mv template01/.[!.]* ./ 2>/dev/null || true
rmdir template01

echo "=== [4/6] 写 README.md ==="
cat > README.md <<EOF
# ${NAME}

> 由 DataAgent 建站工具初始化生成
EOF

echo "=== [5/6] git 配置 + 提交 + 推送 master ==="
git config user.email "${USER_NAME}@kuaishou.com"
git config user.name "$USER_NAME"
git add -A
git commit -m "init site ${NAME}"
git push -u origin "$MASTER_BRANCH"

echo "=== [6/6] 切到开发分支: ${FEATURE_BRANCH} ==="
git checkout -b "$FEATURE_BRANCH"

echo "✅ 站点初始化完成: ${PROJECT_PATH} (当前分支: ${FEATURE_BRANCH})"
