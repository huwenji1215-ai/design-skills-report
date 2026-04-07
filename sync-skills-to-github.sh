#!/bin/zsh
# sync-skills-to-github.sh
# 将本地 skills 同步到 github.com/dingzu/ai-design-lab
# 用法: ./sync-skills-to-github.sh [commit message]
# 示例: ./sync-skills-to-github.sh "feat: update autoevo threshold"

set -e

REPO_URL="git@git.corp.kuaishou.com:design/designskill.git"
SKILLS_SRC="$HOME/.codeflicker/skills"
WORK_DIR="/tmp/designskill-sync"
COMMIT_MSG="${1:-"chore: sync skills $(date '+%Y-%m-%d %H:%M')"}"

SKILLS_TO_SYNC=(
  "design-evaluator"
  "infovis-evaluator"
  "infovis-autoevo"
)

echo "🔄 同步 Skills 到 GitHub..."
echo "   目标: github.com/dingzu/ai-design-lab/skills/"
echo "   提交信息: $COMMIT_MSG"
echo ""

# 克隆或更新
if [ -d "$WORK_DIR/.git" ]; then
  echo "📥 更新本地副本..."
  cd "$WORK_DIR" && git pull origin master --quiet
else
  echo "📥 克隆仓库..."
  rm -rf "$WORK_DIR"
  git clone "$REPO_URL" "$WORK_DIR" --quiet
fi

cd "$WORK_DIR"
git config user.email "huwenji@users.noreply.github.com"
git config user.name "huwenji"

# 同步每个 skill
mkdir -p skills
for skill in "${SKILLS_TO_SYNC[@]}"; do
  src="$SKILLS_SRC/$skill"
  dst="$WORK_DIR/skills/$skill"
  if [ -d "$src" ]; then
    echo "📦 同步 $skill ..."
    rm -rf "$dst"
    cp -r "$src" "$dst"
  else
    echo "⚠️  跳过 $skill（本地目录不存在）"
  fi
done

# 检查是否有变更
if git diff --quiet && git diff --staged --quiet && [ -z "$(git status --short)" ]; then
  echo ""
  echo "✅ 无变更，已是最新状态。"
  exit 0
fi

# 提交并推送
git add skills/
git status --short
git commit -m "$COMMIT_MSG"
git push origin master

echo ""
echo "✅ 同步完成！"
echo "   👉 https://github.com/dingzu/ai-design-lab/tree/main/skills"
