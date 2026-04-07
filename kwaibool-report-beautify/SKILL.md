---
name: kwaibool-report-beautify
description: kwaibool数据报告美化技能。当用户需要「美化数据报告」「提升报告视觉品质」「报告设计优化」「让报告更好看」「数据报告排版」「报告配色」「图表美化」「报告标题设计」「kwaibool报告」「报告美学」「提升报告输出质量」时触发。输出包含标题、数据图表、数字指标卡片、文字分析段落的专业级HTML数据报告，内置专属设计系统（色彩/字体/间距/图表配色），默认即美观，无需额外设计知识。
---

# kwaibool 数据报告美化技能

> 让每一份数据报告都具备设计师级别的视觉品质

---

## 核心定位

这个技能解决的核心问题：**AI输出的数据报告普遍缺乏美学品质** —— 标题层级模糊、数字指标枯燥、图表配色混乱、整体排版单调。

本技能提供一套完整的 **kwaibool 报告设计系统**，覆盖数据报告的每个视觉维度，让 AI 输出直接达到设计师级别的报告品质。

---

## kwaibool 报告设计系统

### 色彩系统

**主色调 —— Kwai Blue（快手蓝橙系）**

```css
/* 核心色板 */
--primary: #FF5C00;          /* 快手橙：核心强调，CTA，关键数据高亮 */
--primary-light: #FF8A40;    /* 浅橙：次级强调，趋势向好 */
--accent-blue: #1A6FFF;      /* 活力蓝：链接，辅助强调，图表色1 */
--accent-blue-light: #4D94FF;/* 浅蓝：图表色2，背景强调 */
--success: #00B96B;           /* 绿色：正向指标，增长 */
--warning: #FAAD14;           /* 黄色：预警，需关注指标 */
--danger: #F5222D;            /* 红色：负向指标，下降 */
--neutral-90: #1A1A1A;        /* 主文本 */
--neutral-60: #595959;        /* 次文本 */
--neutral-40: #8C8C8C;        /* 辅助文本，标签 */
--neutral-10: #F5F5F5;        /* 背景色 */
--neutral-6: #FAFAFA;         /* 卡片底色 */
--white: #FFFFFF;             /* 纯白 */
--border: #E8E8E8;            /* 边框线 */

/* 图表专用色序（8色，循环使用）*/
--chart-1: #1A6FFF;
--chart-2: #FF5C00;
--chart-3: #00B96B;
--chart-4: #FAAD14;
--chart-5: #722ED1;
--chart-6: #13C2C2;
--chart-7: #F5222D;
--chart-8: #2F54EB;
```

**配色使用原则：**
- 一张图表最多用 5 种颜色，优先用图表色序前几个
- 正/负指标：绿色代表增长/好，红色代表下降/差
- 单色渐变图（如热力图）：用主色的 10%→100% 渐变

---

### 字体系统

```css
/* 字体栈（中文优先）*/
font-family: -apple-system, "PingFang SC", "Helvetica Neue", Arial, sans-serif;

/* 字号规范 */
--text-hero: 32px;      /* 报告主标题 */
--text-h1: 24px;        /* 一级标题（章节） */
--text-h2: 18px;        /* 二级标题（模块） */
--text-h3: 14px;        /* 三级标题（小节） */
--text-body: 14px;      /* 正文段落 */
--text-small: 12px;     /* 标签、辅助说明 */
--text-metric: 36px;    /* 指标数字 */
--text-metric-lg: 48px; /* 核心指标数字 */

/* 字重 */
--weight-regular: 400;
--weight-medium: 500;
--weight-semibold: 600;
--weight-bold: 700;

/* 行高 */
--lh-title: 1.3;
--lh-body: 1.6;
--lh-tight: 1.2;
```

---

### 间距系统（4px基准）

```css
--space-1: 4px;
--space-2: 8px;
--space-3: 12px;
--space-4: 16px;
--space-5: 20px;
--space-6: 24px;
--space-8: 32px;
--space-10: 40px;
--space-12: 48px;
--space-16: 64px;
```

---

## 报告结构规范

### 1. 报告页面结构

