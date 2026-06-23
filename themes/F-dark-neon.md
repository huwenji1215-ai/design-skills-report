# themes/F-dark-neon.md — 深色科技霓虹主题（数据场景默认）

> **来源**：基于快手 DataAgent 数据报告暗黑版精确提取（2026-06-23）  
> **定位**：深海军蓝底色 × 青蓝霓虹主色，专为数据日报 / 数据看板 / AI 报告设计  
> **气质**：深色科技感、太空/深海仪表板风格，带发光 glow 效果  
> **适用场景**：data-report ✅ / dashboard ✅ / tool-app ⚠️（需降低装饰强度）/ landing-page ⚠️  
> **🌟 数据场景默认主题**：当用户要求生成数据报告/看板但未指定主题时，优先使用本主题

---

## 一、CSS Token 变量（完整复制至 `:root`）

```css
:root {
  /* ── 背景色系（5层深度）── */
  --bg:     #060C1A;   /* 页面主背景：深海军蓝黑 */
  --bg2:    #0B1426;   /* 次级背景 */
  --bg3:    #101D35;   /* 三级背景（区块/chip 背景）*/
  --bg4:    #152240;   /* 四级背景（进度条底色）*/
  --card:   #0D1830;   /* 卡片/容器背景 */

  /* ── 品牌主色（青蓝/霓虹蓝）── */
  --cyan:      #00D4FF;
  --cyan-d:    #0099BB;             /* 深色变体 */
  --cyan-glow: rgba(0,212,255,0.18); /* 发光效果色 */

  /* ── 对应 web-site-beautifier 通用语义角色 ── */
  --color-primary:       #00D4FF;
  --color-primary-light: rgba(0,212,255,0.15);
  --color-primary-dark:  #0099BB;
  --color-on-primary:    #060C1A;

  /* ── 辅助霓虹色 ── */
  --purple: #A78BFA;
  --green:  #00F5B4;   /* 上涨/正向 */
  --amber:  #FBBF24;   /* 警告/预测 */
  --red:    #FF4757;   /* 下跌/负向 */
  --pink:   #F472B6;

  /* ── 语义色（对应通用规范）── */
  --color-success:  #00F5B4;
  --color-danger:   #FF4757;
  --color-warning:  #FBBF24;
  --color-positive: #00F5B4;
  --color-negative: #FF4757;
  --color-neutral:  #4A6080;

  /* ── 文字色（4级）── */
  --t1: #E2EAF8;   /* 主要标题/高亮 */
  --t2: #8BA3C7;   /* 正文 */
  --t3: #4A6080;   /* 次要/辅助 */
  --t4: #2A3A54;   /* 极弱（分隔/装饰）*/

  /* 对应通用 */
  --color-text-primary:   #E2EAF8;
  --color-text-body:      #8BA3C7;
  --color-text-secondary: #4A6080;

  /* ── 边框 ── */
  --border:  rgba(0,212,255,0.12);   /* 默认边框 */
  --border2: rgba(0,212,255,0.22);   /* 悬停/激活 */
  --color-border: rgba(0,212,255,0.12);

  /* ── 阴影 ── */
  --shadow-card:  0 0 0 1px rgba(0,212,255,0.12);
  --shadow-hover: 0 0 20px rgba(0,212,255,0.12), 0 0 0 1px rgba(0,212,255,0.22);
  --shadow-glow:  0 0 12px rgba(0,212,255,0.50);

  /* ── 背景网格线（body::before 使用）── */
  --grid-line: rgba(0,212,255,0.03);
}
```

---

## 二、全局基础样式

```css
body {
  background: var(--bg);
  color: var(--t2);
  font-family: "Inter", -apple-system, "PingFang SC", sans-serif;
  font-size: 13px;
  -webkit-font-smoothing: antialiased;
  min-height: 100vh;
  position: relative;
}

/* 45° 网格线背景纹理（深色科技感必备）*/
body::before {
  content: '';
  position: fixed; inset: 0; z-index: 0; pointer-events: none;
  background-image:
    linear-gradient(var(--grid-line) 1px, transparent 1px),
    linear-gradient(90deg, var(--grid-line) 1px, transparent 1px);
  background-size: 45px 45px;
}

/* 所有内容在网格线之上 */
.container, .card, .kc, .rpt-header, .chart-card { position: relative; z-index: 1; }

/* 页面容器 */
.page-container {
  max-width: 1100px;
  margin: 0 auto;
  padding: 40px 28px 72px;
}
```

---

## 三、卡片与容器

