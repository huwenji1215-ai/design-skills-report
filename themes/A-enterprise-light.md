# themes/A-enterprise-light.md — 企业亮色主题

> **适用场景**：Landing Page ★ / 工具应用 / 数据日报 ★ / 数据看板 ★  
> **视觉气质**：科技商务感，干净克制，「大厂风」，数平蓝设计系统。  
> **用户印象**："看起来很专业大厂"、"非常干净整洁"、"清爽的科技蓝"、"值得信赖"  
> **字体组合**：Inter（标题）+ PingFang SC 中文补字

---

## CSS Token 变量（复制至 :root）

```css
:root {
  /* ─── 品牌主色（数平蓝）───────────────────────────── */
  --color-primary:       #2563F4;   /* 数平蓝，核心品牌色 */
  --color-primary-500:   #2563F4;   /* 同上，Figma 色阶命名别名 */
  --color-primary-600:   #1E54D4;   /* Hover / Active 加深 */
  --color-primary-700:   #1844AA;   /* 深色背景下的强调蓝 */
  --color-primary-400:   #4F80F7;   /* 次强调 / 图表辅助蓝 */
  --color-primary-300:   #7FA3FA;   /* 浅蓝辅助 */
  --color-primary-100:   #EBF1FE;   /* 选中背景 / Tag 底色 */
  --color-primary-50:    #F4F7FE;   /* 极浅蓝，区块背景 */

  /* ─── 灰度色（从参考图提取）────────────────────────── */
  --color-gray-900: #1A1A2E;   /* 最深，近黑 */
  --color-gray-800: #23242E;   /* 深标题 */
  --color-gray-700: #333447;   /* 次深 */
  --color-gray-600: #4B4D63;   /* 正文深色 */
  --color-gray-500: #696B80;   /* 正文次级 */
  --color-gray-400: #9395A8;   /* 辅助说明 */
  --color-gray-300: #C0C2CF;   /* 边框 */
  --color-gray-200: #DFE0E8;   /* 分隔线 */
  --color-gray-100: #F0F1F5;   /* 底色区块 */
  --color-gray-50:  #F7F8FA;   /* 页面底色 */

  /* ─── 语义色 ──────────────────────────────────────── */
  /* 警示红 */
  --color-danger:        #F04848;   /* 主错误色 */
  --color-danger-light:  #FEF0F0;   /* 错误背景 */

  /* 成功绿 */
  --color-success:       #18A058;   /* 主成功色 */
  --color-success-light: #EDF7F1;   /* 成功背景 */

  /* 警告橙 */
  --color-warning:       #F0800A;   /* 主警告色 */
  --color-warning-light: #FEF3E6;   /* 警告背景 */

  /* 信息蓝（info，区别于品牌主色）*/
  --color-info:          #2563F4;   /* 与主色共用 */
  --color-info-light:    #EBF1FE;

  /* ─── 数据语义色（报告/看板专用，区别于 UI 语义色）── */
  --color-positive: #18A058;  /* 增长 / 达成 / 正向 delta */
  --color-negative: #F04848;  /* 下降 / 风险 / 负向 delta */
  --color-neutral:  #9395A8;  /* 中性 / 持平 */
  --color-forecast: #F0800A;  /* 预测 / 预警 / 橙色标注 */

  /* ─── 背景层级 ────────────────────────────────────── */
  --color-bg-page:   #F7F8FA;  /* 整页底色（极浅灰，非纯白）*/
  --color-bg-card:   #FFFFFF;  /* 卡片白底 */
  --color-bg-subtle: #EBF1FE;  /* 次级信息带、高亮区块、选中行 */
  --color-bg-hover:  #F0F1F5;  /* 表格 hover 行底色 */

  /* ─── 文字层级 ────────────────────────────────────── */
  --color-text-primary:   #1A1A2E;  /* 标题 / 重要数字 */
  --color-text-body:      #4B4D63;  /* 正文 */
  --color-text-secondary: #9395A8;  /* 辅助说明 / 标签 */
  --color-text-disabled:  #C0C2CF;  /* 禁用 / placeholder */

  /* ─── 边框与分隔 ──────────────────────────────────── */
  --color-border:  #DFE0E8;
  --color-divider: #F0F1F5;

  /* ─── 阴影 ───────────────────────────────────────── */
  --shadow-sm: 0 1px 4px rgba(37, 99, 244, 0.06);
  --shadow-md: 0 4px 12px rgba(37, 99, 244, 0.10);
  --shadow-lg: 0 8px 32px rgba(37, 99, 244, 0.12);
}
```

---

## 字体配置

```css
body {
  font-family: "Inter", -apple-system, "PingFang SC", "Helvetica Neue", Arial, sans-serif;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
  color: var(--color-text-body);
  background: var(--color-bg-page);
}
```

---

## 主题专属组件样式

### Hero 区域背景

```css
/* Landing Page Hero 区域的 mesh gradient（仅 Hero 可用）*/
.hero-bg {
  background: linear-gradient(135deg, #EBF1FE 0%, #FFFFFF 50%, #F4F7FE 100%);
  position: relative;
  overflow: hidden;
}

/* Hero 装饰光晕（absolute 定位，pointer-events:none）*/
.hero-blob-1 {
  position: absolute; top: -120px; right: -80px;
  width: 600px; height: 480px;
  background: radial-gradient(ellipse, rgba(37,99,244,0.08) 0%, transparent 65%);
  pointer-events: none;
}
.hero-blob-2 {
  position: absolute; bottom: -80px; left: -60px;
  width: 400px; height: 300px;
  background: radial-gradient(ellipse, rgba(79,128,247,0.06) 0%, transparent 65%);
  pointer-events: none;
}
```