```html
<div class="report-container">
  <!-- 报告封面/头部 -->
  <header class="report-header">...</header>
  
  <!-- 核心指标看板（KPI Cards）-->
  <section class="kpi-section">...</section>
  
  <!-- 图表模块区 -->
  <section class="charts-section">...</section>
  
  <!-- 文字分析区 -->
  <section class="analysis-section">...</section>
  
  <!-- 报告尾注 -->
  <footer class="report-footer">...</footer>
</div>
```

---

### 2. 报告头部设计规范

**标准头部模板：**

```html
<header class="report-header" style="
  background: linear-gradient(135deg, #1A1A1A 0%, #2D2D2D 100%);
  padding: 40px 48px;
  border-radius: 16px;
  margin-bottom: 32px;
  position: relative;
  overflow: hidden;
">
  <!-- 装饰光晕（背景点缀）-->
  <div style="
    position: absolute; right: -60px; top: -60px;
    width: 240px; height: 240px;
    background: radial-gradient(circle, rgba(255,92,0,0.3) 0%, transparent 70%);
    border-radius: 50%;
  "></div>
  
  <!-- 报告标签 -->
  <div style="
    display: inline-flex; align-items: center; gap: 6px;
    background: rgba(255,92,0,0.15); border: 1px solid rgba(255,92,0,0.3);
    color: #FF5C00; padding: 4px 12px; border-radius: 20px;
    font-size: 12px; font-weight: 500; margin-bottom: 16px;
  ">
    📊 数据报告
  </div>
  
  <!-- 主标题 -->
  <h1 style="
    font-size: 32px; font-weight: 700; color: #FFFFFF;
    line-height: 1.3; margin: 0 0 12px 0;
  ">[报告主标题]</h1>
  
  <!-- 副标题/时间范围 -->
  <p style="
    font-size: 14px; color: rgba(255,255,255,0.6);
    margin: 0 0 24px 0;
  ">[时间范围] | [数据来源]</p>
  
  <!-- 摘要标签组 -->
  <div style="display: flex; gap: 12px; flex-wrap: wrap;">
    <!-- 摘要数据标签 -->
    <div style="
      background: rgba(255,255,255,0.08); border-radius: 8px;
      padding: 8px 16px; color: white;
    ">
      <span style="font-size: 11px; color: rgba(255,255,255,0.5);">核心指标</span>
      <div style="font-size: 20px; font-weight: 700; color: #FF5C00;">数值</div>
    </div>
    <!-- 可复用，添加更多标签 -->
  </div>
</header>
```

**设计要点：**
- 深色背景（#1A1A1A ~ #2D2D2D）营造专业感
- 橙色点缀光晕提升视觉层次
- 标题要有报告属性标签（"数据报告"/"周报"/"专项分析"）
- 必须包含：报告名称、时间范围、数据更新时间

---

### 3. KPI 数字指标卡片规范

**标准 KPI 卡片（单指标）：**

```html
<div class="kpi-card" style="
  background: #FFFFFF;
  border: 1px solid #E8E8E8;
  border-radius: 12px;
  padding: 24px;
  position: relative;
  overflow: hidden;
  box-shadow: 0 2px 8px rgba(0,0,0,0.06);
">
  <!-- 顶部色条（可选，用于分类区分）-->
  <div style="
    position: absolute; top: 0; left: 0; right: 0;
    height: 3px;
    background: linear-gradient(90deg, #1A6FFF, #4D94FF);
  "></div>
  
  <!-- 指标名称 -->
  <div style="
    font-size: 13px; color: #8C8C8C; font-weight: 500;
    margin-bottom: 12px; display: flex; align-items: center; gap: 6px;
  ">
    <span style="width: 6px; height: 6px; border-radius: 50%; background: #1A6FFF; display: inline-block;"></span>
    [指标名称]
  </div>
  
  <!-- 主数字 -->
  <div style="
    font-size: 36px; font-weight: 700; color: #1A1A1A;
    line-height: 1; margin-bottom: 8px;
  ">[数值]<span style="font-size: 16px; font-weight: 500; color: #595959;">[单位]</span></div>
  
  <!-- 环比/同比 -->
  <div style="display: flex; align-items: center; gap: 8px; margin-top: 8px;">
    <!-- 正向趋势 -->
    <span style="
      background: rgba(0,185,107,0.1); color: #00B96B;
      padding: 2px 8px; border-radius: 4px;
      font-size: 12px; font-weight: 600;
    ">▲ +12.3%</span>
    <span style="font-size: 12px; color: #8C8C8C;">环比上周</span>
    
    <!-- 负向趋势（切换使用）-->
    <!-- <span style="background: rgba(245,34,45,0.1); color: #F5222D; ...">▼ -5.2%</span> -->
  </div>
  
  <!-- 小型迷你图（可选）-->
  <!-- <div style="margin-top: 16px; height: 40px;">迷你趋势图</div> -->
</div>
```