```css
/* ── 标准卡片 ── */
.card {
  background: var(--card);
  border: 1px solid var(--border);
  border-radius: 10px;
  padding: 24px 26px;
  transition: border-color 0.15s, box-shadow 0.15s;
}
.card:hover {
  border-color: var(--border2);
  box-shadow: var(--shadow-hover);
}

/* ── Report Header ── */
.rpt-header {
  background: linear-gradient(135deg, #0B1833 0%, #0D1F40 60%, #111B38 100%);
  border: 1px solid var(--border2);
  border-radius: 12px;
  padding: 32px 36px;
  position: relative;
  overflow: hidden;
  margin-bottom: 32px;
}
/* 顶部彩虹分隔线 */
.rpt-header::before {
  content: '';
  position: absolute; top: 0; left: 0; right: 0; height: 1px;
  background: linear-gradient(90deg,
    transparent, #00D4FF 20%, #A78BFA 50%, #F472B6 80%, transparent);
}
/* 右上角光晕 blob */
.rpt-header::after {
  content: '';
  position: absolute; top: -40px; right: -40px;
  width: 180px; height: 180px; border-radius: 50%;
  background: radial-gradient(circle, rgba(167,139,250,0.12), transparent 70%);
  pointer-events: none;
}
```

---

## 四、KPI 卡片（暗黑霓虹版）

```css
/* KPI 卡片基础 */
.kc {
  background: var(--card);
  border: 1px solid var(--border);
  border-radius: 10px;
  padding: 20px 22px;
  transition: border-color 0.2s, box-shadow 0.2s;
  position: relative;
  overflow: hidden;
}
.kc:hover {
  border-color: var(--border2);
  box-shadow: var(--shadow-hover);
}

/* 顶部装饰线（4种颜色变体）*/
.kc::before {
  content: '';
  position: absolute; top: 0; left: 0; right: 0; height: 2px;
  border-radius: 10px 10px 0 0;
}
.kc.cyan::before   { background: linear-gradient(90deg, #00D4FF, transparent); }
.kc.green::before  { background: linear-gradient(90deg, #00F5B4, transparent); }
.kc.amber::before  { background: linear-gradient(90deg, #FBBF24, transparent); }
.kc.purple::before { background: linear-gradient(90deg, #A78BFA, transparent); }

/* KPI 数字（渐变文字）*/
.kc-num {
  font-size: 36px; font-weight: 900;
  line-height: 1; letter-spacing: -0.02em;
  -webkit-background-clip: text; background-clip: text;
  -webkit-text-fill-color: transparent;
  font-variant-numeric: tabular-nums;
}
.kc.cyan   .kc-num { background-image: linear-gradient(135deg, #00D4FF, #60E5FF); }
.kc.green  .kc-num { background-image: linear-gradient(135deg, #00F5B4, #70FFC8); }
.kc.amber  .kc-num { background-image: linear-gradient(135deg, #FBBF24, #FFD060); }
.kc.purple .kc-num { background-image: linear-gradient(135deg, #A78BFA, #C4B5FD); }

/* KPI 单位 */
.kc-num .u { font-size: 18px; font-weight: 700; }

/* KPI 标签 */
.kc-label {
  font-size: 10px; font-weight: 600;
  color: var(--t3);
  text-transform: uppercase; letter-spacing: 0.05em;
  margin-bottom: 8px;
}

/* Delta（涨跌）*/
.kc-delta {
  display: inline-flex; align-items: center; gap: 3px;
  font-size: 11px; font-weight: 600; margin-top: 6px;
}
.kc-delta.up   { color: var(--green); }
.kc-delta.down { color: var(--red); }
.kc-delta.flat { color: var(--t3); }
```

### KPI HTML 示例

```html
<div class="kpi-grid kpi-grid-4">
  <div class="kc cyan">
    <div class="kc-label">累计GMV（元）</div>
    <div class="kc-num">12,831,712</div>
    <div class="kc-delta up">
      <svg width="8" height="8" viewBox="0 0 8 8" fill="none">
        <path d="M4 1L7 6H1L4 1Z" fill="currentColor"/>
      </svg>
      同比 +240%
    </div>
  </div>
  <div class="kc green">
    <div class="kc-label">累计订单（笔）</div>
    <div class="kc-num">6,712</div>
    <div class="kc-delta up">环比 +240%</div>
  </div>
  <div class="kc amber">
    <div class="kc-label">客单价（元）</div>
    <div class="kc-num">8,712</div>
    <div class="kc-delta flat">持平</div>
  </div>
  <div class="kc purple">
    <div class="kc-label">累计新UV</div>
    <div class="kc-num">59,712</div>
    <div class="kc-delta up">环比 +240%</div>
  </div>
</div>
```

---

## 五、Section 区块标题

