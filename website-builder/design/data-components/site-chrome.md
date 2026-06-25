# data-components/site-chrome.md — 数据平台站点框架组件

> **定位**：数据日报 / 看板页面的「站点级」框架层（Site Chrome），区别于图表组件的「内容层」。  
> 来源：基于快手天策/KwaiBI 数据平台参考图的规范总结。  
> **包含**：顶部导航 / 左侧导航 / 全局 Topbar / Tab 导航 / 筛选栏 / 指标选择器 / 页面框架布局  
> **加载时机（Tier 3）**：生成完整数据平台站点页面时按需加载。

---

## 一、整体页面框架（三段式布局）

> 参考图所示：顶部固定 GlobalTopbar + 左侧固定 Sidebar + 右侧可滚动 MainContent

```
┌─────────────────────────────────────────────────────┐
│  GlobalTopbar（固定，整站共用）                        │
├──────────┬──────────────────────────────────────────┤
│          │  PageTopbar（页面标题 + 操作区）            │
│  Left    ├──────────────────────────────────────────┤
│  Sidebar │  SubTab（二级标签页，可选）                  │
│  (固定)  ├──────────────────────────────────────────┤
│          │  FilterBar（筛选栏，多行，可折叠）            │
│          ├──────────────────────────────────────────┤
│          │  MainContent（可滚动区域）                  │
│          │    Section 1                              │
│          │    Section 2                              │
│          │    ...                                    │
└──────────┴──────────────────────────────────────────┘
```

```css
/* 整体框架 */
.data-platform-layout {
  display: flex;
  flex-direction: column;
  height: 100vh;
  overflow: hidden;
  font-family: "Inter", -apple-system, "PingFang SC", sans-serif;
  font-size: 13px;
  color: #1D2129;
  background: #F2F3F5;
}

.data-platform-body {
  display: flex;
  flex: 1;
  overflow: hidden;
}

.data-platform-main {
  flex: 1;
  display: flex;
  flex-direction: column;
  overflow: hidden;
  background: #F2F3F5;
}

.data-platform-content {
  flex: 1;
  overflow-y: auto;
  padding: 0 16px 24px;
}
```

---

## 二、Global Topbar（顶部导航栏）

> 整站共用，固定在最顶层，height: 48px

```html
<header class="global-topbar">
  <!-- 左：品牌 Logo -->
  <div class="topbar-brand">
    <img src="logo.svg" class="topbar-logo" alt="Logo">
    <span class="topbar-brand-name">天策 | 门户</span>
    <!-- 可选：一级导航（水平，3-8个）-->
    <nav class="topbar-nav">
      <a class="topbar-nav-item active" href="#">首页</a>
      <a class="topbar-nav-item" href="#">业务概览</a>
      <a class="topbar-nav-item" href="#">营收</a>
      <a class="topbar-nav-item" href="#">消费</a>
      <a class="topbar-nav-item dropdown" href="#">
        专题分析 <i data-lucide="chevron-down" class="icon icon-sm"></i>
      </a>
      <a class="topbar-nav-item" href="#">核心模型</a>
    </nav>
  </div>

  <!-- 右：工具区 -->
  <div class="topbar-tools">
    <button class="topbar-tool-btn" title="搜索">
      <i data-lucide="search" class="icon"></i>
    </button>
    <button class="topbar-tool-btn" title="帮助">
      <i data-lucide="help-circle" class="icon"></i>
    </button>
    <div class="topbar-region">中国区 ▾</div>
    <div class="topbar-avatar">
      <img src="avatar.jpg" alt="用户头像" class="avatar-img">
    </div>
  </div>
</header>
```

