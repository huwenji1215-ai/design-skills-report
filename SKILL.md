---
name: web-site-beautifier
description: |-
  网站视觉与样式美化 Skill（全场景通用）。核心能力：把 AI 生成的网页样式收敛到设计规范内，
  解决风格随机、配色乱、层级杂乱、"AI 审美"问题，覆盖 5 大场景 × 5 套主题风格。
  【典型触发场景】
  - 显式美化：对已有 HTML 说"美化一下"、"风格太乱"、"不够高级"、"换成暗色主题"、"太丑了"；
  - 从零创作：说"帮我做一个 Landing Page / 数据看板 / 工具后台 / 内容站"；
  - 样式迭代：说"改一下风格"、"换一套主题"、"调整一下颜色"；
  - 场景路由：说"用企业风"、"用极简风"、"用深色专业风"。
  【5 大场景】
  （1）Landing Page / 产品官网；（2）数据日报 / 周报；（3）数据看板 / Dashboard；
  （4）工具型应用 / 内部系统；（5）内容站 / 文档站。
  【5 套主题风格】
  A-企业亮色（Ant Design 系 / 阿里云蓝）、B-深色专业（大屏 / 高管报告）、
  C-编辑排版（内容型 / 阅读优先）、D-极简轻量（Linear / Notion 感）、E-卡片网格（Bento / 强对比）。
  【不适用】创意自由度页面（海报/邀请函/活动页/游戏）→ frontend-design；
  流程图/架构图 → drawio-diagram；Python 图表美化 → DesignAI-reports。
---

# web-site-beautifier

> **核心原则**：功能逻辑优先，样式收敛在后。  
> 对已有产物：**只动样式，不动结构和业务逻辑**。  
> 对新建产物：先确定场景与主题，再按规范生成。  
> 每次输出前必须通过 §Self-Check。

---

## 渐进式披露策略（Progressive Disclosure）

> 本 Skill 采用分层加载，**不要一次读取全部文件**。

```
Tier 0（本文件，必读）：
  场景识别 → 主题选择 → 执行模式路由 → P0 硬性规则 → Self-Check

Tier 1（按场景选一个，必读）：
  scenes/landing-page.md       Landing Page / 产品官网
  scenes/data-report.md        数据日报 / 周报
  scenes/dashboard.md          数据看板 / Dashboard
  scenes/tool-app.md           工具型应用 / 内部系统
  scenes/content-doc.md        内容站 / 文档站

Tier 2（按需加载）：
  themes/A-enterprise-light.md   主题 A — 企业亮色（默认）
  themes/B-dark-pro.md           主题 B — 深色专业
  themes/C-editorial.md          主题 C — 编辑排版
  themes/D-minimal.md            主题 D — 极简轻量
  themes/E-bold-bento.md         主题 E — 卡片网格

Tier 3（高级定制，特殊场景）：
  core/design-tokens.md          全局 Token 体系（色彩/字号/间距/圆角/阴影）
  core/anti-patterns.md          反模式清单（BAD vs GOOD 对照）
  core/three-layer-spec.md       User→Design→Tech 三层映射模板
  data-components/kpi-card.md    KPI Card + Sparkline 规范
  data-components/echarts-config.md  ECharts 标准配置
  data-components/table-spec.md  表格密度自适应规范
  data-components/semantic-colors.md 语义色使用规则
  references/CHANGELOG.md        版本变更记录
```

---

## Step 1：场景识别

> 根据用户描述和已有产物类型，选择唯一场景。

```
用户说的是什么 / 产物是什么？
│
├─ "官网" / "Landing Page" / "产品页" / "营销页"
│   → 场景：landing-page ✦ 加载 scenes/landing-page.md
│
├─ "日报" / "周报" / "月报" / "数据报告"
│   → 场景：data-report ✦ 加载 scenes/data-report.md
│
├─ "看板" / "Dashboard" / "监控大屏" / "数据驾驶舱"
│   → 场景：dashboard ✦ 加载 scenes/dashboard.md
│
├─ "后台" / "管理系统" / "工具" / "内部平台" / "B 端"
│   → 场景：tool-app ✦ 加载 scenes/tool-app.md
│
├─ "博客" / "文档" / "知识库" / "内容站"
│   → 场景：content-doc ✦ 加载 scenes/content-doc.md
│
└─ 无法识别 → 询问用户：
   "请告诉我这是哪种页面类型？
    (1) 产品官网/Landing Page
    (2) 数据日报/周报
    (3) 数据看板/Dashboard
    (4) 工具后台/内部系统
    (5) 内容站/文档站"
```

---

## Step 2：主题选择

> 场景确定后选择主题风格。**优先用用户明确指定**；用户未指定则参考下表默认推荐。

