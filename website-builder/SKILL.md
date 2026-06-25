---
name: website-builder
description: |-
  完整建站 Skill（工程搭建 + 设计美化 + 发布上线）。覆盖从需求澄清到生产部署的完整流程。
  【触发场景】
  - 新建站点："帮我建一个数据看板站点"、"创建一个xxx管理系统"、"做一个带图表的页面"
  - 续开发已有站点："帮我改一下 xxx 站点"、"给 xxx 加个页面"、"xxx 站点加个图表"
  - 纯样式优化："美化一下这个页面"、"换成暗色主题"、"风格太乱了"
  - 发布上线："把站点发布上线"、"deploy"、"打包上线"
  【5 大场景】
  Landing Page / 数据日报周报 / 数据看板 Dashboard / 工具型应用 / 内容文档站
  【6 套主题】
  A-企业亮色★默认 / B-深色专业 / C-编辑排版 / D-极简轻量 / E-卡片网格 / F-深色霓虹(暗黑时)
  【不适用】创意活动页/游戏 → frontend-design；Python图表 → DesignAI-reports
tools: webSiteInit,widgetFiltersQuery
---

# website-builder — 完整建站 Skill

> **三域职责分离，各职能独立迭代：**
> - **设计域** `design/`：场景规范 / 主题 Token / 设计原则（@设计）
> - **工程域** `engineering/`：Vue组件 / 接口 / 脚手架规范（@前端）
> - **部署域** `deploy/`：构建 / 发布 / 监控流程（@DevOps）

---

## 入口判断：模式路由

| 用户意图 | 判断依据 | 执行路径 |
|---------|---------|---------|
| **新建站点** | "创建…站点"、"搭建...网站"、首次提到站点名 | Phase 0 → 1 → 2 → 3 → 4 → 5（完整流程）|
| **续开发** | "帮我改一下 xxx"、"给 xxx 加个页面" | 跳过 Phase 0-2，直接进入 Phase 3 |
| **局部修改** | "改一下颜色/风格/某个组件" | 加载 `phases/phase-patch.md` |
| **纯样式美化** | "美化一下"、"风格太乱" | Phase 2 设计注入 → Phase 4 质量门控 |
| **发布上线** | "发布"、"deploy"、"打包上线" | Phase 5 构建发布 |

---

## 渐进式披露策略（Progressive Disclosure）

```
Tier 0（本文件，必读）：
  模式路由 → Phase 概览 → 设计 P0 规则 → Self-Check

Tier 1（按 Phase 加载）：
  phases/phase0-requirement.md   需求澄清（新建时必读）
  phases/phase1-scaffold.md      工程脚手架（新建时必读）
  phases/phase2-design-inject.md 设计系统注入（新建 + 纯美化必读）
  phases/phase3-codegen.md       代码生成规范（编写业务代码时必读）
  phases/phase4-ui-qa.md         UI 质量门控（交付前必读）
  phases/phase5-deploy.md        构建发布（发布时才读）
  phases/phase-patch.md          局部修改流程（用户要改细节时读）

Tier 2（按场景选一个）：
  design/scenes/landing-page.md
  design/scenes/data-report.md
  design/scenes/dashboard.md
  design/scenes/tool-app.md
  design/scenes/content-doc.md

Tier 3（按主题选一个）：
  design/themes/A-enterprise-light.md  ★ 默认
  design/themes/B-dark-pro.md
  design/themes/C-editorial.md
  design/themes/D-minimal.md
  design/themes/E-bold-bento.md
  design/themes/F-dark-neon.md         暗黑时触发

Tier 4（高级定制，按需）：
  design/core/design-tokens.md
  design/core/anti-patterns.md
  design/core/three-layer-spec.md
  design/core/brand-token-derivation.md
  design/core/responsive-spec.md
  design/core/accessibility.md
  design/core/motion-icons.md
  design/data-components/kpi-card.md
  design/data-components/echarts-config.md
  design/data-components/table-spec.md
  design/data-components/semantic-colors.md
  design/data-components/site-chrome.md
  engineering/api-spec.md
  engineering/code-standards.md
  references/tailwind-bridge.md
  references/mobile-adaptation.md
  references/component-protocol.md
```

---