```css
.global-topbar {
  height: 48px; flex-shrink: 0;
  display: flex; align-items: center; justify-content: space-between;
  padding: 0 16px;
  background: #FFFFFF;
  border-bottom: 1px solid #E5E8EF;
  position: sticky; top: 0; z-index: 100;
  box-shadow: 0 1px 4px rgba(0,0,0,0.06);
}

.topbar-brand { display: flex; align-items: center; gap: 8px; }
.topbar-logo  { height: 24px; }
.topbar-brand-name { font-size: 14px; font-weight: 600; color: #1D2129;
                     padding-right: 16px; border-right: 1px solid #E5E8EF; }

/* 一级导航 */
.topbar-nav        { display: flex; align-items: center; padding-left: 8px; }
.topbar-nav-item   { padding: 0 12px; height: 48px; display: flex; align-items: center;
                     font-size: 13px; color: #4E5969; text-decoration: none;
                     position: relative; white-space: nowrap;
                     transition: color 80ms; }
.topbar-nav-item:hover { color: #165DFF; }
.topbar-nav-item.active { color: #165DFF; font-weight: 500; }
.topbar-nav-item.active::after {
  content: ''; position: absolute; bottom: 0; left: 12px; right: 12px;
  height: 2px; background: #165DFF; border-radius: 1px;
}

/* 工具区 */
.topbar-tools     { display: flex; align-items: center; gap: 4px; }
.topbar-tool-btn  { width: 32px; height: 32px; display: flex; align-items: center;
                    justify-content: center; border: none; background: transparent;
                    border-radius: 6px; cursor: pointer; color: #86909C;
                    transition: background 80ms, color 80ms; }
.topbar-tool-btn:hover { background: #F2F3F5; color: #1D2129; }
.topbar-region    { font-size: 12px; color: #86909C; padding: 0 8px; cursor: pointer; }
.avatar-img       { width: 28px; height: 28px; border-radius: 50%; object-fit: cover;
                    cursor: pointer; }
```

---

## 三、Left Sidebar（左侧导航）

> 参考第一张参考图：可折叠，支持分组，支持二级菜单

```html
<aside class="left-sidebar">
  <!-- 导航分组 -->
  <div class="sidebar-group">
    <div class="sidebar-group-header expandable active">
      <i data-lucide="compass" class="icon icon-sm"></i>
      <span>经营司南</span>
      <i data-lucide="chevron-down" class="icon icon-sm ml-auto"></i>
    </div>
    <div class="sidebar-group-items">
      <a class="sidebar-item" href="#">绩效概览</a>
      <a class="sidebar-item active" href="#">波动诊断</a>
      <a class="sidebar-item" href="#">OKR经营分析</a>
      <a class="sidebar-item" href="#">实时数据概览</a>
    </div>
  </div>

  <div class="sidebar-group">
    <div class="sidebar-group-header expandable">
      <i data-lucide="globe" class="icon icon-sm"></i>
      <span>行业360</span>
      <i data-lucide="chevron-right" class="icon icon-sm ml-auto"></i>
    </div>
    <!-- 折叠时不显示 -->
  </div>
</aside>
```

```css
.left-sidebar {
  width: 176px; flex-shrink: 0;
  background: #FFFFFF;
  border-right: 1px solid #E5E8EF;
  overflow-y: auto;
  overflow-x: hidden;
  padding: 8px 0;
  transition: width 250ms cubic-bezier(0.4, 0, 0.2, 1);
}
.left-sidebar.collapsed { width: 48px; }

/* 分组标题 */
.sidebar-group-header {
  display: flex; align-items: center; gap: 8px;
  padding: 8px 12px; cursor: pointer;
  font-size: 13px; font-weight: 500; color: #1D2129;
  border-radius: 4px; margin: 0 4px;
  transition: background 80ms;
}
.sidebar-group-header:hover { background: #F2F3F5; }
.sidebar-group-header .icon { color: #86909C; }
.ml-auto { margin-left: auto; }

/* 折叠/展开状态 */
.sidebar-group-items { overflow: hidden;
  transition: max-height 250ms cubic-bezier(0.4, 0, 0.2, 1); }

/* 二级菜单项 */
.sidebar-item {
  display: block;
  padding: 6px 12px 6px 32px;  /* 左缩进 32px = 12 + icon(8) + gap(12) */
  font-size: 13px; color: #4E5969;
  text-decoration: none; border-radius: 4px; margin: 1px 4px;
  transition: background 80ms, color 80ms;
  white-space: nowrap; overflow: hidden; text-overflow: ellipsis;
}
.sidebar-item:hover  { background: #F2F3F5; color: #1D2129; }
.sidebar-item.active {
  background: #EBF0FF; color: #165DFF; font-weight: 500;
}

/* 折叠时只显示图标 */
.left-sidebar.collapsed .sidebar-group-header span,
.left-sidebar.collapsed .sidebar-group-items { display: none; }
.left-sidebar.collapsed .sidebar-group-header {
  justify-content: center; padding: 8px;
}
```

