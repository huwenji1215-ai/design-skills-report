# themes/B-dark-pro.md — 深色专业主题

> **适用场景**：数据看板 ★ / 监控大屏 / 高管汇报 / 数据日报（深色版）  
> **视觉气质**：高端科技感，暗夜蓝，精密仪器质感，来自 DesignAI-reports Dark 主题  
> **用户印象**："像专业监控大屏"、"很有高端科技感"、"数据在暗色上更突出"  
> **字体组合**：Inter（推荐）+ PingFang SC 中文补字

---

## CSS Token 变量（复制至 :root）

```css
:root {
  /* 品牌色 */
  --color-primary:       #3B82F6;   /* 亮蓝（深色背景上需要更亮）*/
  --color-primary-light: rgba(59,130,246,0.15);
  --color-primary-dark:  #2563EB;

  /* 语义色 */
  --color-success:  #34D399;   /* 更亮的绿，在深色下可见 */
  --color-danger:   #F87171;   /* 更亮的红 */
  --color-warning:  #FBBF24;   /* 更亮的橙黄 */

  /* 数据语义色 */
  --color-positive: #34D399;
  --color-negative: #F87171;
  --color-neutral:  #9CA3AF;

  /* 背景层级（深色）*/
  --color-bg-page:   #0F172A;   /* 最深底色：深蓝黑 */
  --color-bg-card:   #1E293B;   /* 卡片背景：深蓝灰 */
  --color-bg-subtle: #263148;   /* 次级区块：略浅 */
  --color-bg-hover:  #2D3748;   /* hover 状态 */

  /* 文字层级（深色下反转）*/
  --color-text-primary:   #F1F5F9;  /* 主要文字：近白 */
  --color-text-body:      #CBD5E1;  /* 正文：浅灰 */
  --color-text-secondary: #94A3B8;  /* 辅助说明：中灰 */
  --color-text-disabled:  #4B5563;  /* 禁用：深灰 */

  /* 边框与分隔（深色下更淡）*/
  --color-border:  #334155;
  --color-divider: #1E293B;

  /* 阴影（深色下阴影基于暗色）*/
  --shadow-sm: 0 1px 4px rgba(0, 0, 0, 0.3);
  --shadow-md: 0 4px 12px rgba(0, 0, 0, 0.4);
  --shadow-lg: 0 8px 32px rgba(0, 0, 0, 0.5);

  /* 特殊：大屏发光效果（仅深色主题可用，适度使用）*/
  --glow-primary: 0 0 20px rgba(59,130,246,0.25);
  --glow-success: 0 0 16px rgba(52,211,153,0.20);
}
```

---

## 字体配置

```css
body {
  font-family: "Inter", -apple-system, "PingFang SC", "Helvetica Neue", Arial, sans-serif;
  background: var(--color-bg-page);
  color: var(--color-text-body);
  -webkit-font-smoothing: antialiased;
}
```

---

## 主题专属组件样式

### 卡片

```css
.card {
  background: var(--color-bg-card);
  border: 1px solid var(--color-border);
  border-radius: 8px;
  padding: 20px 24px;
}
.card:hover { border-color: rgba(59,130,246,0.4); }

/* 高亮卡片（重要 KPI 或选中状态）*/
.card-highlight {
  background: var(--color-bg-card);
  border: 1px solid rgba(59,130,246,0.4);
  border-radius: 8px;
  box-shadow: var(--glow-primary);
}
```

### 状态指示与告警

```css
/* 深色下状态点颜色更亮 */
.pulse-dot.ok       { background: #34D399; box-shadow: 0 0 6px rgba(52,211,153,0.5); }
.pulse-dot.warn     { background: #FBBF24; box-shadow: 0 0 6px rgba(251,191,36,0.5); }
.pulse-dot.critical { background: #F87171; box-shadow: 0 0 6px rgba(248,113,113,0.5); }

/* 告警区 */
.alert-zone.critical { border-color: #F87171; background: rgba(248,113,113,0.08); }
.alert-zone.warn     { border-color: #FBBF24; background: rgba(251,191,36,0.08); }
```

### 数字高亮（深色下更亮）