## 场景识别

```
用户说的是什么 / 产物是什么？
│
├─ "官网" / "Landing Page" / "产品页" / "营销页"
│   → 场景：landing-page ✦ 加载 design/scenes/landing-page.md
│
├─ "日报" / "周报" / "月报" / "数据报告"
│   → 场景：data-report ✦ 加载 design/scenes/data-report.md
│
├─ "看板" / "Dashboard" / "监控大屏" / "数据驾驶舱"
│   → 场景：dashboard ✦ 加载 design/scenes/dashboard.md
│
├─ "后台" / "管理系统" / "工具" / "内部平台" / "B 端"
│   → 场景：tool-app ✦ 加载 design/scenes/tool-app.md
│
└─ "博客" / "文档" / "知识库" / "内容站"
    → 场景：content-doc ✦ 加载 design/scenes/content-doc.md
```

---

## 主题选择

| 主题 | 关键词 | 适用场景 | 文件 |
|------|--------|---------|------|
| **A — 企业亮色** | 大厂风 / 数平蓝 / 专业商务 | 所有场景默认 ★ | `design/themes/A-enterprise-light.md` |
| **B — 深色专业** | 暗色大屏 / 高管汇报 | dashboard / data-report | `design/themes/B-dark-pro.md` |
| **C — 编辑排版** | 杂志感 / 内容优先 | content-doc ★ | `design/themes/C-editorial.md` |
| **D — 极简轻量** | Notion / Linear / 无装饰 | tool-app / content-doc | `design/themes/D-minimal.md` |
| **E — 卡片网格** | Bento / 强对比 / 大字 | landing-page / dashboard | `design/themes/E-bold-bento.md` |
| **F — 深色霓虹** | 青蓝科技感 / DataAgent 风格 | data-report / dashboard（暗黑版）| `design/themes/F-dark-neon.md` |

> **用户未指定主题 → 默认 A — 企业亮色**
> **用户说「暗黑」/「暗色」/「深色」/「dark」→ F — 深色霓虹**
> **用户说「大屏」/「高管报告」→ B — 深色专业**

---

## 续开发前置动作

```bash
# 1. 确认站点名 <name>，项目路径 /data_agent/users/workspace/<name>/web/
# 2. 确认 dev server 是否运行
tail -20 /tmp/dev-<name>.log
curl -sf http://localhost:8888/ > /dev/null && echo "RUNNING" || echo "STOPPED"
# 3. 如果 server 未运行，重启
bash ./engineering/scripts/install-and-start.sh '<name>'
# 4. 读取站点元数据
source /tmp/site-<name>.env
```

---

## P0 设计硬性规则（违反即返工）

```
── 通用 ──────────────────────────────────────────────────────────────
[P0] 禁止在标题、按钮、标签、正文中使用 Emoji
[P0] 数据/内容不得截断或溢出（标签、气泡、图例、文字）
[P0] 正向 delta = 绿，负向 delta = 红，不得反向
[P0] border-radius ≤ 12px（landing-page 可放宽到 16px）
[P0] 非灰色彩色 ≤ 3 种；多分类语义场景最多 10 色
[P0] 发光效果（glow）仅限 F-dark-neon 主题；其余主题禁止

── 版式 ──────────────────────────────────────────────────────────────
[P0] 禁止 float 布局（必须用 grid / flex）
[P0] 字号使用 5 级体系，禁止自造第 6 级
[P0] font-weight 禁止使用 100 / 300
[P0] 正文颜色对比度 ≥ 4.5:1（WCAG AA）

── 数据场景专属 ──────────────────────────────────────────────────────
[P0] 禁止彩色卡片顶条（card colored top bar）
[P0] KPI 数字 ≥ 28px，且必须是区域内最大字号
[P0] ECharts 容器禁止固定 px 高度，必须用 flex:1;min-height:0
[P0] 图表多系列色 ≠ 语义色（正绿/负红），避免颜色语义混淆

── 工程专属 ──────────────────────────────────────────────────────────
[P0] 接口全部集中在 src/services/api.ts，禁止在 Vue 组件内直接 fetch
[P0] 页面 loading/error/empty 三种状态必须处理
[P0] CSS 必须用 <style scoped>，全局样式仅在 App.vue <style>
[P0] 用户提到 CK 表/BI 数据集/看板 widgetId → 必须用内置接口，禁止自建后端
```