---

## 四、Page Topbar（页面级标题栏）

> 在主内容区顶部，显示页面标题 + 报表负责人 + 操作按钮

```html
<div class="page-topbar">
  <div class="page-topbar-left">
    <h1 class="page-title">电商核心业绩达成</h1>
    <!-- 可选：页面副标题 -->
  </div>
  <div class="page-topbar-right">
    <span class="report-owner">
      <i data-lucide="user" class="icon icon-sm"></i>
      报表负责人：
      <span class="avatar-inline">
        <img src="avatar.jpg" alt="">
        徐天亮(xutianlaing)
      </span>
    </span>
    <button class="page-action-btn" title="刷新">
      <i data-lucide="refresh-cw" class="icon icon-sm"></i>
    </button>
    <button class="page-action-btn" title="分享">
      <i data-lucide="share-2" class="icon icon-sm"></i>
    </button>
    <button class="page-action-btn" title="导出">
      <i data-lucide="download" class="icon icon-sm"></i>
    </button>
    <button class="page-action-btn" title="更多">
      <i data-lucide="more-horizontal" class="icon icon-sm"></i>
    </button>
  </div>
</div>
```

```css
.page-topbar {
  display: flex; align-items: center; justify-content: space-between;
  padding: 16px 0 12px;
  border-bottom: 1px solid #E5E8EF;
  margin-bottom: 0;
  background: #F2F3F5;   /* 与 content 背景一致，不突出 */
}
.page-title { font-size: 20px; font-weight: 700; color: #1D2129; }
.page-topbar-right { display: flex; align-items: center; gap: 8px; }
.report-owner { font-size: 12px; color: #86909C;
                display: flex; align-items: center; gap: 4px; }
.avatar-inline { display: flex; align-items: center; gap: 4px; color: #4E5969; }
.avatar-inline img { width: 18px; height: 18px; border-radius: 50%; }
.page-action-btn { width: 28px; height: 28px; border: none; background: transparent;
                   border-radius: 4px; cursor: pointer; color: #86909C;
                   display: flex; align-items: center; justify-content: center;
                   transition: background 80ms, color 80ms; }
.page-action-btn:hover { background: #E5E8EF; color: #1D2129; }
```

---

## 五、Primary Tab（主标签页）

> 在 Page Topbar 下方，切换视角（如"流量分析视角/经营分析视角/收入视角"）

```html
<div class="primary-tabs">
  <div class="primary-tab" data-tab="traffic">流量分析视角（含本地生活）</div>
  <div class="primary-tab active" data-tab="operation">
    经营分析视角之GMV&健康度
  </div>
  <div class="primary-tab" data-tab="revenue">经营分析视角之收入</div>
</div>
```

```css
.primary-tabs {
  display: flex; align-items: flex-end; gap: 0;
  border-bottom: 1px solid #E5E8EF;
  background: #FFFFFF;
  padding: 0 16px;
  margin: 0 -16px;  /* 突破 content padding 做全宽 */
  position: sticky; top: 48px; z-index: 90;
}
.primary-tab {
  padding: 10px 16px; font-size: 13px; color: #4E5969;
  cursor: pointer; white-space: nowrap;
  border-bottom: 2px solid transparent;
  transition: color 150ms, border-color 150ms;
}
.primary-tab:hover { color: #165DFF; }
.primary-tab.active {
  color: #165DFF; font-weight: 500;
  border-bottom-color: #165DFF;
}
```

---

## 六、Secondary Tab（二级标签 + Pill 切换）

> 在 Primary Tab 下，切换指标维度（如"支付GMV-商品 / 结算GMV / 支付GMV"）

```html
<!-- Pill 风格（较常见）-->
<div class="secondary-tabs pill">
  <div class="secondary-tab active">支付GMV-商品</div>
  <div class="secondary-tab">结算GMV</div>
  <div class="secondary-tab">支付GMV</div>
  <div class="secondary-tab">退款率</div>
  <div class="secondary-tab">商品视角</div>
</div>

<!-- Underline 风格（阅读型更多内容）-->
<div class="secondary-tabs underline">
  <div class="secondary-tab active">2022年月度</div>
  <div class="secondary-tab">2021年月度</div>
  <div class="secondary-tab">年度</div>
  <div class="secondary-tab">季度</div>
  <div class="secondary-tab">周</div>
  <div class="secondary-tab">天</div>
</div>
```