| 主题 | 关键词 | 适用场景 | 文件 |
|------|--------|---------|------|
| **A — 企业亮色** | 大厂风 / Ant Design / 阿里云蓝 / 专业商务 | landing-page ★ / tool-app | `themes/A-enterprise-light.md` |
| **B — 深色专业** | 暗色 / 大屏 / 高管汇报 / 科技感 | dashboard ★ / data-report | `themes/B-dark-pro.md` |
| **C — 编辑排版** | 杂志感 / 高端阅读 / 内容优先 / 排版讲究 | content-doc ★ / landing-page | `themes/C-editorial.md` |
| **D — 极简轻量** | Notion / Linear / 干净 / 无装饰 | tool-app ★ / content-doc | `themes/D-minimal.md` |
| **E — 卡片网格** | Bento / 强对比 / 大字 / 现代感 | landing-page / dashboard | `themes/E-bold-bento.md` |

> ★ = 该场景最常用主题  
> 无明确指定时，按场景默认推荐选 ★ 主题  
> 数据类场景（data-report/dashboard）且用户未指定时，默认 A 主题（亮色）

---

## Step 3：执行模式选择

```
已有 HTML / 产物？
├─ 是 → Mode A（显式优化）
│       核心：只动样式，不动结构 / JS / 业务逻辑
│
├─ 否 → 用户明确说"帮我做一个 XX"？
│        ├─ 是 → Mode C（从零生成）
│        │       核心：按场景叙事节奏 + 主题 Token 生成
│        └─ 否 → Mode B（隐式自检）
│                核心：Agent 输出 HTML 前自动执行 P0 Lint
│
└─ 部分已有（"扩展/改进"）→ Mode A
```

### Mode A — 显式优化（最常用）

```
1. 读取并分析已有 HTML
   → 识别当前色调（亮色/暗色）、主色、字体、组件结构
   
2. 加载对应 Tier 1 场景文件（按 Step 1 识别结果）

3. 加载对应 Tier 2 主题文件（按 Step 2 选择结果）
   → 提取主题 CSS Token 覆盖块

4. Token 注入（不重写 HTML）
   → 在原 :root 之后追加新 :root 覆盖块
   → 在 </head> 之前追加 <style> 精准修正块

5. 样式对齐执行
   → 对照场景规范修正间距、字阶、颜色、圆角
   → 清除反模式（emoji / 彩色顶条 / 过大圆角 / 渐变背景卡片）

6. 执行 §Self-Check → 全部通过后输出
```

⚠️ **Mode A 红线（违反视为破坏业务能力）**：
```
✗ 禁止修改 <script> 内容
✗ 禁止修改 ECharts/Chart.js options
✗ 禁止修改交互逻辑（筛选器/Tab/弹窗）
✗ 禁止重写原 :root（只能追加，利用层叠覆盖）
✗ 禁止修改 HTML 结构（只做样式层操作）
```

### Mode B — 隐式自检

```
1. Agent 输出 HTML 前自动执行 P0 Lint
2. 全部通过 → 直接交付
3. 存在违规 → 执行 Token 注入修复
4. 交付时简要说明："已自动修复 N 项样式违规：[列表]"
```

### Mode C — 从零生成

```
1. 加载场景文件（Tier 1）→ 获取叙事节奏和模块结构
2. 加载主题文件（Tier 2）→ 获取完整 CSS Token
3. 按场景骨架生成 HTML（含 Page Shell）
4. 填充真实数据（禁止捏造）
5. 执行 §Self-Check → 全部通过后输出
```

---

## P0 Hard Rules（违反即返工，无例外）

> 所有场景、所有主题均强制执行。

```
── 通用 ──────────────────────────────────────────────────────────────
[P0] 禁止在标题、按钮、标签、正文中使用 Emoji
[P0] 数据/内容不得裁剪 — 标签、气泡、图例、文字均不得截断或溢出
[P0] 正向 delta = 绿（见主题色彩），负向 delta = 红，不得反向
[P0] border-radius ≤ 12px（landing page 可放宽到 16px，其余场景 ≤ 8px）
[P0] 非灰色彩色 ≤ 3 种（primary + success + danger）；多分类语义场景最多 10 色
[P0] 禁止多层叠加阴影、彩色阴影、发光效果（glow）

── 版式 ──────────────────────────────────────────────────────────────
[P0] 禁止 float 布局（必须用 grid / flex）
[P0] 字号使用 5 级体系，禁止自造第 6 级（见 core/design-tokens.md）
[P0] font-weight 禁止使用 100 / 300（中文下过细，糊）

── 数据场景专属（data-report / dashboard）─────────────────────────────
[P0] 禁止彩色卡片顶条（card colored top bar）
[P0] KPI 数字 ≥ 28px，且必须是区域内最大字号
[P0] ECharts grid.top ≥ 48px（含 markPoint 时）；含 2 行标题时 ≥ 56px
[P0] ECharts 容器禁止设固定 px 高度，必须用 flex:1;min-height:0 撑满父卡片
```

