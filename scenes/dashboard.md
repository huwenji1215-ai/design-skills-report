# scenes/dashboard.md — 数据看板 / Dashboard / 监控大屏

> **场景定位**：实时或准实时数据监控**站点**，包含完整站点框架 + 数据内容层。  
> 叙事结构：当前状态 → 异常告警 → 趋势变化 → 下钻明细。  
> 典型受众：运营值班 / 产品负责人 / 业务监控 / 管理层大屏。  
> **与 data-report 的核心区别**：报告是「回溯+解读」，看板是「当前+告警+多视角切换」。  
> 🆕 **站点框架层**：完整站点交互组件见 `data-components/site-chrome.md`，本文件描述看板专属应用规则。

---

## 零、站点层 vs 内容层（Dashboard 专属分工）

```
站点层（Site Chrome）         内容层（Dashboard Content）
─────────────────────────     ─────────────────────────────────
GlobalTopbar（固定，整站）     Status Bar（当前状态）
Left Sidebar（业务模块导航）   Alert Zone（告警区，有异常时显示）
Primary Tab（大类视角切换）    Core KPI Strip（核心指标横条）
Secondary Tab（维度切换）      Main Chart Zone（主图表区）
FilterBar（时间+维度筛选）     Breakdown Section（分维度）
Page Topbar（标题+刷新按钮）   Detail Table（明细数据）
─────────────────────────     ─────────────────────────────────
```

**看板站点层 vs 日报站点层的区别**：

| 对比项 | 数据日报 | 数据看板 |
|-------|---------|---------|
| FilterBar 时间 | 历史区间（选范围）| 时间窗口（近 7 天 / 近 30 天 / 自定义）|
| Secondary Tab | 指标维度切换 | 分析视角切换（活动大盘/主站用户/双端）|
| 刷新方式 | 手动刷新 | 自动刷新 + 手动刷新（Topbar 刷新按钮带 loading 旋转）|
| 内容固定度 | 内容固定，少交互 | 内容可动态下钻（折叠行/展开维度）|

---

## 一、叙事节奏（Module Flow）

```
01. Status Bar / Header  ← 全局状态：系统是否正常 + 最近更新时间
02. Alert Zone           ← 告警区（可选，有异常时显示）：醒目的警告卡片
03. Core KPI Strip       ← 核心指标横条：4-8 个关键实时指标
04. Main Chart Zone      ← 主图表区：趋势 / 实时曲线（通常 2-3 个）
05. Breakdown Section    ← 分维度：分渠道 / 分地区 / 分设备 的明细
06. Detail Table         ← 明细列表：如 Top N 排名 / 异常日志
```

---

## 二、视觉规范（三层映射）

### 2.1 整体基调

- **[用户感受]**：感觉像监控大屏，信息密度很高，能快速找到重点。
- **[设计原理]**：看板的核心价值是「状态一眼可见」，布局密度高，颜色用于状态而非装饰，信息层级要极其清晰。
- **[技术实现]**：默认亮色 `bg-[#F9FAFB]`；深色主题 `bg-[#0F172A]`（主题 B）；卡片 `rounded-lg border`；整体 padding 比报告更紧凑（`py-4`）。

### 2.2 状态可视化

- **[用户感受]**：正常的东西是绿的，异常的东西是红的，一眼就知道有没有问题。
- **[设计原理]**：状态色（traffic light）是看板中最重要的语义系统，用于表示健康/告警/严重三个状态。
- **[技术实现]**：`status-ok: #22C55E`；`status-warn: #F59E0B`；`status-critical: #EF4444`；状态点 8px 圆（`w-2 h-2 rounded-full`）。

### 2.3 信息密度

- **[用户感受]**：东西很多但不乱，感觉卡片比日报更紧凑。
- **[设计原理]**：看板需要在一屏内显示尽量多的关键信息，卡片 padding 比报告紧凑（16px vs 24px）。
- **[技术实现]**：紧凑卡片 `padding: 16px`；KPI 条 `padding: 12px 16px`；区块间距 `gap: 16px`（报告用 24px）。

### 2.4 实时感设计

