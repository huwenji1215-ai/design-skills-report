# phases/phase1-scaffold.md — 工程脚手架

> **加载时机**：新建站点时必读。续开发直接跳到 Phase 3。  
> **目标**：把项目从零跑起来，dev server 成功响应后才算 Phase 1 完成。

---

## 命名约定

| 占位 | 取值 | 来源 |
|------|------|------|
| `<name>` | 站点名（RFC 1123） | Phase 0 确认 |
| `<userName>` | 当前用户邮箱前缀 | 沙箱 env 或对话上下文 |
| `<masterBranch>` | `master-<name>` | 站点级 master |
| `<featureBranch>` | `feat-<name>-<timestamp>` | timestamp = 当前毫秒时间戳 |
| 模板仓库 | `https://git.corp.kuaishou.com/ks-frontend/data/data-agent-template.git` | 固定 |
| 项目路径 | `/data_agent/users/workspace/<name>` | 平铺，去掉 template01 壳 |

> **目录约定**：模板仓库实际代码在 `template01/` 下。项目路径直接放 template01 的内部文件（`web/` / `package.json` 等），不保留 template01 这层目录。

---

## 执行步骤

### Step 0：确认系统依赖（node 20 + pnpm 9）

```bash
bash ./engineering/scripts/setup-node.sh
```

> node 20.x（推荐 20.17.0）、pnpm 9.x（推荐 9.15.5）。网络失败时用 `apt-get install -y nodejs` + `npm install -g pnpm@9.15.5`。

### Step 1：初始化站点

```bash
bash ./engineering/scripts/init-site.sh '<name>' '<userName>' 'master-<name>' 'feat-<name>-<timestamp>'
```

> 内部执行：clone 模板仓库 → 切 master → 平铺 template01 → 写 README → git config + commit + push → checkout 开发分支。  
> HTTPS clone 自动鉴权（`/root/.git-credentials`），**不要用 SSH**。

### Step 2：安装依赖 + 启动 dev server

```bash
bash ./engineering/scripts/install-and-start.sh '<name>'
```

> 内部执行：`pnpm install --no-frozen-lockfile` → `nohup rsbuild dev` → 验证启动。

### Step 3：验证服务

```bash
tail -20 /tmp/dev-<name>.log
curl -sf http://localhost:8888/ > /dev/null && echo "OK" || echo "NOT READY"
```

两者均通过才视为 Phase 1 完成，进入 Phase 2。

---

## 失败处理原则

| 失败原因 | 处理方式 |
|---------|---------|
| 网络/超时 | 重试一次，加 `--depth=1` |
| 权限问题 | 检查 `cat /root/.git-credentials` |
| 路径冲突 | `rm -rf` 清掉再来 |
| lockfile 不一致 | 用 `--no-frozen-lockfile`（已默认）|
| 连续 2-3 次失败 | 停止，把错误反馈给用户 |

---

## Phase 1 完成后

```bash
# 立即调用 webSiteInit 工具（DB 登记）
# 参数：name / gitMasterBranch / featureBranchName / devPort
# 拿到 siteId / devUrl / codePath 后，持久化到沙箱：

cat > /tmp/site-<name>.env << EOF
SITE_ID=<siteId>
DEV_URL=<devUrl>
CODE_PATH=<codePath>
MASTER_BRANCH=master-<name>
FEATURE_BRANCH=<featureBranch>
EOF
```

> webSiteInit 失败不回滚代码，代码已跑起来，DB 是元数据，可择时补登。

→ **进入 Phase 2（设计系统注入）**
