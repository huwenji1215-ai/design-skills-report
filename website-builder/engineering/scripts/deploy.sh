#!/bin/bash
# 调用部署接口，将构建产物发布上线
# 用法: bash /data_agent/scripts/deploy.sh <siteId> [gitCommitId] [gitDevBranch] [remark]
#
# 沙箱路径: /data_agent/scripts/deploy.sh
# 注入时机: sandbox session 创建时
set -e

SITE_ID="$1"
GIT_COMMIT_ID="${2:-}"
GIT_DEV_BRANCH="${3:-}"
REMARK="${4:-}"

if [ -z "$SITE_ID" ]; then
  echo "❌ 用法: bash $0 <siteId> [gitCommitId] [gitDevBranch] [remark]"
  exit 1
fi

DEPLOY_URL="https://tc.corp.kuaishou.com/rest/flow/api/v1/site/publish/deploy"
COOKIE_FILE="/data_agent/users/.agent-cookie/.data-agent-cookie"

if [ ! -f "$COOKIE_FILE" ]; then
  echo "❌ Cookie 文件不存在: ${COOKIE_FILE}"
  exit 1
fi

COOKIE=$(cat "$COOKIE_FILE")

RESPONSE=$(curl -s -X POST "$DEPLOY_URL" \
  -H 'Content-Type: application/json' \
  -H "Cookie: ${COOKIE}" \
  -d "{\"siteId\": ${SITE_ID}, \"gitCommitId\": \"${GIT_COMMIT_ID}\", \"gitDevBranch\": \"${GIT_DEV_BRANCH}\", \"remark\": \"${REMARK}\"}")

echo "$RESPONSE"
