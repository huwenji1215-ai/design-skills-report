# scenes/data-report.md — 数据日报 / 周报 / 月报

> **场景定位**：周期性数据汇报**站点**，不只是一份文档，而是带完整站点交互层的数据产品。  
> 包含：全局站点框架（导航/筛选/Tab）+ 数据内容层（图表/KPI/表格）两层叠加。  
> 叙事结构：摘要结论 → 核心指标 → 趋势分析 → 明细数据 → 归因 → 建议。  
> 典型受众：业务负责人 / 数据分析师 / 运营团队 / 管理层。  
> ⚠️ **本场景深度集成 DesignAI-reports 规范**（来自 DesignAI-reports_20260610_172619）。  
> 如需执行图表美化，优先加载 DesignAI-reports SKILL.md 的 Mode A 或 Mode C。  
> 🆕 **站点框架层**：完整站点交互组件见 `data-components/site-chrome.md`，本文件只描述应用规则。

---

## 零、站点层 vs 内容层（两层分工）

```
站点层（Site Chrome）         内容层（Data Content）
─────────────────────────     ─────────────────────────────────
GlobalTopbar（固定，整站）     Report Header（报告标识）
Left Sidebar（左侧导航）       KPI Row（关键指标卡片）
Primary Tab（主视角切换）      Charts Section（图表）
Secondary Tab（子视角切换）    Analysis Text（文字解读）
FilterBar（多行筛选区）        Detail Table（明细数据）
Page Topbar（标题+操作按钮）   Footer（来源注释）
─────────────────────────     ─────────────────────────────────
见 data-components/site-chrome.md    见本文件 §三、模块级规范
```

**生成规则**：
- 简洁版日报（邮件/PDF）：只需内容层，无站点层
- 完整站点版日报：必须先构建站点层骨架，再填充内容层
- 用户未说明时：默认生成带站点层的完整版

---

## 一、叙事节奏（Module Flow）

```
01. Report Header        ← 报告标识：标题 + 时间范围 + 核心摘要（1-2 句结论）
02. KPI Row              ← 关键指标：4 个 KPI 卡片（含 Sparkline，仅有数据时加）
03. Charts Section       ← 趋势分析：折线图 / 柱状图 / 同比对比
04. Analysis Text        ← 文字解读：结论句 + 数字高亮 + 归因说明
05. Detail / Breakdown   ← 明细数据：分维度表格 / 分渠道 / 分地区
06. Footer               ← 来源注释 + 时间戳 + 说明
```

---

## 二、视觉规范（三层映射）

### 2.1 整体基调

- **[用户感受]**：看起来像专业财务报告，干净、信息密度高，不会觉得花哨。
- **[设计原理]**：数据场景强调「信息密度」和「可信度」，装饰即噪声，颜色只用于语义区分。
- **[技术实现]**：页面底色 `#F9FAFB`；卡片 `#FFFFFF`；主色 `#2261F5`（CF 蓝）；`border-radius: 6px`（不超过 8px）。

### 2.2 数字优先

- **[用户感受]**：那些重要数字非常大，一眼就能看到。
- **[设计原理]**：KPI 数字是报告中信息密度最高的元素，应是区域内最大字号，用 tabular-nums 对齐。
- **[技术实现]**：KPI 数字 `font-size: 32px; font-weight: 700; font-variant-numeric: tabular-nums`；必须 ≥ 28px。

### 2.3 色彩语义

- **[用户感受]**：涨了是绿色，跌了是红色，很直觉。
- **[设计原理]**：语义色系统：正向 = 绿，负向 = 红，中性 = 灰，预测 = 橙；颜色只承载数据含义，不做装饰。
- **[技术实现]**：正向 `#2EAD5E`；负向 `#D95040`；中性 `#9CA3AF`；警告/预测 `#D97706`。

### 2.4 卡片设计

- **[用户感受]**：东西都整整齐齐地放在白色小格子里，边框细细的，很专业。
- **[设计原理]**：卡片用边框 + 白底定义空间，不用背景色块，装饰性最低。
- **[技术实现]**：`border: 1px solid #E5E7EB; border-radius: 6px; background: #FFFFFF; padding: 24px`。

---

## 三、模块级规范

### 模块 01：Report Header（报告头）

> 必须实现 5 层微质感结构（不得用纯色平底）