### 卡片样式

```css
.card {
  background: var(--color-bg-card);
  border: 1px solid var(--color-border);
  border-radius: 8px;
  padding: 20px 24px;
  transition: box-shadow 0.2s;
}
.card:hover { box-shadow: var(--shadow-md); }

/* 数据卡片（更紧凑，数报/看板场景）*/
.card-data {
  background: var(--color-bg-card);
  border: 1px solid var(--color-border);
  border-radius: 6px;
  padding: 16px 20px;
}
```

### 按钮样式

```css
.btn-primary {
  background: var(--color-primary);
  color: #FFFFFF;
  border: none;
  padding: 8px 20px;
  border-radius: 6px;
  font-size: 14px;
  font-weight: 500;
  cursor: pointer;
  transition: background 0.15s;
}
.btn-primary:hover  { background: var(--color-primary-600); }
.btn-primary:active { background: var(--color-primary-700); }

.btn-secondary {
  background: #FFFFFF;
  color: var(--color-text-body);
  border: 1px solid var(--color-border);
  padding: 7px 20px;
  border-radius: 6px;
  font-size: 14px;
  cursor: pointer;
  transition: border-color 0.15s, color 0.15s;
}
.btn-secondary:hover { border-color: var(--color-primary); color: var(--color-primary); }

.btn-ghost {
  background: transparent;
  color: var(--color-primary);
  border: none;
  padding: 7px 16px;
  font-size: 14px;
  cursor: pointer;
  transition: background 0.15s;
}
.btn-ghost:hover { background: var(--color-primary-100); }
```

### Badge / Tag 样式

```css
/* 蓝色品牌 Tag */
.tag {
  display: inline-flex; align-items: center;
  background: var(--color-primary-100);
  color: var(--color-primary);
  font-size: 12px; font-weight: 500;
  padding: 2px 10px; border-radius: 4px;
}

/* 语义色 Tag */
.tag-success { background: #EDF7F1; color: #18A058; }
.tag-danger  { background: #FEF0F0; color: #F04848; }
.tag-warning { background: #FEF3E6; color: #F0800A; }
.tag-neutral { background: #F0F1F5; color: #696B80; }
```

### Section 标题

```css
.section-header {
  text-align: center;
  margin-bottom: 48px;
}
.section-title {
  font-size: 32px; font-weight: 700;
  color: var(--color-text-primary);
  margin-bottom: 12px;
}
.section-subtitle {
  font-size: 16px;
  color: var(--color-text-secondary);
  max-width: 560px; margin: 0 auto;
  line-height: 1.7;
}
```

### Tab（数据场景：下划线式）

```css
.tab-bar { display: flex; border-bottom: 1px solid var(--color-border); }
.tab-item {
  padding: 8px 16px;
  font-size: 14px; color: var(--color-text-secondary);
  cursor: pointer; position: relative;
  transition: color 0.15s;
}
.tab-item:hover { color: var(--color-text-body); }
.tab-item.active {
  color: var(--color-primary); font-weight: 500;
}
.tab-item.active::after {
  content: '';
  position: absolute; bottom: -1px; left: 0; right: 0;
  height: 2px;
  background: var(--color-primary);
  border-radius: 1px 1px 0 0;
}
```

---

## ECharts 配色（数据场景使用）

```javascript
// 主题 A — 数平蓝配色序列
const THEME_A_PALETTE = [
  '#2563F4',  // 数平蓝（主系列）
  '#18A058',  // 绿（正向/成功）
  '#F0800A',  // 橙（预测/警告）
  '#F04848',  // 红（负向/危险）
  '#9B59B6',  // 紫
  '#00B4D8',  // 青蓝
  '#F0C030',  // 黄
  '#4F80F7',  // 浅蓝（辅助蓝系列）
  '#9395A8',  // 灰（对比低优先级）
];

// ECharts 主题 A 基础配置
const ECHARTS_THEME_A = {
  color: THEME_A_PALETTE,
  backgroundColor: 'transparent',
  textStyle: { fontFamily: 'Inter, PingFang SC, sans-serif', fontSize: 12 },
  grid: { top: 48, right: 16, bottom: 32, left: 48, containLabel: true },
  xAxis: {
    axisLine:  { lineStyle: { color: '#DFE0E8' } },
    axisTick:  { show: false },
    axisLabel: { color: '#9395A8', fontSize: 12 },
    splitLine: { show: false },
  },
  yAxis: {
    axisLine:  { show: false },
    axisTick:  { show: false },
    axisLabel: { color: '#9395A8', fontSize: 12 },
    splitLine: { lineStyle: { color: '#F0F1F5', type: 'dashed' } },
  },
  legend: { textStyle: { color: '#696B80', fontSize: 12 } },
  tooltip: {
    backgroundColor: '#1A1A2E',
    borderWidth: 0,
    textStyle: { color: '#FFFFFF', fontSize: 13 },
    padding: [8, 12],
  },
};
```

---

## Self-Check 补充项（主题 A 专属）

```
[ ] 主色使用 #2563F4（数平蓝，不是阿里云蓝 #1677FF）
[ ] 页面底色 #F7F8FA（不是纯白 #FFF）
[ ] Hero 光晕 blob 设置了 pointer-events: none，opacity ≤ 0.08
[ ] 卡片 border-radius：Landing Page 用 12px，数据/工具场景用 6-8px
[ ] 按钮有 hover（600）和 active（700）两级状态
[ ] 正向 delta 使用 #18A058，负向 delta 使用 #F04848
[ ] ECharts 图表第一系列色为 #2563F4
[ ] Tab active 线使用 #2563F4，高度 2px
```