**KPI 卡片网格布局：**
```html
<div style="
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(220px, 1fr));
  gap: 16px;
  margin-bottom: 32px;
">
  <!-- 放入多个 kpi-card -->
</div>
```

**KPI卡片顶部色条配色方案：**
- 蓝色（流量类）：`#1A6FFF → #4D94FF`
- 橙色（营收类）：`#FF5C00 → #FF8A40`
- 绿色（增长类）：`#00B96B → #52C41A`
- 紫色（用户类）：`#722ED1 → #9254DE`

---

### 4. 图表容器规范

每个图表需要包裹在标准容器中：

```html
<div class="chart-card" style="
  background: #FFFFFF;
  border: 1px solid #E8E8E8;
  border-radius: 12px;
  padding: 24px;
  box-shadow: 0 2px 8px rgba(0,0,0,0.06);
  margin-bottom: 24px;
">
  <!-- 图表标题区 -->
  <div style="display: flex; justify-content: space-between; align-items: flex-start; margin-bottom: 20px;">
    <div>
      <h3 style="
        font-size: 16px; font-weight: 600; color: #1A1A1A;
        margin: 0 0 4px 0; line-height: 1.3;
      ">[图表标题]</h3>
      <p style="font-size: 12px; color: #8C8C8C; margin: 0;">[图表说明/数据范围]</p>
    </div>
    <!-- 右侧标签/筛选器（可选）-->
    <div style="
      background: #F5F5F5; border-radius: 6px;
      padding: 4px 10px; font-size: 12px; color: #595959;
    ">周/月/季</div>
  </div>
  
  <!-- 图表本体（ECharts/D3等在此渲染）-->
  <div id="chart-[id]" style="height: 300px; width: 100%;"></div>
  
  <!-- 图表底注（可选）-->
  <div style="
    margin-top: 12px; padding-top: 12px;
    border-top: 1px solid #F0F0F0;
    font-size: 11px; color: #BFBFBF;
  ">数据来源：[来源] | 更新时间：[时间]</div>
</div>
```

---

### 5. ECharts 图表配色规范

在所有 ECharts 图表初始化时使用统一配置：

```javascript
// 全局主题配置（所有图表共用）
const kwaiboolTheme = {
  color: ['#1A6FFF', '#FF5C00', '#00B96B', '#FAAD14', '#722ED1', '#13C2C2', '#F5222D', '#2F54EB'],
  backgroundColor: 'transparent',
  textStyle: {
    fontFamily: '-apple-system, "PingFang SC", "Helvetica Neue", Arial, sans-serif',
    color: '#595959'
  },
  title: {
    textStyle: { fontSize: 14, fontWeight: 600, color: '#1A1A1A' },
    subtextStyle: { fontSize: 12, color: '#8C8C8C' }
  },
  tooltip: {
    backgroundColor: 'rgba(26,26,26,0.9)',
    borderColor: 'transparent',
    borderRadius: 8,
    textStyle: { color: '#FFFFFF', fontSize: 13 },
    padding: [10, 14]
  },
  legend: {
    textStyle: { fontSize: 12, color: '#595959' },
    itemWidth: 10, itemHeight: 10
  },
  grid: {
    left: '3%', right: '4%', bottom: '3%', top: '12%',
    containLabel: true
  },
  xAxis: {
    axisLine: { lineStyle: { color: '#E8E8E8' } },
    axisTick: { show: false },
    axisLabel: { color: '#8C8C8C', fontSize: 12 },
    splitLine: { show: false }
  },
  yAxis: {
    axisLine: { show: false },
    axisTick: { show: false },
    axisLabel: { color: '#8C8C8C', fontSize: 12 },
    splitLine: { lineStyle: { color: '#F0F0F0', type: 'dashed' } }
  }
};

// 使用方式
const chart = echarts.init(document.getElementById('chart-id'));
chart.setOption({
  ...kwaiboolTheme,
  // 具体图表配置...
  series: [{
    type: 'line',
    smooth: true,
    lineStyle: { width: 2.5 },
    areaStyle: {
      color: {
        type: 'linear', x: 0, y: 0, x2: 0, y2: 1,
        colorStops: [
          { offset: 0, color: 'rgba(26,111,255,0.15)' },
          { offset: 1, color: 'rgba(26,111,255,0)' }
        ]
      }
    }
  }]
});
```

