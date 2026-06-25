# data-components/echarts-config.md — ECharts 标准配置

> **来源**：移植自 DesignAI-reports_20260610_172619，与 web-site-beautifier 数据场景完全兼容。  
> **适用场景**：data-report / dashboard  
> **加载时机（Tier 3）**：生成或美化 ECharts 图表时按需加载。

---

## 一、全局 ECharts 默认配置（必须应用）

> **⚠️ 两套颜色体系，用途严格分离：**
>
> | 色系 | 用途 | 配置位置 |
> |------|------|---------|
> | **页面 UI Token**（`--color-xxx`）| 按钮 / 状态 Badge / Delta 涨跌 / 选中行 / 边框 | CSS `:root` 变量 |
> | **图表多系列色**（`CHART_PALETTE`）| ECharts 各系列线/柱/扇形区分 | `color: [...]` 配置 |
>
> 两套体系的颜色**刻意设计为不同**，防止图表颜色与 UI 状态色产生语义混淆  
>（例：图表第2系列若用 `#18A058` 会与正向 delta 的绿色混淆，让用户以为这条线"是好的"）

```javascript
/**
 * 图表多系列配色序列（主题 A 数平蓝系）
 * 设计原则：
 *  - 色相均匀分布（每两色 Hue ≥ 30°），确保 8 条线同时显示时仍可区分
 *  - 第 0 色与品牌主色一致（#2563F4），建立品牌感
 *  - 不复用语义色（#18A058 绿 / #F04848 红），避免图例与涨跌颜色混淆
 */
const CHART_PALETTE = [
  '#2563F4',  // 0 数平蓝（主系列，与品牌主色一致）
  '#00B09B',  // 1 青绿（≠ 语义正 #18A058，色相不同）
  '#F5A623',  // 2 琥珀橙（≠ 语义预警 #F0800A，更亮）
  '#9B59B6',  // 3 中紫
  '#E84848',  // 4 朱红（图表标注用，≠ 语义负 #F04848，稍亮）
  '#00C9D7',  // 5 青蓝
  '#8BC34A',  // 6 草绿
  '#FF6B8A',  // 7 玫瑰粉
  '#9395A8',  // 8 中性灰（低优先级 / 对比基准系列）
];

// 所有 ECharts 实例必须应用此配置作为基础
const ECHARTS_DEFAULTS = {
  backgroundColor: 'transparent',  // 背景透明，由卡片 CSS 控制
  color: CHART_PALETTE,             // 使用图表专用配色序列（非 UI Token）
  textStyle: {
    fontFamily: '"Inter", -apple-system, "PingFang SC", sans-serif',
  },
  grid: {
    top: 40,
    right: 16,
    bottom: 40,
    left: 16,
    containLabel: true
  },
  xAxis: {
    axisLine:  { lineStyle: { color: '#DFE0E8' } },
    axisLabel: { color: '#9395A8', fontSize: 11 },
    axisTick:  { show: false },
    splitLine: { show: false }
  },
  yAxis: {
    axisLine:  { show: false },
    axisTick:  { show: false },
    axisLabel: { color: '#9395A8', fontSize: 11 },
    splitLine: { lineStyle: { color: '#F0F1F5', type: 'dashed' } }
  },
  tooltip: {
    backgroundColor: '#1A1A2E',
    borderWidth: 0,
    textStyle: { color: '#FFFFFF', fontSize: 12 },
    extraCssText: 'box-shadow: 0 4px 12px rgba(0,0,0,0.18); border-radius: 6px; padding: 8px 12px;'
  },
  legend: {
    textStyle: { color: '#696B80', fontSize: 11 },
    icon: 'circle',
    itemWidth: 8, itemHeight: 8,
    itemGap: 16,
    top: 'top'
  },
};
```

### 例外：语义强制场景（只有这 3 种情况允许直接指定颜色）

```javascript
// 1. 只有一个系列，且该系列有明确正/负语义时
//    例：折线图只显示"目标达成率"，用品牌蓝即可
series: [{ color: '#2563F4', ... }]

// 2. 瀑布图 / 偏差图 — 必须区分正负
const WATERFALL_COLORS = {
  positive: '#18A058',  // 此处用语义色，因为颜色=数值方向
  negative: '#F04848',
  total:    '#2563F4',
};

// 3. 达成率仪表盘 / 进度条 — 配色跟随达成状态
function getProgressColor(rate) {
  if (rate >= 1.0) return '#18A058';   // 超额 → 绿
  if (rate >= 0.8) return '#2563F4';   // 达标 → 蓝
  if (rate >= 0.6) return '#F5A623';   // 接近 → 橙
  return '#F04848';                    // 预警 → 红
}
```