- **[用户感受]**：有一个小圆点在闪，感觉数据是活的。
- **[设计原理]**：微动效（pulse/blink）用于表示数据实时更新状态，强化「正在监控」的感知。
- **[技术实现]**：`@keyframes pulse { 0%,100%{opacity:1} 50%{opacity:0.4} }`；仅用于状态指示点（直径 8px），禁止大面积使用。

---

## 三、模块级规范

### 模块 01：Status Bar（状态栏）

```html
<div class="status-bar">
  <div class="status-bar-left">
    <div class="status-indicator">
      <span class="pulse-dot ok"></span>
      <span class="status-text">系统运行正常</span>
    </div>
    <span class="status-title">业务监控看板</span>
  </div>
  <div class="status-bar-right">
    <span class="update-time">最近更新：09:42:15</span>
    <span class="data-range">今日 00:00 ~ 实时</span>
  </div>
</div>
```

```css
.status-bar {
  display: flex; justify-content: space-between; align-items: center;
  padding: 12px 24px; background: #FFFFFF;
  border-bottom: 1px solid #E5E7EB;
  font-size: 13px;
}
.pulse-dot {
  display: inline-block; width: 8px; height: 8px;
  border-radius: 50%; animation: pulse 2s infinite;
}
.pulse-dot.ok       { background: #22C55E; }
.pulse-dot.warn     { background: #F59E0B; }
.pulse-dot.critical { background: #EF4444; }
```

### 模块 02：Alert Zone（告警区）

> 仅在有告警时显示，正常时隐藏（`display:none`）

```html
<div class="alert-zone critical" role="alert">
  <svg><!-- warn icon --></svg>
  <div>
    <div class="alert-title">支付成功率异常 — 当前 87.2%，低于阈值 95%</div>
    <div class="alert-meta">触发时间：09:38 · 持续 4 分钟</div>
  </div>
  <button class="alert-action">查看详情</button>
</div>
```

```css
.alert-zone {
  border-left: 4px solid;
  border-radius: 6px;
  padding: 12px 16px;
  display: flex; align-items: flex-start; gap: 12px;
  margin-bottom: 16px;
}
.alert-zone.critical { border-color: #EF4444; background: #FEF2F2; }
.alert-zone.warn     { border-color: #F59E0B; background: #FFFBEB; }
```

### 模块 03：Core KPI Strip（核心指标条）

```css
/* 水平滚动条或网格，比 data-report 更紧凑 */
.kpi-strip {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(160px, 1fr));
  gap: 12px;
  margin-bottom: 16px;
}
.kpi-strip-card {
  background: #FFFFFF;
  border: 1px solid #E5E7EB;
  border-radius: 6px;
  padding: 12px 16px;
}
.kpi-strip-label  { font-size: 12px; color: #6B7280; margin-bottom: 4px; }
.kpi-strip-value  { font-size: 24px; font-weight: 700; font-variant-numeric: tabular-nums; }
.kpi-strip-delta  { font-size: 12px; margin-top: 2px; }
```

### 模块 04：Main Chart Zone（主图表区）

> 图表配置见 `data-components/echarts-config.md`

```
布局规则：
  - 主图（折线/实时曲线）占宽 2/3，辅图（饼/环/漏斗）占 1/3
  - 或双等宽（1/2 + 1/2）
  - 三图时：1/2 + 1/4 + 1/4

实时折线图特殊配置：
  - dataZoom 允许（便于拖拽查看历史）
  - 时间轴格式：HH:mm 或 MM-DD HH:mm
  - 最新数据点可用 markPoint 高亮
  - grid.top ≥ 48px（含 markPoint），含 2 行标题 ≥ 56px

看板折线图 vs 报告折线图：
  - 看板：x 轴时间颗粒度细（分钟/小时）
  - 报告：x 轴时间颗粒度粗（天/周）
```

### 模块 05：Breakdown Section（分维度）

```
常见子图类型：
  横向条形图（按维度排名）
  热力图（时间 × 维度）
  树形图（占比层级）
  桑基图（流向分析）

布局：
  2-3 列，flex 等宽 + min-width 保证图表不压缩
  深色主题下：背景 #1E293B，标题 #E2E8F0
```