```html
<!-- 5 层叠加：邻近色渐变底 + 右上白光晕 + 左下蓝紫补光晕 + 细点阵底纹 + 内容层 -->
<div class="report-header">
  <span class="rh-dots"></span>      <!-- 层3 点阵 -->
  <span class="rh-glow-main"></span> <!-- 层1 主光晕 -->
  <span class="rh-glow-sub"></span>  <!-- 层2 补光晕 -->
  <div class="rh-content">           <!-- 层4 内容 -->
    <div class="rh-eyebrow">2025 年 W25 周报 · 运营数据</div>
    <h1 class="rh-title">本周核心结论标题，用结论句而非描述句</h1>
    <p class="rh-summary">补充说明，1-2 句，体现关键数字或趋势</p>
    <div class="rh-meta">
      <span>数据范围：2025-06-16 至 2025-06-22</span>
      <span>更新时间：2025-06-23 09:00</span>
    </div>
  </div>
</div>
```

```css
.report-header {
  position: relative;
  border-radius: 14px;
  padding: 42px 52px;
  margin-bottom: 32px;
  overflow: hidden;
  background: linear-gradient(145deg, #E4EEFF 0%, #E8EAFF 30%, #E0EEFF 62%, #E4F2FF 100%);
}
.rh-glow-main {
  position: absolute; top: -90px; right: -70px;
  width: 520px; height: 380px;
  background: radial-gradient(ellipse at 58% 32%, rgba(255,255,255,0.90) 0%, rgba(255,255,255,0.52) 25%, rgba(255,255,255,0.18) 48%, transparent 68%);
  pointer-events: none;
}
.rh-glow-sub {
  position: absolute; bottom: -55px; left: -35px;
  width: 340px; height: 230px;
  background: radial-gradient(ellipse at center, rgba(108,99,255,0.12) 0%, rgba(108,99,255,0.04) 50%, transparent 72%);
  pointer-events: none;
}
.rh-dots {
  position: absolute; inset: 0;
  background-image: radial-gradient(circle, rgba(59,127,245,0.13) 1px, transparent 1px);
  background-size: 18px 18px;
  pointer-events: none;
}
.rh-content { position: relative; z-index: 1; }
.rh-eyebrow { font-size: 12px; color: #2261F5; font-weight: 600; letter-spacing: 0.06em; text-transform: uppercase; margin-bottom: 12px; }
.rh-title   { font-size: 28px; font-weight: 700; color: #111827; line-height: 1.25; margin-bottom: 12px; }
.rh-summary { font-size: 14px; color: #374151; line-height: 1.6; margin-bottom: 20px; }
.rh-meta    { display: flex; gap: 24px; font-size: 12px; color: #6B7280; }
```

### 模块 02：KPI Row

> 详细规范见 `data-components/kpi-card.md`

```
布局：    grid-cols-4（3 或 4 个 KPI），gap: 10px
变体：    .kc（蓝/主指标）/ .kc.pos（绿/正向）/ .kc.neg（红/风险）/ .kc.purple（紫/率类）
Sparkline：仅在有 ≥ 3 个历史数据点时加 canvas，禁止捏造数据
数字：    ≥ 28px，tabular-nums，页面最大字号
```

### 模块 03：Charts Section

> 详细图表配置见 `data-components/echarts-config.md`

```
双栏布局：  display:grid; grid-template-columns: 1fr 1fr; gap: 24px
卡片：      display:flex; flex-direction:column（内部让 ECharts 容器 flex:1; min-height:0）
图表容器：  禁止固定 px 高度；最低兜底 min-height: 260px
标题要求：  结论句，而非描述标签（"收入持续增长" 而非 "收入趋势"）
面积填充：  area fill opacity ≤ 0.12
轴标签：    11px / #9CA3AF
图例：      11px / #6B7280
```

### 模块 04：Analysis Text（文字解读）

```css
/* 文字高亮类（按需使用） */
.hl-num  { color: var(--color-primary); font-weight: 600; font-variant-numeric: tabular-nums; }
.hl-num.pos { color: #2EAD5E; }
.hl-num.neg { color: #D95040; }
.hl-mark { background: rgba(34,97,245,0.08); border-radius: 3px; padding: 1px 4px; }
.hl-quote {
  border-left: 3px solid var(--color-primary);
  padding: 8px 16px;
  background: rgba(34,97,245,0.04);
  border-radius: 0 4px 4px 0;
  margin: 12px 0;
  font-size: 14px; color: #374151;
}
```

> 使用规则：每段最多标注 1-3 个关键数字/词，禁止整行背景色，禁止 3 种高亮颜色同段。

### 模块 05：Detail / Breakdown（数据明细）

> 详细规范见 `data-components/table-spec.md`

```
表头：      uppercase，font-size: 11px，letter-spacing: 0.06em，#6B7280
数字列：    tabular-nums，text-align: right
条纹：      奇偶行 #F9FAFB / #FFFFFF
hover：     背景 #EFF6FF
分页：      超过 20 行建议分页或折叠
```

