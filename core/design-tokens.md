# design-tokens.md — 全局设计 Token

> **本文件包含**：色彩系统 / 字号体系 / 间距规则 / 圆角与阴影 / Page Shell 骨架  
> **本文件不包含**：每套主题的具体 CSS 变量（见 `themes/`）/ 组件实现代码（见 `data-components/`）  
> **加载时机（Tier 3）**：需要精确定制 Token、或审查样式规范时按需加载。  
> 常规使用时，读 Tier 1 场景文件 + Tier 2 主题文件即可，无需读本文件。

---

## 一、色彩语义角色（场景无关，跨主题通用）

> 各主题文件中的 CSS 变量均映射到以下角色。修改主题时只改 Token 值，角色语义不变。

```
角色名            用途说明
─────────────────────────────────────────────────────────
--color-primary   主品牌色：行动按钮、链接、高亮、图标主色
--color-primary-light  主色浅色版：hover 背景、Tag 背景
--color-primary-dark   主色深色版：active 状态

--color-success   正向语义：增长 / 达成 / 安全 / 通过
--color-danger    负向语义：下降 / 风险 / 错误 / 失败
--color-warning   预警语义：预测值 / 注意 / 临近阈值

--color-bg-page   页面底色（最外层背景）
--color-bg-card   卡片背景色
--color-bg-subtle 次级内容区背景（区块分隔）

--color-text-primary   标题、重要数字
--color-text-body      正文
--color-text-secondary 辅助说明、标签
--color-text-disabled  placeholder、禁用状态

--color-border     常规边框
--color-divider    分隔线（比边框更轻）
```

---

## 二、字号体系（5 级，全场景通用，禁止自造第 6 级）

```
级别       尺寸      字重     行高    用途
──────────────────────────────────────────────────────────────
display    40px     700     1.1     页面主标题（Hero / 报告大标题）
h1         24px     600     1.25    区块标题（Section Title）
h2         16px     600     1.4     模块标题、卡片标题
body       14px     400     1.6     段落正文
small      12px     400     1.5     元数据、来源注释、说明文字
metric     28-36px  700     1.0     KPI 大数字（≥ 28px，必须是区域最大字号）
```

### 字重禁止项

```
❌ font-weight: 100 — 中文下糊，禁止
❌ font-weight: 300 — 中文下偏细，禁止
✅ 允许: 400 / 500 / 600 / 700
```

### 字母间距规则

```
大写标签（表头 / Badge）：  letter-spacing: 0.06em
中文标题：                  letter-spacing: -0.01em
其他（正文/数字）：          letter-spacing: 0
```

### 字体栈（各主题可覆盖）

```css
/* 默认（多语言通用）*/
font-family: "Inter", -apple-system, "PingFang SC", "Helvetica Neue", Arial, sans-serif;

/* 等宽数字（KPI / 表格 / 图表）*/
font-variant-numeric: tabular-nums;   /* ← 数字列必须加，防止对齐抖动 */
```

---

## 三、间距体系（8px 基准网格）

> 所有间距取值必须是 8 的倍数（4px 仅用于 icon ↔ 文字这类极小间隙）。

```
4px   icon 与文字之间的行内间隙
8px   组件内部元素间距（如 label 与 value）
16px  卡片 padding（紧凑型）
24px  卡片 padding（标准型）
32px  组件之间的间距
48px  模块之间的间距（Section 内）
64px  区块之间的间距（大 Section 之间）
80px  Landing Page 区块上下 padding（py-20 等价）
```

---

## 四、圆角规则

```
场景                       圆角值       说明
──────────────────────────────────────────────────────
数据报告 / 看板 / 工具应用   4-6px        克制，商务
内容站 / 文档站              6-8px        适中
Landing Page（卡片）         8-12px       略圆润，现代
Landing Page（按钮/Badge）   4-6px        不宜过圆
全局上限（Landing Page）      16px         超出即返工
全局上限（其他场景）           8px          超出即返工
禁止                          50% / 9999px 胶囊形按钮仅在 Badge 上允许
```

---

## 五、阴影规则

```
等级      CSS                                    用途
──────────────────────────────────────────────────────────────
无阴影    —                                      默认卡片状态（用边框区分）
elevation-1   0 1px 4px rgba(0,0,0,0.08)        hover 状态 / 弹出组件
elevation-2   0 4px 16px rgba(0,0,0,0.12)       Modal / Dropdown
elevation-3   0 8px 32px rgba(0,0,0,0.16)       Toast / Popover（Landing Page 可用）
```

⚠️ **阴影硬性规则**：
```
[P0] 数据报告 / 看板：box-shadow 全页 ≤ 1 处（仅 hover 时可见）
[P0] 禁止彩色阴影（如 box-shadow: 0 0 20px rgba(34,97,245,0.4)）
[P0] 禁止多层叠加阴影
```

---

## 六、Page Shell 骨架（各场景通用起点）

```html
<!DOCTYPE html>
<html lang="zh-CN">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>[页面标题]</title>
<!-- 按需引入：Tailwind CDN 或 ECharts CDN -->
<style>
  *, *::before, *::after { box-sizing: border-box; margin: 0; padding: 0; }

  /* ── 在此粘贴主题 :root Token 块 ── */
  :root {
    /* 从对应 themes/ 文件复制 CSS 变量 */
  }

  body {
    font-family: "Inter", -apple-system, "PingFang SC", "Helvetica Neue", Arial, sans-serif;
    background: var(--color-bg-page);
    color: var(--color-text-primary);
    font-size: 14px;
    line-height: 1.6;
    -webkit-font-smoothing: antialiased;
  }

  .page {
    max-width: 1200px;   /* landing-page 可用 1440px；report 用 1120px */
    margin: 0 auto;
    padding: 48px 32px;
  }

  /* 响应式断点 */
  @media (max-width: 768px) {
    .page { padding: 24px 16px; }
    /* 场景文件中覆盖具体 grid */
  }
</style>
</head>
<body>
  <div class="page">
    <!-- 内容从这里开始 -->
  </div>
</body>
</html>
```

---

## 七、多栏对齐强制规则（⚠️ P0）

> 凡出现左右并排卡片/图表，必须遵守以下写法。

```css
/* 标准双栏等高布局 */
.col-row {
  display: grid;
  grid-template-columns: 1fr 1fr;  /* 三栏改 1fr 1fr 1fr */
  gap: 24px;
  align-items: stretch;            /* 默认值，禁止删除 */
}

/* 卡片内让 ECharts 容器填满 */
.card {
  display: flex;
  flex-direction: column;
  background: var(--color-bg-card);
  border: 1px solid var(--color-border);
  border-radius: 6px;
  padding: 24px;
}

.chart-container {
  flex: 1;
  min-height: 0;       /* ← flex 子元素必须加，否则撑不开 */
  min-height: 260px;   /* 最低兜底高度 */
}
```

```
❌ 禁止：给 ECharts 容器设固定 height（左右内容量不同时高度错位）
❌ 禁止：float 布局（无法等高对齐）
❌ 禁止：.card 缺少 display:flex; flex-direction:column
```