### 模块 06：Detail Table

> 详见 `data-components/table-spec.md`

```
看板表格 vs 报告表格：
  - 看板：compact density（行高 32px）
  - 报告：standard density（行高 44px）
  
状态列：
  用 Badge 显示状态（`status-badge ok/warn/critical`）
  bg-green-100 text-green-800 / bg-yellow-100 / bg-red-100
  font-size: 11px; padding: 2px 8px; border-radius: 9999px;

排名列：
  Top 3 用 #B8860B（金）/ #A0A0A0（银）/ #CD7F32（铜）数字标注
```

---

## 四、深色大屏模式补充（主题 B 时）

```css
/* 深色看板全局覆盖 */
body { background: #0F172A; color: #E2E8F0; }
.card { background: #1E293B; border-color: #334155; }
.kpi-strip-card { background: #1E293B; border-color: #334155; }
.kpi-strip-value { color: #F1F5F9; }
.status-bar { background: #1E293B; border-color: #334155; }

/* 图表颜色在深色下加强亮度 */
/* ECharts 颜色见 themes/B-dark-pro.md */
```

---

## 六、看板站点交互层规范

### 6.1 看板专属 FilterBar

```html
<div class="filter-bar">
  <div class="filter-row">
    <!-- 时间范围 -->
    <div class="filter-item">
      <i data-lucide="calendar" class="icon icon-sm" style="color:#86909C"></i>
      <div class="filter-date-range">
        <span>2023-10-28 ~ 2024-02-28</span>
      </div>
    </div>
    <!-- 产品 -->
    <div class="filter-item">
      <label class="filter-label">产品：</label>
      <select class="filter-select"><option>请选择</option></select>
    </div>
    <!-- 类别 -->
    <div class="filter-item">
      <label class="filter-label">类别：</label>
      <select class="filter-select"><option>全部</option></select>
    </div>
  </div>

  <!-- 数据集 Tab（Secondary Tab Pill，在 FilterBar 下方）-->
  <div class="filter-row" style="margin-top: 6px">
    <div class="secondary-tabs pill">
      <div class="secondary-tab">国内原数据操作</div>
      <div class="secondary-tab active">测试数据操作</div>
      <div class="secondary-tab">新加坡原数据操作</div>
      <div class="secondary-tab">原数据DEMO</div>
    </div>
  </div>
</div>
```

### 6.2 看板内 Section 级 Tab（指标维度切换）

> 参考第三张图"购物节大促业绩看板"中的 Section 内嵌 Tab

```html
<!-- Section 内嵌 Tab：小型 Pill，切换图表数据维度 -->
<div class="section-inner-tabs">
  <div class="inner-tab active">活动大盘</div>
  <div class="inner-tab">主站用户分析</div>
  <div class="inner-tab">双端活跃表现</div>
  <div class="inner-tab">拉新用户数据</div>
</div>
```

```css
.section-inner-tabs { display: flex; gap: 2px; margin-bottom: 12px; }
.inner-tab {
  padding: 4px 10px; font-size: 12px; cursor: pointer;
  border-radius: 4px; color: #4E5969;
  transition: background 80ms, color 80ms;
}
.inner-tab:hover  { background: #F2F3F5; }
.inner-tab.active { background: #EBF0FF; color: #165DFF; font-weight: 500; }
```

### 6.3 大图表区：Mini KPI + 图表联动

> 参考第二三张图：每个大图表区上方有 2-4 个 Mini KPI 数字 + 图表组合

```html
<div class="chart-section">
  <!-- Mini KPI 行（图表上方）-->
  <div class="chart-mini-kpi-row">
    <div class="chart-mini-kpi">
      <div class="chart-mini-kpi-label">查询耗时-P90 2024-01-21</div>
      <div class="chart-mini-kpi-num">770 <span class="unit">毫秒</span></div>
      <div class="chart-mini-kpi-delta">
        <span class="delta up">环比 ↑ 240%</span>
        <span class="delta up">同比 ↑ 240%</span>
      </div>
    </div>
    <div class="chart-mini-kpi">
      <div class="chart-mini-kpi-label">查询数量(求和) 2024-01-21</div>
      <div class="chart-mini-kpi-num">6,426,146</div>
      <div class="chart-mini-kpi-delta">
        <span class="delta up">环比 ↑ 240%</span>
        <span class="delta up">同比 ↑ 240%</span>
      </div>
    </div>
  </div>
  <!-- ECharts 图表 -->
  <div id="chart-traffic" class="chart-container"></div>
</div>
```