```css
/* Section 编号方块 + 标题 */
.section-header {
  display: flex; align-items: center; gap: 12px;
  margin-bottom: 20px;
}
.section-num {
  width: 28px; height: 28px;
  border-radius: 7px;
  background: linear-gradient(135deg, #00D4FF, #0088AA);
  display: flex; align-items: center; justify-content: center;
  font-size: 13px; font-weight: 800; color: #060C1A;
  box-shadow: var(--shadow-glow);
  flex-shrink: 0;
}
.section-title {
  font-size: 16px; font-weight: 800; color: var(--t1);
}
/* 标题下分隔线 */
.section-divider {
  height: 1px;
  background: linear-gradient(90deg, var(--border2), transparent);
  margin-bottom: 20px;
}
```

```html
<div class="section-header">
  <div class="section-num">1</div>
  <div class="section-title">结论综述</div>
</div>
<div class="section-divider"></div>
```

---

## 六、ECharts 暗黑霓虹配置

```javascript
// 霓虹调色盘（8色）
const NEON_PALETTE = [
  '#00D4FF',  // 青蓝（主）
  '#A78BFA',  // 紫
  '#00F5B4',  // 绿
  '#FF6B9D',  // 粉红
  '#FBBF24',  // 琥珀
  '#FF4757',  // 红
  '#34D399',  // 淡绿
  '#60A5FA',  // 蓝
];

// ECharts 全局暗黑配置
const ECHARTS_DARK_NEON = {
  backgroundColor: 'transparent',
  color: NEON_PALETTE,
  textStyle: {
    fontFamily: '"Inter", -apple-system, "PingFang SC", sans-serif',
    color: '#4A6080',
  },
  title: {
    textStyle: { fontSize: 13, fontWeight: 700, color: '#E2EAF8' }
  },
  legend: {
    textStyle: { color: '#4A6080', fontSize: 11 },
    icon: 'circle', itemWidth: 8, itemHeight: 8, itemGap: 16,
  },
  grid: {
    top: 40, right: 16, bottom: 40, left: 16, containLabel: true
  },
  xAxis: {
    axisLine:  { lineStyle: { color: '#152240' } },
    axisLabel: { color: '#4A6080', fontSize: 11 },
    axisTick:  { show: false },
    splitLine: { show: false },
  },
  yAxis: {
    axisLine: { show: false },
    axisTick: { show: false },
    axisLabel: { color: '#4A6080', fontSize: 11 },
    splitLine: { lineStyle: { color: 'rgba(0,212,255,0.05)', type: 'dashed' } },
  },
  tooltip: {
    backgroundColor: '#060C1A',
    borderColor: 'rgba(0,212,255,0.30)',
    borderWidth: 1,
    textStyle: { color: '#E2EAF8', fontSize: 12 },
    extraCssText: 'box-shadow: 0 0 16px rgba(0,212,255,0.15); border-radius: 8px;',
  },
};

// 折线图（含面积填充）配置片段
function getNeonLineOption({ title, xData, series }) {
  return {
    ...ECHARTS_DARK_NEON,
    title: { text: title, ...ECHARTS_DARK_NEON.title },
    xAxis: { ...ECHARTS_DARK_NEON.xAxis, type: 'category', data: xData, boundaryGap: false },
    yAxis: { ...ECHARTS_DARK_NEON.yAxis, type: 'value' },
    series: series.map((s, i) => ({
      name: s.name, type: 'line', data: s.data,
      smooth: true,
      lineStyle: { width: 2, color: NEON_PALETTE[i % NEON_PALETTE.length] },
      itemStyle: { color: NEON_PALETTE[i % NEON_PALETTE.length] },
      areaStyle: {
        color: {
          type: 'linear', x: 0, y: 0, x2: 0, y2: 1,
          colorStops: [
            { offset: 0, color: NEON_PALETTE[i % NEON_PALETTE.length] + '1F' },  // ~12% opacity
            { offset: 1, color: NEON_PALETTE[i % NEON_PALETTE.length] + '00' }
          ]
        }
      }
    }))
  };
}

// 雷达图发光配置片段
const radarSeriesConfig = {
  type: 'radar',
  lineStyle: { color: '#00D4FF', width: 2 },
  areaStyle: { color: 'rgba(0,212,255,0.10)' },
  itemStyle: {
    color: '#00D4FF',
    shadowBlur: 6, shadowColor: 'rgba(0,212,255,0.8)'
  },
  symbolSize: 5,
};

// 雷达图坐标系配置
const radarIndicatorConfig = {
  splitLine:  { lineStyle: { color: 'rgba(0,212,255,0.10)' } },
  splitArea:  { areaStyle: { color: ['rgba(0,212,255,0.02)', 'rgba(0,212,255,0.05)'] } },
  axisLine:   { lineStyle: { color: 'rgba(0,212,255,0.10)' } },
  axisName:   { color: '#4A6080', fontSize: 11 },
};
```