---

## 边界 Case 处理

| 用户说 | 处理方式 |
|--------|---------|
| 提供了品牌色 #XXXXXX | 加载 `design/core/brand-token-derivation.md` 推导完整 Token |
| 想要"像 Stripe 那样的风格" | 同上，走风格解析流程 |
| 只改某个组件的颜色/圆角 | 加载 `phases/phase-patch.md`，不重写整页 |
| 已有暗色背景代码 | 识别最近主题（B 或 F），在原体系内对齐规范 |
| 数据来自 CK 表 | 使用 `executeSql(catalog: 'CLICKHOUSE')`，见 engineering/api-spec.md |
| 数据来自 BI 数据集 | 使用 `executeSql(catalog: 'BI_SQL', sourceId: xxx)` |
| 数据来自看板 widgetId | 使用 `queryWidgetData({widgetId: xxx})` |
| 需要移动端支持 | 加载 `references/mobile-adaptation.md` |

---

## Self-Check（输出前全部通过）

```
通用基础项
[ ] P0 规则全部通过
[ ] 无 Emoji（标题/按钮/标签/正文）
[ ] 配色使用主题 Token，未随意自造颜色
[ ] 字号使用 5 级体系，未出现第 6 级
[ ] border-radius 符合场景限制
[ ] 布局使用 grid/flex，无 float
[ ] 正文颜色对比度 ≥ 4.5:1
[ ] 多列卡片使用 grid + align-items:stretch（高度对齐）
[ ] delta 用颜色+箭头图标双重编码（色盲友好）
[ ] 响应式：768px / 480px 断点已覆盖
[ ] 移动端可点击元素 min-height ≥ 44px

工程基础项（涉及 Vue 工程时）
[ ] loading / error / empty 三态已处理
[ ] 接口在 api.ts，未在组件内直接 fetch
[ ] 样式用 <style scoped>
[ ] 路由懒加载（除首页外）

场景专项 → 见 design/scenes/{scene}.md § Self-Check
主题专项 → 见 design/themes/{theme}.md § Self-Check
```

---

## 文件结构总览

```
website-builder/
├── SKILL.md                        ← 统一入口（本文件）
│
├── phases/                         ← 工程执行流水线（@前端 / @DevOps 迭代）
│   ├── phase0-requirement.md       需求澄清：站点名/数据源/场景/主题确认
│   ├── phase1-scaffold.md          工程脚手架：clone/install/dev-server
│   ├── phase2-design-inject.md     设计系统注入：Token/主题CSS/Tailwind配置
│   ├── phase3-codegen.md           代码生成：Vue组件/接口/路由规范
│   ├── phase4-ui-qa.md             UI质量门控：Self-Check/P0检查
│   ├── phase5-deploy.md            构建发布：build/git/deploy接口
│   └── phase-patch.md              局部修改流程：颜色/组件/结构修改规范
│
├── design/                         ← 设计规范域（@设计 迭代）
│   ├── scenes/                     5大场景规范
│   ├── themes/                     A-F 6套主题
│   ├── core/                       设计原则（Token/反模式/响应式/无障碍）
│   └── data-components/            数据组件规范（KPI/ECharts/Table/SiteChrome）
│
├── engineering/                    ← 工程规范域（@前端 迭代）
│   ├── scaffold-spec.md            目录约定/命名/Git分支规范
│   ├── api-spec.md                 内置接口（CK/BI/看板/沙箱）
│   ├── code-standards.md           Vue组件模板/加载态/CSS规范
│   └── scripts/                    bash执行脚本
│
├── deploy/                         ← 部署域（@DevOps 补充）
│   ├── build-spec.md               rsbuild配置说明
│   └── release-flow.md             发布流程/回滚规范
│
└── references/                     ← 共享参考（跨职能）
    ├── tailwind-bridge.md          Token → Tailwind class 转换表
    ├── component-protocol.md       组件沉淀协议（官方库/用户上传/Agent搜索）
    ├── mobile-adaptation.md        移动端适配规范
    └── CHANGELOG.md                版本记录
```
