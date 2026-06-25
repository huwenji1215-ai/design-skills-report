# engineering/scaffold-spec.md — 工程脚手架规范

> 本文件描述项目目录结构、命名规范、Git 分支策略。  
> 是 Phase 1（脚手架）的参考规范，也是续开发时的约定基准。

---

## 项目目录结构

```
/data_agent/users/workspace/<name>/
├── web/                            ← 前端代码（所有前端操作在此目录下）
│   ├── src/
│   │   ├── index.ts                # 应用入口
│   │   ├── App.vue                 # 布局外壳（身份门控 + RouterView）
│   │   ├── router/
│   │   │   └── index.ts            # 路由表
│   │   ├── pages/                  # 页面组件（按路由维度）
│   │   ├── components/             # 可复用 UI 组件（无副作用）
│   │   ├── composables/            # 组合式函数
│   │   ├── assets/
│   │   │   └── theme.css           # ← Phase 2 注入的设计 Token（必须存在）
│   │   └── services/
│   │       ├── api.ts              # 所有接口定义
│   │       └── auth.ts             # SSO 鉴权（勿随意修改）
│   ├── public/
│   │   └── index.html
│   ├── rsbuild.config.js           # 构建配置（代理/端口等）
│   └── package.json
├── README.md                       ← 站点说明（init-site.sh 自动生成）
└── .git/
```

---

## 命名规范

| 项目 | 规范 | 示例 |
|------|------|------|
| 站点名 | RFC 1123：小写字母/数字/连字符，1-63 字符，不以连字符开头结尾 | `kpi-dashboard-2025` |
| 页面文件 | PascalCase + Page 后缀 | `DashboardPage.vue` |
| 组件文件 | PascalCase + Component 后缀 | `KpiCardComponent.vue` |
| composable | camelCase + use 前缀 | `useCurrentUser.ts` |
| 接口函数 | camelCase 动词开头 | `getWidgetData()` |

---

## Git 分支策略

| 分支 | 格式 | 说明 |
|------|------|------|
| 站点 master | `master-<name>` | 只从 feature 合入，不直接 push |
| 开发分支 | `feat-<name>-<timestamp>` | 日常开发在此分支 |
| 真 master | `master` | 永远不 push，保留模板状态 |

---

## rsbuild.config.js 关键配置速查

| 配置项 | 默认值 | 说明 |
|--------|-------|------|
| `PORT` | 8888 | dev server 端口，与 webSiteInit.devUrl 一致，不改 |
| `PROXY_TARGET` | `rc-tc.corp.kuaishou.com` | 代理后端域名，按需修改 |
| `BASE_PATH` | 自动读取 | 从 `/data_agent/users/.env` 读取 |
| `server.proxy['/api']` | 已配置 | 内置接口代理 |
| `server.proxy['/rest/flow']` | 已配置 | 内置数据查询接口代理 |