---

## 七、表格样式（暗黑版）

```css
.data-table {
  width: 100%; border-collapse: collapse;
  font-variant-numeric: tabular-nums; font-size: 12px;
}
.data-table thead th {
  font-size: 10px; font-weight: 700;
  color: var(--t3);
  text-transform: uppercase; letter-spacing: 0.05em;
  background: rgba(0,212,255,0.04);
  border-bottom: 1px solid var(--border2);
  padding: 8px 12px; text-align: left;
  white-space: nowrap;
}
.data-table th.num, .data-table td.num { text-align: right; }
.data-table tbody td {
  color: var(--t2); font-size: 12px;
  border-bottom: 1px solid var(--border);
  padding: 8px 12px;
}
.data-table tbody tr:hover td { background: rgba(0,212,255,0.03); }
.data-table tbody tr:last-child td { border-bottom: none; }
```

---

## 八、进度条（带发光）

```css
.progress-bar-track {
  height: 6px; background: var(--bg4);
  border-radius: 3px; overflow: hidden;
}
.progress-bar-fill {
  height: 100%; border-radius: 3px;
  transition: width 0.6s cubic-bezier(0.4,0,0.2,1);
}
/* 颜色 + 发光 */
.progress-bar-fill.cyan   { background: #00D4FF; box-shadow: 0 0 6px rgba(0,212,255,0.5); }
.progress-bar-fill.green  { background: #00F5B4; box-shadow: 0 0 6px rgba(0,245,180,0.5); }
.progress-bar-fill.amber  { background: #FBBF24; box-shadow: 0 0 6px rgba(251,191,36,0.5); }
.progress-bar-fill.purple { background: #A78BFA; box-shadow: 0 0 6px rgba(167,139,250,0.5); }
.progress-bar-fill.red    { background: #FF4757; box-shadow: 0 0 6px rgba(255,71,87,0.5); }
```

---

## 九、Sparkline 颜色配置（暗黑版）

```javascript
// spark() 函数见 data-components/kpi-card.md
// 暗黑版颜色对照（fill 透明度 0.12）：
// spark('sp-gmv',    data, '#00D4FF', 'rgba(0,212,255,0.12)');    // 青蓝
// spark('sp-order',  data, '#00F5B4', 'rgba(0,245,180,0.12)');    // 绿
// spark('sp-price',  data, '#FBBF24', 'rgba(251,191,36,0.12)');   // 琥珀
// spark('sp-uv',     data, '#A78BFA', 'rgba(167,139,250,0.12)');  // 紫
```

---

## 十、动效规范（暗黑版特有）

```css
/* pulse 呼吸点（状态指示）*/
@keyframes pulse-neon {
  0%, 100% { box-shadow: 0 0 4px rgba(0,212,255,0.6); }
  50%       { box-shadow: 0 0 12px rgba(0,212,255,1.0), 0 0 20px rgba(0,212,255,0.4); }
}
.pulse-dot {
  width: 8px; height: 8px; border-radius: 50%;
  background: var(--cyan);
  animation: pulse-neon 2s ease-in-out infinite;
}

/* 渐变文字（标题用）*/
.gradient-text {
  background: linear-gradient(135deg, #00D4FF, #A78BFA);
  -webkit-background-clip: text; background-clip: text;
  -webkit-text-fill-color: transparent;
}
```

---

## 十一、三旋钮参数（taste-skill）

```
VARIANCE  = 7/10  （高：渐变文字、霓虹色卡片、多色系）
MOTION    = 5/10  （中：pulse/glow，hover发光，Skeleton）
DENSITY   = 6/10  （中高：信息密度较高但有视觉呼吸）
```

---

## 十二、Self-Check 补充项（主题 F 专属）

```
[ ] body 背景色 #060C1A（不是纯黑 #000）
[ ] body::before 有 45px×45px 网格线纹理
[ ] 卡片背景 #0D1830，边框 rgba(0,212,255,0.12)
[ ] KPI 数字使用渐变文字（background-clip: text）
[ ] KPI 卡片顶部有 2px 彩色装饰线（cyan/green/amber/purple）
[ ] delta 上涨用 #00F5B4（绿），下跌用 #FF4757（红）
[ ] ECharts 背景透明，分割线 rgba(0,212,255,0.05)
[ ] Tooltip 背景 #060C1A，边框 rgba(0,212,255,0.30)
[ ] 图表颜色使用 NEON_PALETTE 顺序
[ ] Section 编号方块有 glow 阴影
[ ] 进度条有颜色对应的发光效果
[ ] 无白色背景元素出现在页面中
[ ] 渐变文字不超过 3 处（克制使用）
```
