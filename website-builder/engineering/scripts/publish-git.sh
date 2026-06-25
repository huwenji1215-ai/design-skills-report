#!/bin/bash
# 发布 git 操作：add/commit → merge 到 master → push → 输出 BRANCH 和 COMMIT_ID → 切回开发分支
# 用法: bash /data_agent/scripts/publish-git.sh <name> <masterBranch>
# 输出: 第一行=开发分支名, 最后一行=commit hash (供调用方解析)
#
# 沙箱路径: /data_agent/scripts/publish-git.sh
# 注入时机: sandbox session 创建时
set -e

NAME="$1"
MASTER_BRANCH="$2"

if [ -z "$NAME" ] || [ -z "$MASTER_BRANCH" ]; then
  echo "❌ 用法: bash $0 <name> <masterBranch>"
  exit 1
fi

PROJECT_PATH="/data_agent/users/workspace/${NAME}"

if [ ! -d "$PROJECT_PATH/.git" ]; then
  echo "❌ 不是 git 仓库: ${PROJECT_PATH}"
  exit 1
fi

cd "$PROJECT_PATH"

# 获取当前开发分支
BRANCH=$(git branch --show-current)
echo "$BRANCH"

# 提交当前修改
git add .
git commit -m "publish: ${NAME}" --allow-empty

# 切到 master 分支并 merge
git checkout "$MASTER_BRANCH"
git merge "$BRANCH"

# 推送 master
git push origin "$MASTER_BRANCH"

# 输出 commit hash
git rev-parse HEAD

# 切回开发分支
git checkout "$BRANCH"