```css
/* Pill 风格 */
.secondary-tabs.pill {
  display: flex; gap: 4px; padding: 8px 0;
  flex-wrap: wrap;
}
.secondary-tabs.pill .secondary-tab {
  padding: 4px 12px; font-size: 12px; cursor: pointer;
  border-radius: 9999px; color: #4E5969;
  background: #F2F3F5; border: 1px solid transparent;
  transition: all 150ms;
}
.secondary-tabs.pill .secondary-tab:hover { background: #E5E8EF; }
.secondary-tabs.pill .secondary-tab.active {
  background: #EBF0FF; color: #165DFF;
  border-color: rgba(22,93,255,0.2); font-weight: 500;
}

/* Underline 风格 */
.secondary-tabs.underline {
  display: flex; gap: 0; border-bottom: 1px solid #E5E8EF;
}
.secondary-tabs.underline .secondary-tab {
  padding: 6px 12px; font-size: 12px; cursor: pointer;
  color: #4E5969; border-bottom: 2px solid transparent;
  transition: color 150ms, border-color 150ms;
}
.secondary-tabs.underline .secondary-tab:hover { color: #165DFF; }
.secondary-tabs.underline .secondary-tab.active {
  color: #165DFF; font-weight: 500; border-bottom-color: #165DFF;
}
```

---

## 七、FilterBar（筛选栏）

> 支持多行，可折叠收起，参考图第一张的多行筛选区

```html
<div class="filter-bar" id="filter-bar">
  <!-- 第一行 -->
  <div class="filter-row">
    <div class="filter-item">
      <label class="filter-label">日期选择：</label>
      <div class="filter-input-group">
        <select class="filter-select mini">
          <option>按月</option><option>按天</option>
        </select>
        <div class="filter-date-range">
          <i data-lucide="calendar" class="icon icon-sm"></i>
          <span>2021-9</span>
        </div>
      </div>
    </div>
    <div class="filter-item">
      <label class="filter-label">自定义基期：</label>
      <div class="filter-date-range">
        <i data-lucide="calendar" class="icon icon-sm"></i>
        <span class="placeholder">请选择</span>
      </div>
    </div>
    <div class="filter-item">
      <label class="filter-label">展示形式：</label>
      <div class="filter-radio-group">
        <button class="filter-radio active">累计</button>
        <button class="filter-radio">均值</button>
      </div>
    </div>
    <div class="filter-item">
      <label class="filter-label">同环比：</label>
      <div class="filter-radio-group">
        <button class="filter-radio active">环比</button>
        <button class="filter-radio">同比</button>
      </div>
    </div>
    <!-- 折叠按钮 -->
    <button class="filter-collapse-btn" onclick="toggleFilter()">
      收起 <i data-lucide="chevron-up" class="icon icon-sm"></i>
    </button>
  </div>

  <!-- 第二行（可折叠）-->
  <div class="filter-row collapsible">
    <div class="filter-item">
      <label class="filter-label">一级团队：</label>
      <select class="filter-select"><option>全部</option></select>
    </div>
    <div class="filter-item">
      <label class="filter-label">买家分层：</label>
      <select class="filter-select"><option>全部</option></select>
    </div>
    <div class="filter-item">
      <label class="filter-label">是否平选：</label>
      <select class="filter-select"><option>全部</option></select>
    </div>
    <div class="filter-item">
      <label class="filter-label">是否服务商绑定：</label>
      <select class="filter-select"><option>全部</option></select>
    </div>
    <div class="filter-item">
      <label class="filter-label">是否KA：</label>
      <select class="filter-select"><option>全部</option></select>
    </div>
  </div>
</div>
```