```css
.chart-mini-kpi-row { display: flex; gap: 32px; margin-bottom: 12px; }
.chart-mini-kpi-label { font-size: 11px; color: #86909C; margin-bottom: 4px; }
.chart-mini-kpi-num { font-size: 22px; font-weight: 700; color: #1D2129;
                       font-variant-numeric: tabular-nums; }
.chart-mini-kpi-num .unit { font-size: 13px; font-weight: 400; color: #4E5969; }
.chart-mini-kpi-delta { display: flex; gap: 12px; margin-top: 4px; font-size: 11px; }
```

### 6.4 可展开树状表格（指标下钻）

> 参考图第一张底部的多层缩进表格：支持折叠 / 展开子行

```html
<table class="data-table standard tree-table">
  <tbody>
    <!-- 一级行（可展开）-->
    <tr class="tree-row level-0 expandable" data-tree-row="1">
      <td>
        <button class="tree-expand-btn" onclick="toggleTree(1)">
          <i data-lucide="chevron-right" class="icon icon-sm"></i>
        </button>
        整体
      </td>
      <td class="num">83.9亿</td>
      <td class="num"><span class="delta up">11.1%</span></td>
    </tr>
    <!-- 二级行（折叠时 display:none）-->
    <tr class="tree-row level-1 tree-child" data-parent="1">
      <td style="padding-left: 32px">› 自销</td>
      <td class="num">83.9亿</td>
      <td class="num"><span class="delta up">11.1%</span></td>
    </tr>
    <!-- 三级行 -->
    <tr class="tree-row level-2 tree-child" data-parent="1">
      <td style="padding-left: 48px">› 短视频</td>
      <td class="num">83.9亿</td>
      <td class="num"><span class="delta down">-43.3%</span></td>
    </tr>
  </tbody>
</table>
```

```css
.tree-row.level-1 td:first-child { color: #4E5969; }
.tree-row.level-2 td:first-child { color: #86909C; }
.tree-expand-btn { border: none; background: transparent; cursor: pointer;
                   color: #86909C; padding: 0; display: inline-flex;
                   transition: transform 150ms; }
.tree-expand-btn.open .icon { transform: rotate(90deg); }
.tree-child { display: none; }
.tree-child.visible { display: table-row; }
```

---

## 七、Self-Check 补充项（Dashboard 专属）

```
内容层检查：
[ ] 状态指示点（pulse-dot）颜色语义正确（绿/黄/红）
[ ] 告警区在无告警时已隐藏（display:none 或条件渲染）
[ ] KPI 数字 ≥ 24px（看板可比报告略小，但不低于 24px）
[ ] 图表 x 轴时间颗粒度与场景匹配（实时用 HH:mm）
[ ] 含 markPoint 的图表 grid.top ≥ 48px
[ ] ECharts 容器使用 flex:1; min-height:0
[ ] 双栏/多栏图表左右底部对齐
[ ] 状态色仅用于表示状态（不用作装饰）
[ ] 深色主题时卡片背景 #1E293B，文字 #E2E8F0
[ ] tabular-nums 已应用于所有数字

站点层检查（看板站点版才检查）：
[ ] GlobalTopbar 有刷新按钮（loading 时旋转）
[ ] Left Sidebar 分组有图标 + 文字，active 项高亮
[ ] Primary Tab 用下划线样式（视角切换）
[ ] Section 内使用小型 Pill Tab（维度切换）
[ ] FilterBar 包含时间范围 + 产品/类别筛选
[ ] 可展开树状表格：有 chevron 图标 + 子行缩进（每级 +16px）
[ ] 图表卡片上方有 Mini KPI 数字（展示聚合值）
[ ] 动效：刷新图标旋转 spin，Tab 切换 indicator 滑动，树展开 250ms
```