**图表类型选择指南：**
| 场景 | 推荐图表 | 备注 |
|------|---------|------|
| 时间趋势 | 折线图 (line) | 加 areaStyle 渐变填充 |
| 类目对比 | 柱状图 (bar) | 圆角柱子，borderRadius: [4,4,0,0] |
| 占比构成 | 饼图/环形图 (pie) | 推荐 radius: ['45%', '70%'] 环形 |
| 多维对比 | 雷达图 (radar) | 用于能力/维度对比 |
| 分布散点 | 散点图 (scatter) | 指标相关性分析 |
| 漏斗转化 | 漏斗图 (funnel) | 用户转化路径 |
| 排名对比 | 横向柱状图 (bar, horizontal) | TOP N 排名展示 |

---

### 6. 文字分析区块规范

**洞察结论块：**

```html
<div style="
  background: linear-gradient(135deg, rgba(26,111,255,0.04) 0%, rgba(26,111,255,0.08) 100%);
  border-left: 4px solid #1A6FFF;
  border-radius: 0 12px 12px 0;
  padding: 20px 24px;
  margin-bottom: 20px;
">
  <!-- 标题行 -->
  <div style="display: flex; align-items: center; gap: 8px; margin-bottom: 12px;">
    <span style="font-size: 16px;">💡</span>
    <h3 style="font-size: 15px; font-weight: 600; color: #1A1A1A; margin: 0;">核心洞察</h3>
  </div>
  <!-- 内容 -->
  <p style="font-size: 14px; color: #595959; line-height: 1.7; margin: 0;">[洞察内容]</p>
</div>
```

**风险预警块：**

```html
<div style="
  background: rgba(250,173,20,0.06);
  border: 1px solid rgba(250,173,20,0.3);
  border-radius: 8px;
  padding: 16px 20px;
  display: flex; align-items: flex-start; gap: 12px;
  margin-bottom: 16px;
">
  <span style="font-size: 18px; flex-shrink: 0;">⚠️</span>
  <div>
    <div style="font-size: 13px; font-weight: 600; color: #D48806; margin-bottom: 4px;">注意</div>
    <div style="font-size: 13px; color: #595959; line-height: 1.6;">[风险或注意事项]</div>
  </div>
</div>
```

**数据表格规范：**

```html
<div style="overflow-x: auto; border-radius: 12px; border: 1px solid #E8E8E8;">
  <table style="width: 100%; border-collapse: collapse; font-size: 13px;">
    <thead>
      <tr style="background: #F5F5F5;">
        <th style="padding: 12px 16px; text-align: left; font-weight: 600; color: #595959; border-bottom: 1px solid #E8E8E8;">指标名</th>
        <th style="padding: 12px 16px; text-align: right; font-weight: 600; color: #595959; border-bottom: 1px solid #E8E8E8;">本期</th>
        <th style="padding: 12px 16px; text-align: right; font-weight: 600; color: #595959; border-bottom: 1px solid #E8E8E8;">上期</th>
        <th style="padding: 12px 16px; text-align: right; font-weight: 600; color: #595959; border-bottom: 1px solid #E8E8E8;">变化</th>
      </tr>
    </thead>
    <tbody>
      <tr style="border-bottom: 1px solid #F0F0F0;">
        <td style="padding: 12px 16px; color: #1A1A1A;">[指标]</td>
        <td style="padding: 12px 16px; text-align: right; color: #1A1A1A; font-weight: 500;">[数值]</td>
        <td style="padding: 12px 16px; text-align: right; color: #8C8C8C;">[数值]</td>
        <!-- 正向变化 -->
        <td style="padding: 12px 16px; text-align: right; color: #00B96B; font-weight: 600;">▲ +X%</td>
        <!-- 负向变化：color: #F5222D，▼ -X% -->
      </tr>
    </tbody>
  </table>
</div>
```