---

## Self-Check（输出前全部通过）

> 场景文件中可能包含额外的专项检查，本清单为通用基础项。

```
通用基础项
[ ] P0 规则全部通过
[ ] 无 Emoji（标题/按钮/标签/正文）
[ ] 配色使用主题 Token，未随意自造颜色
[ ] 字号使用 5 级体系，未出现第 6 级
[ ] border-radius 符合场景限制
[ ] box-shadow 全页面 ≤ 1 处（landing-page 可适当放宽）
[ ] 布局使用 grid/flex，无 float
[ ] 无渐变背景卡片（卡片背景为纯白或浅灰平色）
[ ] 无装饰性 radial-gradient 光晕（landing-page header 除外，见场景规范）
[ ] delta 仅用颜色区分，不用 ▲▼ 字符

场景专项（加载对应场景文件后补充）
[ ] → 见 scenes/{scene-name}.md § Self-Check 补充项

主题专项（加载对应主题文件后补充）
[ ] → 见 themes/{theme-name}.md § Self-Check 补充项
```

---

## 场景 × 主题 兼容矩阵

| 场景 \ 主题 | A 企业亮色 | B 深色专业 | C 编辑排版 | D 极简 | E 卡片网格 |
|-----------|-----------|-----------|-----------|--------|-----------|
| Landing Page | ✅ ★推荐 | ⚠️ 慎用 | ✅ 可用 | ✅ 可用 | ✅ 可用 |
| 数据日报 | ✅ ★推荐 | ✅ 可用 | ❌ 不适合 | ✅ 可用 | ❌ 不适合 |
| 数据看板 | ✅ 可用 | ✅ ★推荐 | ❌ 不适合 | ✅ 可用 | ✅ 可用 |
| 工具应用 | ✅ 可用 | ✅ 可用 | ❌ 不适合 | ✅ ★推荐 | ❌ 不适合 |
| 内容站 | ⚠️ 可用 | ❌ 不适合 | ✅ ★推荐 | ✅ 可用 | ❌ 不适合 |

> ✅ = 完全兼容 / ⚠️ = 可用但需调整 / ❌ = 不推荐，视觉逻辑冲突

---

## 版本管理约束（⚠️ 强制执行）

每次修改本 Skill 任何文件后，必须在 `references/CHANGELOG.md` 末尾追加一条记录：

```
| YYYY-MM-DD | 变更内容描述 | 变更文件 | 操作人 |
```

---

## 文件结构总览

```
web-site-beautifier/
├── SKILL.md                      ← 本文件：主入口、场景路由、P0 规则
│
├── scenes/                       ← Tier 1：每次必读一个
│   ├── landing-page.md           Landing Page / 产品官网
│   ├── data-report.md            数据日报 / 周报（含站点交互层规范）
│   ├── dashboard.md              数据看板 / Dashboard（含站点交互层规范）
│   ├── tool-app.md               工具型应用 / 内部系统
│   └── content-doc.md            内容站 / 文档站
│
├── themes/                       ← Tier 2：按主题选一个
│   ├── A-enterprise-light.md     企业亮色（Ant Design / 阿里云蓝）
│   ├── B-dark-pro.md             深色专业（大屏 / 高管）
│   ├── C-editorial.md            编辑排版（杂志 / 内容）
│   ├── D-minimal.md              极简轻量（Linear / Notion）
│   └── E-bold-bento.md           卡片网格（Bento / 强对比）
│
├── core/                         ← Tier 3：高级定制时按需读
│   ├── design-tokens.md          全局 Token：色/字/距/角/影
│   ├── anti-patterns.md          反模式清单（BAD vs GOOD）
│   ├── three-layer-spec.md       User→Design→Tech 三层映射规范
│   └── motion-icons.md           交互动效规范 + 图标引用体系（🆕）
│
├── data-components/              ← Tier 3：数据场景专用组件
│   ├── kpi-card.md               KPI 卡片 + Sparkline（零依赖 JS）
│   ├── echarts-config.md         ECharts 标准配置与辅助函数
│   ├── table-spec.md             表格密度自适应规范
│   ├── semantic-colors.md        语义色：正/负/中性/状态
│   └── site-chrome.md            站点框架：导航/Tab/筛选/Section标题（🆕）
│
└── references/
    └── CHANGELOG.md              版本变更记录（每次修改必填）
```