```css
.filter-bar {
  background: #FFFFFF;
  border: 1px solid #E5E8EF;
  border-radius: 6px;
  padding: 10px 16px;
  margin: 10px 0;
}
.filter-row {
  display: flex; flex-wrap: wrap; align-items: center;
  gap: 16px; min-height: 32px;
}
.filter-row + .filter-row { margin-top: 8px; padding-top: 8px;
  border-top: 1px dashed #E5E8EF; }
.filter-row.collapsed { display: none; }

.filter-item        { display: flex; align-items: center; gap: 4px; }
.filter-label       { font-size: 12px; color: #86909C; white-space: nowrap; }

/* Select 下拉 */
.filter-select {
  height: 28px; padding: 0 24px 0 8px;
  border: 1px solid #E5E8EF; border-radius: 4px;
  font-size: 12px; color: #1D2129; background: #FFFFFF;
  appearance: none;
  background-image: url("data:image/svg+xml,%3Csvg width='10' height='6' viewBox='0 0 10 6' fill='none' xmlns='http://www.w3.org/2000/svg'%3E%3Cpath d='M1 1L5 5L9 1' stroke='%2386909C' stroke-width='1.5' stroke-linecap='round'/%3E%3C/svg%3E");
  background-repeat: no-repeat; background-position: right 8px center;
  cursor: pointer; min-width: 60px;
}
.filter-select.mini { min-width: 48px; }
.filter-select:focus { outline: none; border-color: #165DFF; }

/* 日期范围 */
.filter-date-range {
  display: flex; align-items: center; gap: 4px;
  height: 28px; padding: 0 10px;
  border: 1px solid #E5E8EF; border-radius: 4px;
  font-size: 12px; color: #1D2129; cursor: pointer;
  background: #FFFFFF; min-width: 100px;
}
.filter-date-range .icon { color: #86909C; }
.filter-date-range .placeholder { color: #C9CDD4; }

/* Radio 按钮组 */
.filter-radio-group { display: flex; border: 1px solid #E5E8EF;
                       border-radius: 4px; overflow: hidden; }
.filter-radio { height: 28px; padding: 0 10px; font-size: 12px;
                border: none; background: #FFFFFF; cursor: pointer;
                color: #4E5969; transition: all 80ms; }
.filter-radio + .filter-radio { border-left: 1px solid #E5E8EF; }
.filter-radio.active { background: #165DFF; color: #FFFFFF; }

/* 折叠按钮 */
.filter-collapse-btn {
  margin-left: auto; display: flex; align-items: center; gap: 4px;
  font-size: 12px; color: #86909C; border: none; background: transparent;
  cursor: pointer; padding: 4px 0;
}
.filter-collapse-btn:hover { color: #165DFF; }
```

---

## 八、Section 区块标题

> 每个内容区块的标题样式，参考图中的带蓝线的大标题

```html
<!-- 带序号（参考图第一张）-->
<div class="section-title-numbered">
  <span class="section-number">1</span>
  <span>结论综述</span>
</div>

<!-- 带双语副标题（参考图第二三张）-->
<div class="section-title-bilingual">
  <span class="section-cn">GMV变化趋势</span>
  <span class="section-en">CHANGE TREND</span>
</div>

<!-- 带左边框（简洁版）-->
<div class="section-title-bar">指标维度拆解数据明细</div>
```

```css
/* 带序号 */
.section-title-numbered {
  display: flex; align-items: center; gap: 8px;
  font-size: 14px; font-weight: 600; color: #1D2129; margin-bottom: 16px;
}
.section-number {
  width: 20px; height: 20px; border-radius: 50%;
  background: #165DFF; color: #FFFFFF;
  font-size: 12px; font-weight: 700;
  display: flex; align-items: center; justify-content: center; flex-shrink: 0;
}

/* 带双语 */
.section-title-bilingual {
  display: flex; align-items: baseline; gap: 10px; margin-bottom: 12px;
}
.section-cn   { font-size: 16px; font-weight: 700; color: #1D2129; }
.section-en   { font-size: 11px; font-weight: 600; color: #C9CDD4;
                text-transform: uppercase; letter-spacing: 0.06em; }

/* 带左边框 */
.section-title-bar {
  font-size: 14px; font-weight: 600; color: #1D2129;
  padding-left: 10px;
  border-left: 3px solid #165DFF;
  margin-bottom: 12px;
  line-height: 18px;
}
```

---

## 九、卡片 ··· 更多菜单（Card Actions）

> 右上角 hover 出现的操作按钮，参考图每个图表卡片右上方