### 模块 06：Footer

```html
<footer class="report-footer">
  <span>数据来源：内部数据仓库</span>
  <span>生成时间：2025-06-23 09:00 CST</span>
  <span>如有疑问请联系数据分析团队</span>
</footer>
```

```css
.report-footer {
  margin-top: 48px;
  padding-top: 16px;
  border-top: 1px solid #E5E7EB;
  display: flex;
  gap: 24px;
  font-size: 11px;
  color: #9CA3AF;
}
```

---

## 四、站点交互层规范（Site Chrome 应用规则）

> 本节规定在「完整站点版」日报中，各站点组件的具体配置。  
> 详细组件 HTML/CSS 见 `data-components/site-chrome.md`。

### 4.1 布局约束

```
全局 Topbar    height: 48px，固定，白底，包含一级导航 + 用户头像
Left Sidebar   width: 176px，可折叠至 56px，白底，含分组+二级项
PageTopbar     报告标题 + 负责人 + 刷新/导出 按钮
Primary Tab    视角级切换（如：日报 / 周报 / 月报，或业务线切换）
Secondary Tab  指标维度切换（如：GMV / 订单 / UV），用 Pill 风格
FilterBar      1-2 行筛选（时间区间 + 关键维度），可折叠收起
```

### 4.2 日报筛选栏标准项

| 筛选项 | 控件类型 | 备注 |
|--------|---------|------|
| 时间区间 | DateRange Picker | 必需，默认最近 7 天 |
| 颗粒度 | Radio（日/周/月）| 必需 |
| 对比周期 | Radio（环比/同比/自定义）| 必需 |
| 展示形式 | Radio（累计/均值）| 可选 |
| 一级分组 | Select（下拉，全部）| 根据业务场景 |
| 二级分组 | Select（下拉，全部）| 根据业务场景 |

### 4.3 Tab 使用规则

```
Primary Tab：切换时整个内容区重新加载，显示 Skeleton 占位
Secondary Tab：切换时只刷新对应图表/表格，无需整页 Skeleton
Tab 宽度：按文字宽度自适应，不固定等宽
Tab 上限：Primary ≤ 5 个，Secondary ≤ 8 个（超出用"更多"下拉）
```

### 4.4 报告在站点中的定位（vs 纯文档报告）

| 对比项 | 纯文档报告 | 站点版日报 |
|-------|-----------|-----------|
| 导航 | 无 | GlobalTopbar + Sidebar |
| 时间筛选 | 标题写死 | FilterBar 动态选择 |
| 视角切换 | 手动滚动 | Primary/Secondary Tab |
| 指标钻取 | 无 | Section 内联交互 |
| 图表操作 | 无 | 卡片右上角 ··· 菜单 |
| 刷新更新 | 手动替换文件 | 刷新按钮/自动轮询 |

---

## 五、Self-Check 补充项（Data Report 专属）

```
内容层检查：
[ ] Report Header 已实现 5 层微质感（不是纯色平底）
[ ] KPI 数字 ≥ 28px，是区域内最大字号
[ ] KPI Sparkline 仅在有历史序列数据时添加（禁止捏造）
[ ] 图表标题是结论句（而非描述标签）
[ ] delta 仅用颜色区分，正绿 #2EAD5E / 负红 #D95040（无 ▲▼ 字符）
[ ] ECharts 容器使用 flex:1; min-height:0（禁止固定 px 高度）
[ ] 双栏图表左右底部对齐（无悬空留白）
[ ] 无彩色卡片顶条
[ ] 文字高亮克制（每段 ≤ 3 处，无整行背景色）
[ ] 表格表头 uppercase，数字列右对齐 + tabular-nums
[ ] Footer 有数据来源和时间戳

站点层检查（完整站点版才检查）：
[ ] GlobalTopbar 高度 48px，含品牌 Logo + 导航 + 用户头像
[ ] Left Sidebar 白底，可折叠，导航项 active 状态 #EBF0FF + #165DFF
[ ] Primary Tab 用下划线样式，active 有蓝色底线
[ ] Secondary Tab 用 Pill 样式，active 有浅蓝背景
[ ] FilterBar 第一行含时间区间 + 颗粒度 + 对比方式
[ ] FilterBar 超过一行时有折叠收起按钮
[ ] 图表卡片有 ··· 更多操作按钮（hover 显示）
[ ] 动效：Sidebar 折叠 250ms，Tab 切换 indicator 滑动，数字加载有 countUp
```
