# data-components/table-spec.md — 表格密度自适应规范

> **来源**：移植自 DesignAI-reports_20260610_172619，适配 web-site-beautifier 全场景。  
> **适用场景**：data-report（标准密度）/ dashboard（紧凑密度）/ tool-app（标准密度）  
> **加载时机（Tier 3）**：生成或美化包含表格的页面时按需加载。

---

## 一、三种密度规格

| 密度 | 行高 | padding | 适用场景 |
|------|------|---------|---------|
| **compact** | 32px | 0 12px | 看板 / 实时监控 / 数据密集日报 |
| **standard** | 44px | 0 16px | 数据报告 / 工具应用 |
| **comfortable** | 56px | 0 20px | 内容站表格 / 对比表 |

---

## 二、基础样式

```css
/* ── 通用基础 ── */
.data-table {
  width: 100%;
  border-collapse: collapse;
  font-variant-numeric: tabular-nums;  /* ← 数字对齐，必须 */
  font-size: 14px;
}

/* 表头 */
.data-table thead th {
  font-size: 11px;
  font-weight: 600;
  color: #6B7280;
  text-transform: uppercase;
  letter-spacing: 0.06em;
  text-align: left;
  border-bottom: 1px solid #E5E7EB;
  white-space: nowrap;
}

/* 数字列（右对齐）*/
.data-table th.num, .data-table td.num {
  text-align: right;
  font-variant-numeric: tabular-nums;
}

/* 数据行 */
.data-table tbody td { color: #374151; border-bottom: 1px solid #F3F4F6; }
.data-table tbody tr:hover td { background: #F9FAFB; }

/* 最后一行去掉 border */
.data-table tbody tr:last-child td { border-bottom: none; }

/* ── 密度变体 ── */
.data-table.compact  thead th { padding: 0 12px 8px; }
.data-table.compact  tbody td { height: 32px; padding: 0 12px; }

.data-table.standard thead th { padding: 0 16px 10px; }
.data-table.standard tbody td { height: 44px; padding: 0 16px; }

.data-table.comfortable thead th { padding: 0 20px 12px; }
.data-table.comfortable tbody td { height: 56px; padding: 0 20px; }
```

---

## 三、特殊列类型

### Delta 列（涨跌）

```html
<td class="num">
  <span class="delta up">+15.6%</span>
</td>
```

```css
/* 见 semantic-colors.md 的 delta 样式定义 */
```

### 进度条列

```html
<td>
  <div class="progress-cell">
    <div class="progress-bar" style="width: 72%"></div>
    <span class="progress-label">72%</span>
  </div>
</td>
```

```css
.progress-cell  { display: flex; align-items: center; gap: 8px; }
.progress-bar   { height: 4px; background: #BFDBFE; border-radius: 2px; flex: 1; }
.progress-bar   { position: relative; }
.progress-bar::after {
  content: ''; position: absolute; top: 0; left: 0; bottom: 0;
  background: #3B7FF5; border-radius: 2px;
  width: inherit;  /* 由 style 控制 */
}
.progress-label { font-size: 12px; color: #6B7280; white-space: nowrap; }
```

### 状态列

```html
<td>
  <span class="status-badge ok">正常</span>
</td>
```

> 见 `semantic-colors.md § 状态 Badge 组件`

### 热力列（单元格背景色）

```html
<td class="heat-7">98.6%</td>
<td class="heat-2">12.3%</td>
```

```css
/* 按数值范围用 .heat-1 到 .heat-7 映射 */
.heat-1 { background: #EFF6FF; }  /* 最低 */
.heat-2 { background: #DBEAFE; }
.heat-3 { background: #BFDBFE; }
.heat-4 { background: #93C5FD; }
.heat-5 { background: #60A5FA; color: #1D4ED8; }
.heat-6 { background: #3B82F6; color: #FFFFFF; }
.heat-7 { background: #2563EB; color: #FFFFFF; }  /* 最高 */
```

---

## 四、排序列头

```html
<th class="sortable" data-sort="asc">
  指标名称
  <svg class="sort-icon asc" ...></svg>
</th>
```

```css
.sortable       { cursor: pointer; user-select: none; }
.sortable:hover { color: #374151; }
.sort-icon      { display: inline-block; width: 10px; height: 10px;
                  vertical-align: middle; margin-left: 4px; }
```

---

## 五、固定首列 / 固定表头

```css
/* 固定表头（长表格必须）*/
.table-wrapper {
  overflow: auto;
  max-height: 480px;  /* 按容器调整 */
}
.data-table thead th { position: sticky; top: 0; z-index: 2; background: #FFFFFF; }

/* 固定首列 */
.data-table th:first-child,
.data-table td:first-child {
  position: sticky; left: 0; z-index: 1; background: #FFFFFF;
  border-right: 1px solid #E5E7EB;
}
```

---

## 六、表格内 Sparkline（行内趋势）

```html
<td>
  <canvas id="row-spark-1" width="60" height="24" class="row-spark"></canvas>
</td>
```

```css
.row-spark { display: block; }
```

```javascript
// 使用 kpi-card.md 中的 spark() 函数，调小尺寸
// spark('row-spark-1', [10, 15, 12, 18, 22], '#3B7FF5', null);  // 无填充
```

---

## 七、数字列规则汇总

```
[必须] 数字列 text-align: right
[必须] 数字列 font-variant-numeric: tabular-nums（防止不同位数的数字左右抖动）
[必须] 大数字加千位分隔符：1,234,567 而非 1234567
[建议] 同一列保持相同小数位数（如都是 2 位或都是整数）
[禁止] 数字列文字对齐方式混用（左右都有）
[禁止] 金额列不加千位分隔符
```

---

## 八、Self-Check（表格专属）

```
[ ] 表头 uppercase + 11px + letter-spacing: 0.06em
[ ] 表头字色 #6B7280（不是黑色）
[ ] 数字列 text-align: right + tabular-nums
[ ] 大数字有千位分隔符
[ ] hover 行有背景变化（#F9FAFB）
[ ] 超过 20 行有固定表头（position:sticky）
[ ] 超长表格有最大高度 + overflow:auto（不能撑满整页）
[ ] delta 列使用语义色（正绿负红），不使用 ▲▼ 字符
[ ] 无彩色行（不用背景色区分行类型，用 Badge 代替）
```