---

## Vizro 专业级视觉设计原则（麦肯锡标准）

> 以下原则来自 mckinsey/vizro 开源框架——"beautiful by default"的设计哲学，直接内化为本 Skill 的质量标准。

### 核心理念：视觉一致性三要素

Vizro 认为专业数据报告的视觉品质来自三个核心要素：

1. **视觉一致性（Visual Consistency）** —— 报告中所有元素遵循同一套规则，不是"一张图好看"而是"整体协调"
2. **美学专业性（Professional Aesthetics）** —— 颜色经过科学筛选，字体经过可读性验证，间距遵循数学比例
3. **可访问性（Accessibility）** —— 所有配色方案必须对色盲用户友好

---

### 色板分类设计：三类色板系统

Vizro 将数据可视化配色分为三类，kwaibool 报告应同样遵循此分类逻辑：

**① 定性色板（Qualitative） —— 分类数据**
用于区分不同类别，每种颜色含义上"平等"，无序无轻重。

```css
/* kwaibool 定性色板（10色，循环使用）*/
--q-1: #1A6FFF;   /* 主蓝 */
--q-2: #FF5C00;   /* 快手橙 */
--q-3: #00B96B;   /* 正向绿 */
--q-4: #FAAD14;   /* 警示黄 */
--q-5: #722ED1;   /* 分析紫 */
--q-6: #13C2C2;   /* 青绿 */
--q-7: #EB2F96;   /* 粉红 */
--q-8: #2F54EB;   /* 深蓝 */
--q-9: #52C41A;   /* 浅绿 */
--q-10: #FA8C16;  /* 橙黄 */
```

**② 连续色板（Sequential） —— 有序/连续数据**
用于热力图、面积密度图、单维度强度表达，颜色从浅到深代表数值从低到高。

```css
/* 蓝色连续（流量/规模类指标）*/
--seq-blue-0: rgba(26, 111, 255, 0.08);   /* 极低 */
--seq-blue-1: rgba(26, 111, 255, 0.20);
--seq-blue-2: rgba(26, 111, 255, 0.40);
--seq-blue-3: rgba(26, 111, 255, 0.65);
--seq-blue-4: rgba(26, 111, 255, 0.85);
--seq-blue-5: #1A6FFF;                    /* 极高 */

/* 橙色连续（活跃度/热度类指标）*/
--seq-orange-0: rgba(255, 92, 0, 0.08);
--seq-orange-5: #FF5C00;
```

**③ 发散色板（Diverging） —— 有正负意义的数据**
用于对比偏差，中心为中性灰/白，两端分别为正向色（绿）和负向色（红）。

```css
/* 正负发散色板（环比/同比偏差）*/
/* 负极端 → 中性 → 正极端 */
/* #F5222D → #FFF1F0 → #FFFFFF → #F6FFED → #00B96B */
```

**Vizro 核心原则：所有配色必须通过色盲安全测试（colorblind-safe）。**
kwaibool 报告实践：定性色板中避免仅靠红绿区分，必须同时配合形状/数字/标签。

---

### 双主题架构：Dark/Light 两套方案

Vizro 默认提供 `vizro_dark`（深色）和 `vizro_light`（浅色）两套主题，支持用户一键切换。这里将此设计思想转化为 kwaibool 报告的两套 CSS 变量方案：

**主题 A：Dark（深色专业版）** —— 默认，适合大屏展示/高管汇报
```css
.theme-dark {
  --bg-page: #111111;
  --bg-card: #1A1A1A;
  --bg-card-hover: #222222;
  --border-color: rgba(255,255,255,0.08);
  --text-primary: #FFFFFF;
  --text-secondary: rgba(255,255,255,0.65);
  --text-muted: rgba(255,255,255,0.35);
  --axis-line: rgba(255,255,255,0.12);
  --grid-line: rgba(255,255,255,0.06);
  --chart-bg: transparent;
}
```