```html
<div class="chart-card" style="position:relative">
  <div class="card-header-row">
    <div class="card-title">
      近一周双端用户访问量
      <button class="metric-info-trigger" title="指标说明">
        <i data-lucide="info" class="icon icon-sm"></i>
      </button>
    </div>
    <div class="card-actions">
      <!-- 数据汇总下拉 -->
      <select class="card-mini-select">
        <option>图内汇总：最新值</option>
        <option>最大值</option>
        <option>平均值</option>
      </select>
      <button class="card-action-btn" title="更多操作">
        <i data-lucide="more-horizontal" class="icon icon-sm"></i>
      </button>
    </div>
  </div>
  <!-- 图表内容 -->
</div>
```

```css
.chart-card { background: #FFFFFF; border-radius: 6px;
              border: 1px solid #E5E8EF; padding: 16px; position: relative; }
.card-header-row {
  display: flex; justify-content: space-between; align-items: center;
  margin-bottom: 12px;
}
.card-title { font-size: 13px; font-weight: 600; color: #1D2129;
              display: flex; align-items: center; gap: 4px; }
.metric-info-trigger { border: none; background: transparent; padding: 0;
                        cursor: pointer; color: #C9CDD4;
                        display: flex; align-items: center;
                        transition: color 80ms; }
.metric-info-trigger:hover { color: #86909C; }
.card-actions { display: flex; align-items: center; gap: 4px; }
.card-mini-select {
  height: 24px; padding: 0 20px 0 6px; font-size: 11px;
  border: 1px solid #E5E8EF; border-radius: 4px;
  background: #FFFFFF; color: #4E5969; cursor: pointer;
  appearance: none;
  background-image: url("data:image/svg+xml,%3Csvg width='8' height='5' viewBox='0 0 8 5' fill='none' xmlns='http://www.w3.org/2000/svg'%3E%3Cpath d='M1 1L4 4L7 1' stroke='%2386909C' stroke-width='1.2'/%3E%3C/svg%3E");
  background-repeat: no-repeat; background-position: right 6px center;
}
.card-action-btn { width: 24px; height: 24px; border: none; background: transparent;
                   border-radius: 4px; cursor: pointer; color: #86909C;
                   display: flex; align-items: center; justify-content: center;
                   transition: background 80ms; }
.card-action-btn:hover { background: #F2F3F5; color: #1D2129; }
```

---

## 十、Tooltip（指标说明悬浮框）

```html
<div class="tooltip-container">
  <button class="metric-info-trigger">
    <i data-lucide="info" class="icon icon-sm"></i>
  </button>
  <div class="tooltip-popup" role="tooltip">
    指标说明：该指标为过去 7 天的累计值，包含 iOS 和 Android 双端数据。
    <a href="#" class="tooltip-link">查看更多观测指标 →</a>
  </div>
</div>
```

```css
.tooltip-container { position: relative; display: inline-flex; }
.tooltip-popup {
  position: absolute; bottom: calc(100% + 8px); left: 50%;
  transform: translateX(-50%);
  background: #1D2129; color: #FFFFFF;
  font-size: 12px; line-height: 1.6;
  padding: 8px 12px; border-radius: 6px;
  width: 240px; white-space: normal;
  box-shadow: 0 4px 12px rgba(0,0,0,0.15);
  opacity: 0; pointer-events: none;
  transition: opacity 150ms;
  z-index: 200;
}
.tooltip-popup::after {
  content: ''; position: absolute; top: 100%; left: 50%;
  transform: translateX(-50%);
  border: 5px solid transparent; border-top-color: #1D2129;
}
.tooltip-container:hover .tooltip-popup { opacity: 1; pointer-events: auto; }
.tooltip-link { color: #7EB2FF; text-decoration: none; display: block; margin-top: 4px; }
```

---

## 十一、渐进式加载 / Skeleton

```html
<!-- 图表 Skeleton -->
<div class="chart-card">
  <div class="skeleton" style="width: 40%; height: 16px; margin-bottom: 16px;"></div>
  <div class="skeleton" style="width: 100%; height: 240px;"></div>
</div>

<!-- KPI 卡片 Skeleton -->
<div class="kc">
  <div class="kc-left">
    <div class="skeleton" style="width: 60%; height: 12px; margin-bottom: 8px;"></div>
    <div class="skeleton" style="width: 50%; height: 32px; margin-bottom: 6px;"></div>
    <div class="skeleton" style="width: 40%; height: 12px;"></div>
  </div>
</div>
```

> Skeleton CSS 见 `core/motion-icons.md § skeleton-shimmer`