---

## 二、图表类型配置模板

### 折线图（Line Chart）

```javascript
function getLineOption({ title, xData, series, colors }) {
  return {
    ...ECHARTS_DEFAULTS,
    title: {
      text: title,
      textStyle: { fontSize: 13, fontWeight: 600, color: '#374151' },
      top: 0, left: 0
    },
    grid: { top: 48, right: 16, bottom: 40, left: 16, containLabel: true },
    xAxis: {
      ...ECHARTS_DEFAULTS.xAxis,
      type: 'category',
      data: xData,
      boundaryGap: false
    },
    yAxis: { ...ECHARTS_DEFAULTS.yAxis, type: 'value' },
    series: series.map((s, i) => ({
      name: s.name,
      type: 'line',
      data: s.data,
      smooth: true,
      lineStyle: { width: 2, color: colors ? colors[i] : undefined },
      itemStyle: { color: colors ? colors[i] : undefined },
      // 面积填充（可选，alpha ≤ 0.12）
      areaStyle: s.showArea ? {
        color: {
          type: 'linear', x: 0, y: 0, x2: 0, y2: 1,
          colorStops: [
            { offset: 0, color: `${colors ? colors[i] : '#3B7FF5'}1F` },  // opacity ~0.12
            { offset: 1, color: `${colors ? colors[i] : '#3B7FF5'}00` }
          ]
        }
      } : undefined
    }))
  };
}
```

### 柱状图（Bar Chart）

```javascript
function getBarOption({ title, xData, series, horizontal = false }) {
  return {
    ...ECHARTS_DEFAULTS,
    title: {
      text: title,
      textStyle: { fontSize: 13, fontWeight: 600, color: '#374151' },
      top: 0, left: 0
    },
    grid: { top: 48, right: 16, bottom: 40, left: horizontal ? 80 : 16, containLabel: true },
    xAxis: horizontal ? { ...ECHARTS_DEFAULTS.yAxis, type: 'value' }
                      : { ...ECHARTS_DEFAULTS.xAxis, type: 'category', data: xData },
    yAxis: horizontal ? { ...ECHARTS_DEFAULTS.xAxis, type: 'category', data: xData }
                      : { ...ECHARTS_DEFAULTS.yAxis, type: 'value' },
    series: series.map(s => ({
      name: s.name,
      type: 'bar',
      data: s.data,
      barMaxWidth: 40,
      barMinHeight: 2,
      itemStyle: { borderRadius: [3, 3, 0, 0] },  // 顶部圆角
      label: { show: false }  // 默认不显示柱顶 label（太乱）
    }))
  };
}
```

### 环形图（Donut Chart）

```javascript
function getDonutOption({ title, data, innerText }) {
  return {
    ...ECHARTS_DEFAULTS,
    title: {
      text: title,
      textStyle: { fontSize: 13, fontWeight: 600, color: '#374151' },
      top: 0, left: 'center'
    },
    legend: { ...ECHARTS_DEFAULTS.legend, orient: 'vertical', left: 0, top: 'middle' },
    series: [{
      type: 'pie',
      radius: ['45%', '70%'],  // 环形
      center: ['60%', '55%'],
      data: data,  // [{ name: 'A', value: 40 }, ...]
      label: { show: false },
      labelLine: { show: false },
      emphasis: { label: { show: false } },
      // 中间文字（innerText 可选）
    }],
    // 中间文字用 graphic 实现
    graphic: innerText ? [{
      type: 'text', left: '57%', top: '48%',
      style: {
        text: innerText.value, textAlign: 'center',
        fill: '#111827', fontSize: 22, fontWeight: 700,
        fontFamily: '"Inter", sans-serif'
      }
    }, {
      type: 'text', left: '57%', top: '57%',
      style: {
        text: innerText.label, textAlign: 'center',
        fill: '#9CA3AF', fontSize: 11,
        fontFamily: '"Inter", sans-serif'
      }
    }] : []
  };
}
```

---

## 三、特殊元素规范