**主题 B：Light（浅色清晰版）** —— 适合文档输出/打印/日常周报
```css
.theme-light {
  --bg-page: #F5F5F5;
  --bg-card: #FFFFFF;
  --bg-card-hover: #FAFAFA;
  --border-color: #E8E8E8;
  --text-primary: #1A1A1A;
  --text-secondary: #595959;
  --text-muted: #8C8C8C;
  --axis-line: #E8E8E8;
  --grid-line: #F0F0F0;
  --chart-bg: transparent;
}
```

**主题选择规则（来自 Vizro 最佳实践）：**
- 数字指标报告（KPI看板）→ 优先 Dark，数字更突出
- 详细数据分析报告 → 优先 Light，文字更易读
- 对外客户报告 → 强制 Light，避免打印变黑
- 大屏/投影演示 → 强制 Dark，对比度更高

---

### 图表坐标轴的 Vizro 标准

Vizro 对图表坐标轴有明确规范，将其转化为 ECharts 配置：

```javascript
// Vizro 启发的坐标轴规范
const vizroAxisStyle = {
  // 仅显示必要轴线，减少视觉噪音
  xAxis: {
    axisLine: { 
      show: true,
      lineStyle: { color: 'var(--axis-line)', width: 1 } 
    },
    axisTick: { show: false },  // Vizro: 不显示刻度线，减少干扰
    axisLabel: { 
      color: 'var(--text-muted)', 
      fontSize: 11,
      margin: 8
    },
    splitLine: { show: false }  // X轴不显示网格线
  },
  yAxis: {
    axisLine: { show: false },  // Y轴不显示轴线
    axisTick: { show: false },
    axisLabel: { 
      color: 'var(--text-muted)', 
      fontSize: 11 
    },
    splitLine: { 
      show: true,               // 只有Y轴水平网格线
      lineStyle: { 
        color: 'var(--grid-line)', 
        type: 'solid',           // Vizro: 实线，不用虚线
        width: 1 
      } 
    }
  }
};
```

**Vizro 坐标轴黄金原则：**
- 去除所有装饰性元素，保留必要功能
- 轴标签颜色要比数据颜色淡 30%+
- Y轴只保留水平辅助线，X轴不要垂直辅助线
- 数值标签统一格式（万/亿/K/M 统一缩写）

---

### 报告布局的 Vizro Grid 思想

Vizro 使用 Grid 系统管理布局，kwaibool 报告参考此原则：

```
报告页面布局结构（12列网格）：

全宽组件：      [  1  ][  2  ][  3  ][  4  ][  5  ][  6  ][  7  ][  8  ][  9  ][ 10  ][ 11  ][ 12  ]
KPI 4列布局：   [  1  2  3  ][  4  5  6  ][  7  8  9  ][ 10  11  12  ]
图表 2列布局：  [    1    2    3    4    5    6    ][    7    8    9    10   11   12   ]
图表 3列布局：  [    1  2  3  4  ][  5  6  7  8  ][ 9  10  11  12  ]
```

CSS Grid 实现：
```css
/* 主布局容器 */
.report-grid {
  display: grid;
  grid-template-columns: repeat(12, 1fr);
  gap: 16px;
}

/* 组件跨列 */
.col-12 { grid-column: span 12; }  /* 全宽 */
.col-6  { grid-column: span 6; }   /* 半宽 */
.col-4  { grid-column: span 4; }   /* 三分之一 */
.col-3  { grid-column: span 3; }   /* 四分之一 */
.col-8  { grid-column: span 8; }   /* 三分之二 */
```

---

### Vizro 启发的图表最佳实践

**① 始终包含图表标题（Vizro 强制要求）**
每个图表必须有清晰的标题，说明"这张图在看什么"，而非仅仅描述数据本身。

- ❌ 错误："日活用户数" 
- ✅ 正确："日活用户数持续回升，近7日增速加快"

**② 数据标注原则**
- 折线图：在终点标注最新值
- 柱图：在柱顶标注数值（数量少于 8 根时）
- 饼/环图：在图外标注百分比 + 绝对值

