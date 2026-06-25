# phases/phase5-deploy.md — 构建发布

> **加载时机**：用户明确说"发布"/"上线"/"deploy"/"打包上线"时才加载执行。  
> **禁止**：开发测试阶段（修改代码、调试、预览）绝不主动进入此 Phase。  
> **前置条件**：Phase 4 UI 质量门控已通过。

---

## 发布前准备

```bash
# 读取站点元数据（Phase 1 持久化的）
source /tmp/site-<name>.env
# 此后 $SITE_ID / $MASTER_BRANCH / $FEATURE_BRANCH 均可用
```

若文件不存在（沙箱重启后丢失），询问用户提供 `siteId`，或通过平台接口查询。

---

## 发布步骤

### Step 1：构建

```bash
bash ./engineering/scripts/build.sh '<name>'
```

> 内部执行：`cd web && pnpm run build`。  
> 构建失败时，排查错误、修复代码后重试（这是 Agent Skill 的核心优势）。

### Step 2：Git 操作

```bash
bash ./engineering/scripts/publish-git.sh '<name>' '<masterBranch>'
```

> 内部执行：当前分支 → git add/commit → checkout master → merge → push → rev-parse HEAD → checkout 回开发分支。  
> 脚本输出：第一行 = 开发分支名（BRANCH），最后一行 = commit hash（COMMIT_ID）。

### Step 3：部署

```bash
bash ./engineering/scripts/deploy.sh <siteId> '<COMMIT_ID>' '<BRANCH>' '发布说明'
```

> 内部执行：curl POST 调用 `/api/v1/site/publish/deploy`，传入 siteId / gitCommitId / gitDevBranch / remark。

**成功响应示例：**
```json
{
  "code": 0,
  "data": {
    "historyId": 456,
    "siteId": 123,
    "status": "SUCCESS",
    "publishUrl": "https://mysite.ai-data.corp.kuaishou.com",
    "errorMsg": null
  }
}
```

### Step 4：反馈给用户

把 `publishUrl` 展示给用户，发布完成。

---

## 失败处理

| 失败类型 | 处理方式 |
|---------|---------|
| 构建报错 | 模型自主排查错误日志，修复代码后重试 |
| Git 冲突 | 模型自行解决冲突，重新 merge |
| deploy 接口超时 | 稍等再试一次 |
| siteId 不存在 | 检查 `/tmp/site-<name>.env`，或询问用户 |