```css
.kpi-value { color: #F1F5F9; font-size: 32px; font-weight: 700;
             font-variant-numeric: tabular-nums; }
.delta.pos { color: #34D399; }
.delta.neg { color: #F87171; }
.delta.neu { color: #94A3B8; }
```

### 导航与 Sidebar（深色工具布局）

```css
.sidebar         { background: #0F172A; border-right: 1px solid #1E293B; }
.nav-item        { color: #94A3B8; }
.nav-item:hover  { background: #1E293B; color: #CBD5E1; }
.nav-item.active { background: rgba(59,130,246,0.12); color: #3B82F6; }

.topbar { background: #1E293B; border-bottom: 1px solid #334155; }
```

### 表格（深色）

```css
.data-table th { color: #64748B; border-bottom-color: #334155; }
.data-table td { color: #CBD5E1; border-bottom-color: #1E293B; }
.data-table tr:hover td { background: #263148; }
```

### 按钮（深色）

```css
.btn-primary {
  background: var(--color-primary);
  color: #FFFFFF; border: none;
  padding: 9px 20px; border-radius: 6px; font-size: 14px; font-weight: 500;
}
.btn-primary:hover { background: var(--color-primary-dark); }
.btn-secondary {
  background: transparent;
  color: var(--color-text-body);
  border: 1px solid var(--color-border);
  padding: 8px 20px; border-radius: 6px;
}
.btn-secondary:hover { background: var(--color-bg-subtle); }
```

---

## ECharts 配色（深色主题专用）

```javascript
// 深色下颜色需提高亮度，保证对比度
const THEME_B_PALETTE = [
  '#3B82F6',  // 亮蓝
  '#34D399',  // 亮绿
  '#FBBF24',  // 亮橙
  '#F87171',  // 亮红
  '#A78BFA',  // 亮紫
  '#22D3EE',  // 亮青
  '#94A3B8',  // 中灰
];

// ECharts 背景（深色必须覆盖）
const echartsDarkBg = {
  backgroundColor: 'transparent',  // 使用透明，让卡片背景透过
  textStyle: { color: '#94A3B8' },
  title: { textStyle: { color: '#F1F5F9' } },
  legend: { textStyle: { color: '#94A3B8' } },
  xAxis: { axisLine: { lineStyle: { color: '#334155' } },
           axisLabel: { color: '#64748B' },
           splitLine: { lineStyle: { color: '#1E293B' } } },
  yAxis: { axisLine: { lineStyle: { color: '#334155' } },
           axisLabel: { color: '#64748B' },
           splitLine: { lineStyle: { color: '#1E293B', type: 'dashed' } } },
  tooltip: { backgroundColor: '#1E293B', borderColor: '#334155',
             textStyle: { color: '#F1F5F9' } }
};
```

---

## 大屏模式补充（1920×1080 全屏展示）

```css
/* 适用于监控大屏展示环境 */
@media (min-width: 1920px) {
  .page     { max-width: 100%; padding: 24px 48px; }
  .kpi-value { font-size: 40px; }
  .card     { padding: 24px 28px; }
}

/* 大屏标题发光效果 */
.screen-title {
  font-size: 20px; font-weight: 700;
  color: #F1F5F9;
  text-shadow: 0 0 20px rgba(59,130,246,0.4);
}
```

> ⚠️ 发光效果（glow/text-shadow）仅在深色大屏模式下允许适度使用，  
> 普通深色报告/看板不建议使用，以保持克制感。

---

## Self-Check 补充项（主题 B 专属）

```
[ ] body background 是 #0F172A（不是纯黑 #000000）
[ ] 卡片背景是 #1E293B（不是 #111827）
[ ] 正文文字 #CBD5E1（不是 #FFFFFF，避免过亮刺眼）
[ ] 状态点在深色下有微弱 glow（rgba 透明）
[ ] ECharts 配色使用亮色系版本（不是亮色主题的颜色直接搬来）
[ ] ECharts backgroundColor 设为 transparent（让卡片背景透过）
[ ] delta.pos 使用 #34D399（不是 #52C41A，深色下不够亮）
[ ] 图表轴线和分割线颜色已覆盖为深色主题版本
```
