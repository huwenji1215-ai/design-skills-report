# data-components/echarts-config.md — ECharts 标准配置

> **来源**：移植自 DesignAI-reports_20260610_172619，与 web-site-beautifier 数据场景完全兼容。  
> **适用场景**：data-report / dashboard  
> **加载时机（Tier 3）**：生成或美化 ECharts 图表时按需加载。

---

## 一、全局 ECharts 默认配置（必须应用）

```javascript
// 所有 ECharts 实例必须应用此配置作为基础
const ECHARTS_DEFAULTS = {
  backgroundColor: 'transparent',  // 背景透明，由卡片 CSS 控制
  color: [
    '#3B7FF5', '#2BBD8E', '#F5A623', '#E8532A',
    '#6B48C8', '#00B8D4', '#7B8FAB', '#8BC34A', '#F0477A', '#9B27AF'
  ],
  textStyle: {
    fontFamily: '"Inter", -apple-system, "PingFang SC", sans-serif',
  },
  grid: {
    top: 40,       // 普通图表
    right: 16,
    bottom: 40,
    left: 16,
    containLabel: true
  },
  xAxis: {
    axisLine:  { lineStyle: { color: '#E5E7EB' } },
    axisLabel: { color: '#9CA3AF', fontSize: 11 },
    axisTick:  { show: false },
    splitLine: { show: false }
  },
  yAxis: {
    axisLine:  { show: false },
    axisTick:  { show: false },
    axisLabel: { color: '#9CA3AF', fontSize: 11 },
    splitLine: { lineStyle: { color: '#F3F4F6', type: 'dashed' } }
  },
  tooltip: {
    backgroundColor: '#FFFFFF',
    borderColor: '#E5E7EB',
    borderWidth: 1,
    textStyle: { color: '#374151', fontSize: 12 },
    extraCssText: 'box-shadow: 0 4px 12px rgba(0,0,0,0.10); border-radius: 6px;'
  },
  legend: {
    textStyle: { color: '#6B7280', fontSize: 11 },
    icon: 'circle',
    itemWidth: 8, itemHeight: 8,
    itemGap: 16,
    top: 'top'
  },
};
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

> 使用主题 B（dark-pro）时，覆盖以下 ECharts 配置：

```javascript
const ECHARTS_DARK_OVERRIDES = {
  backgroundColor: 'transparent',
  textStyle: { color: '#94A3B8' },
  title: { textStyle: { color: '#F1F5F9' } },
  legend: { textStyle: { color: '#94A3B8' } },
  xAxis: {
    axisLine:  { lineStyle: { color: '#334155' } },
    axisLabel: { color: '#64748B' },
    splitLine: { lineStyle: { color: '#1E293B' } }
  },
  yAxis: {
    axisLabel: { color: '#64748B' },
    splitLine: { lineStyle: { color: '#1E293B', type: 'dashed' } }
  },
  tooltip: {
    backgroundColor: '#1E293B',
    borderColor: '#334155',
    textStyle: { color: '#F1F5F9' }
  }
};
```