**③ 图例位置原则（Vizro 实践）**
- 图例放在图表正上方或右侧，不放底部（底部易被截断）
- 图例项超过 5 个时，考虑改用直接标注（Direct Label）代替

**④ Tooltip 设计规范**
```javascript
tooltip: {
  trigger: 'axis',           // 轴触发，不用 'item'（数据点触发噪音大）
  backgroundColor: 'rgba(26,26,26,0.92)',
  borderColor: 'transparent',
  borderRadius: 8,
  padding: [12, 16],
  textStyle: { color: '#FFF', fontSize: 13, lineHeight: 20 },
  formatter: function(params) {
    // 格式：日期/类目 + 各系列名:值（带单位）
    // 高亮当前 hover 的系列
  }
}
```

---

## 执行工作流

当用户需要美化/生成数据报告时，按以下步骤执行：

### Step 1：信息收集（如果内容不完整）
询问或从上下文中获取：
- 报告类型（周报/月报/专项分析/大盘报告）
- 核心指标数据（必须有真实数据，禁止虚构）
- 报告时间范围
- 是否有图表需求（如有，确认图表类型和数据）
- 特殊设计要求（如品牌色、特定风格）

### Step 2：选择报告模板方向
根据报告类型选择页面结构：
- **简洁版**：Header + 4个KPI卡片 + 2-3个图表 + 分析段落
- **完整版**：Header + KPI看板 + 多图表区 + 深度分析区 + 附录
- **总结版**：Header + 核心数字 + 一图一文 + 结论建议

### Step 3：生成HTML报告

**完整的HTML骨架结构：**

```html
<!DOCTYPE html>
<html lang="zh-CN">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>[报告标题]</title>
<script src="https://cdn.jsdelivr.net/npm/echarts@5/dist/echarts.min.js"></script>
<style>
  * { margin: 0; padding: 0; box-sizing: border-box; }
  body {
    font-family: -apple-system, "PingFang SC", "Helvetica Neue", Arial, sans-serif;
    background: #F5F5F5;
    color: #1A1A1A;
    line-height: 1.6;
  }
  .report-container {
    max-width: 1200px;
    margin: 0 auto;
    padding: 32px 24px;
  }
  /* 响应式 */
  @media (max-width: 768px) {
    .report-container { padding: 16px; }
    .kpi-grid { grid-template-columns: repeat(2, 1fr) !important; }
  }
</style>
</head>
<body>
  <div class="report-container">
    <!-- 按上方规范插入 header、kpi-section、charts-section、analysis-section -->
  </div>
</body>
</html>
```

### Step 4：质量自检

生成后，自检以下项目：
- [ ] 标题层级清晰（主标题 > 章节标题 > 模块标题）
- [ ] 数字指标均有趋势对比（环比/同比）
- [ ] 图表有标题和数据来源注释
- [ ] 颜色使用符合正/负向语义（绿色=好，红色=差）
- [ ] 无硬编码颜色，使用设计系统变量
- [ ] 深色背景文字可读性（对比度 > 4.5:1）
- [ ] ECharts 配置使用 kwaiboolTheme

---

## 常见报告类型模板索引

| 报告类型 | 特征 | 推荐结构 |
|---------|------|---------|
| 运营周报 | 时序数据，多指标环比 | KPI看板 + 折线趋势 + TOP榜 + 周结论 |
| 增长分析 | 漏斗转化，用户行为 | 漏斗图 + 转化率对比 + 用户分层表格 |
| 内容洞察 | 内容分类，传播效果 | 词云/雷达 + 对比柱图 + 爆款分析 |
| 投放报告 | ROI，A/B对比 | 双维散点 + 渠道对比柱图 + 花费表格 |
| 大盘总览 | 宏观全局，多维度 | 完整版结构，Header突出核心数字 |

---

## 技能触发场景示例

- "帮我把这份周报数据做成好看的HTML报告"
- "这些指标做成数据报告，要有图表和KPI卡片"
- "报告风格太丑了，帮我美化一下"
- "生成一份快手运营数据的日报，数据如下：..."
- "把这个分析结果做成可视化报告"
- "kwaibool的数据报告要输出，帮我设计一下排版"