### markPoint（最高/最低点标注）

```javascript
// 含 markPoint 时：grid.top 必须 ≥ 48px
// 含 2 行标题时：grid.top 必须 ≥ 56px
markPoint: {
  symbol: 'circle',
  symbolSize: 6,
  data: [
    { type: 'max', name: '最高' },
    { type: 'min', name: '最低' }
  ],
  label: {
    fontSize: 10,       // ← 不超过 10px
    offset: [0, -12]
  }
}
```

### tooltip 格式化函数

```javascript
// 带单位的 tooltip formatter
const tooltipFormatter = (params, unit = '') => {
  if (!Array.isArray(params)) params = [params];
  let result = `<div style="font-size:12px;color:#374151">${params[0].axisValue || params[0].name}</div>`;
  params.forEach(p => {
    result += `<div style="display:flex;align-items:center;gap:8px;margin-top:4px">
      <span style="display:block;width:8px;height:8px;border-radius:50%;background:${p.color}"></span>
      <span style="color:#6B7280">${p.seriesName}:</span>
      <span style="font-weight:600;color:#111827;font-variant-numeric:tabular-nums">${p.value}${unit}</span>
    </div>`;
  });
  return result;
};
```

---

## 四、字号强制规则

```
axisLabel：   fontSize: 11, color: '#9CA3AF'
legend：      fontSize: 11, color: '#6B7280'
tooltip：     fontSize: 12
图表标题：    fontSize: 13, fontWeight: 600
bar label：   fontSize: 10-11（悬浮显示时 12px）
markPoint：   fontSize: 10（最小）

[P0] 图表内最小字号 ≥ 10px
[P0] 图表内标签字号 ≤ 14px（否则遮盖数据）
```

---

## 五、ECharts 容器布局（P0 强制）

```html
<!-- ✅ 正确：ECharts 容器用 flex:1 撑满父卡片 -->
<div class="chart-card">
  <div class="chart-title">结论句标题</div>
  <div id="chart-main" class="chart-container"></div>
</div>

<style>
.chart-card {
  display: flex; flex-direction: column;
  background: #FFFFFF;
  border: 1px solid #E5E7EB;
  border-radius: 6px; padding: 20px 24px;
}
.chart-title { font-size: 13px; font-weight: 600; color: #374151; margin-bottom: 16px; }
.chart-container {
  flex: 1;
  min-height: 0;       /* ← 必须，flex 子元素否则撑不开 */
  min-height: 260px;   /* ← 最低兜底 */
}
</style>
```

```
❌ 禁止：.chart-container { height: 300px; }（固定高度）
✅ 正确：.chart-container { flex: 1; min-height: 0; min-height: 260px; }
```

---

## 六、深色主题 ECharts 覆盖

> 使用主题 B（dark-pro）或 F（dark-neon）时，覆盖以下配置：

```javascript
// 深色主题图表配色（与亮色主题刻意区分，更亮更鲜艳）
const CHART_PALETTE_DARK = [
  '#4F8EF7',  // 0 亮数平蓝
  '#2ECDA4',  // 1 亮青绿
  '#F5B832',  // 2 亮琥珀
  '#B97BFF',  // 3 亮紫
  '#FF6B6B',  // 4 亮朱红
  '#22D4E5',  // 5 亮青蓝
  '#A8D95A',  // 6 亮草绿
  '#FF8FB0',  // 7 亮玫瑰
  '#778CA8',  // 8 深灰蓝
];

const ECHARTS_DARK_OVERRIDES = {
  backgroundColor: 'transparent',
  color: CHART_PALETTE_DARK,  // 深色专用配色序列
  textStyle: { color: '#8BA3C7' },
  title: { textStyle: { color: '#E2EAF8' } },
  legend: { textStyle: { color: '#8BA3C7' } },
  xAxis: {
    axisLine:  { lineStyle: { color: '#1E3A5F' } },
    axisLabel: { color: '#4A6080' },
    splitLine: { lineStyle: { color: '#0D2040' } }
  },
  yAxis: {
    axisLabel: { color: '#4A6080' },
    splitLine: { lineStyle: { color: '#0D2040', type: 'dashed' } }
  },
  tooltip: {
    backgroundColor: '#0D1830',
    borderColor: '#1E3A5F',
    borderWidth: 1,
    textStyle: { color: '#E2EAF8' }
  }
};
```
