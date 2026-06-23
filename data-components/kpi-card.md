# data-components/kpi-card.md — KPI 卡片规范

> **来源**：移植自 DesignAI-reports_20260610_172619（最终版），保持与 data-report / dashboard 场景完全兼容。  
> **适用场景**：data-report / dashboard  
> **加载时机（Tier 3）**：需要生成 KPI 卡片或 Sparkline 时按需加载。

---

## CSS — 4 种语义变体

```css
/* KPI 网格容器 */
.kpi-grid   { display: grid; gap: 10px; margin-bottom: 28px; }
.kpi-grid-4 { grid-template-columns: repeat(4, 1fr); }
.kpi-grid-3 { grid-template-columns: repeat(3, 1fr); }
.kpi-grid-2 { grid-template-columns: repeat(2, 1fr); }

/* 默认：蓝色微质感（主指标：总量、规模）*/
.kc {
  border-radius: 8px;
  border: 1px solid var(--color-border, #E5E7EB);
  background: linear-gradient(160deg, #ffffff 48%, rgba(34,97,245,0.05) 100%);
  padding: 16px 20px;
  display: flex;
  justify-content: space-between;
  align-items: flex-start;
}

/* .pos — 绿色调（正向财务指标：利润、增长额）*/
.kc.pos {
  background: linear-gradient(160deg, #ffffff 48%, rgba(0,185,107,0.06) 100%);
  border-color: rgba(0,185,107,0.20);
}

/* .neg — 红色调（负向/风险指标：亏损、下降）*/
.kc.neg {
  background: linear-gradient(160deg, #ffffff 48%, rgba(232,67,45,0.05) 100%);
  border-color: rgba(232,67,45,0.18);
}

/* .purple — 紫色调（率类指标：毛利率、净利率、转化率）*/
.kc.purple {
  background: linear-gradient(160deg, #ffffff 48%, rgba(123,97,255,0.05) 100%);
  border-color: rgba(123,97,255,0.18);
}

/* .warm — 暖橙色调（电商/大促场景：GMV、成交额）*/
.kc.warm {
  background: linear-gradient(160deg, #ffffff 48%, rgba(217,119,6,0.06) 100%);
  border-color: rgba(217,119,6,0.18);
}
```

---

## 卡片内部结构 CSS

```css
/* 左侧内容区 */
.kc-left  { flex: 1; min-width: 0; }
.kc-label { font-size: 12px; color: #6B7280; margin-bottom: 6px;
            white-space: nowrap; overflow: hidden; text-overflow: ellipsis; }
.kc-num   { font-size: 32px; font-weight: 700; color: #111827;
            line-height: 1.0; font-variant-numeric: tabular-nums; }
.kc-sub   { font-size: 12px; color: #9CA3AF; margin-top: 4px; }

/* Delta 标注（只用颜色，禁止 ▲▼）*/
.kc-delta {
  display: inline-flex; align-items: center; gap: 3px;
  font-size: 12px; font-weight: 500; margin-top: 6px;
}
.kc-delta.up   { color: #2EAD5E; }
.kc-delta.down { color: #D95040; }
.kc-delta.neu  { color: #9CA3AF; }

/* Delta 上升箭头 SVG（嵌入到 HTML 中）*/
/* 上升：<path d="M4 1L7 6H1L4 1Z" />  下降：<path d="M4 7L1 2H7L4 7Z" /> */

/* 右侧 Sparkline 区域 */
.kc-spark {
  display: block;
  width: 80px; height: 52px;
  flex-shrink: 0;
}
```

---

## HTML 结构（有 Sparkline 版）

```html
<div class="kpi-grid kpi-grid-4">

  <!-- 主指标（默认蓝色）+ 有趋势数据 → 加 canvas -->
  <div class="kc">
    <div class="kc-left">
      <div class="kc-label">总收入（亿元）</div>
      <div class="kc-num">336</div>
      <div class="kc-delta up">
        <svg width="8" height="8" viewBox="0 0 8 8" fill="none">
          <path d="M4 1L7 6H1L4 1Z" fill="currentColor"/>
        </svg>
        +15.6% YoY
      </div>
    </div>
    <!-- ✅ 仅在有历史序列数据时才加 canvas -->
    <canvas class="kc-spark" id="sp-rev" width="80" height="52"></canvas>
  </div>

  <!-- 正向指标（绿色）+ 有趋势数据 -->
  <div class="kc pos">
    <div class="kc-left">
      <div class="kc-label">毛利润（亿元）</div>
      <div class="kc-num">162</div>
      <div class="kc-delta up">
        <svg width="8" height="8" viewBox="0 0 8 8" fill="none">
          <path d="M4 1L7 6H1L4 1Z" fill="currentColor"/>
        </svg>
        +21.3% YoY
      </div>
    </div>
    <canvas class="kc-spark" id="sp-gp" width="80" height="52"></canvas>
  </div>

  <!-- 率类指标（紫色）+ 无趋势数据 → 不加 canvas -->
  <div class="kc purple">
    <div class="kc-left">
      <div class="kc-label">毛利率</div>
      <div class="kc-num">48.2%</div>
      <div class="kc-sub">较上季度 +1.6pp</div>
    </div>
    <!-- ✅ 无历史数据：不写 canvas -->
  </div>

  <!-- 电商指标（暖橙）-->
  <div class="kc warm">
    <div class="kc-left">
      <div class="kc-label">GMV（亿元）</div>
      <div class="kc-num">9,000</div>
      <div class="kc-delta up">
        <svg width="8" height="8" viewBox="0 0 8 8" fill="none">
          <path d="M4 1L7 6H1L4 1Z" fill="currentColor"/>
        </svg>
        +32% YoY
      </div>
    </div>
    <canvas class="kc-spark" id="sp-gmv" width="80" height="52"></canvas>
  </div>

</div>
```

---

## ⚠️ Sparkline 数据强制规则

| 情况 | 处理方式 |
|------|---------|
| 有 ≥ 3 个历史数据点（如季度/月度序列）| 加 `<canvas class="kc-spark">` + 对应 `spark()` 调用 |
| 只有当期单值，无历史序列 | **不加 canvas，不调用 spark()** |
| 用户未提供趋势数据 | **不加 canvas，不调用 spark()**，右侧留白 |

```
❌ 禁止：用户只给了一个数字，却自行捏造 [1,2,3,4] 数组然后画 sparkline
✅ 正确：用户提供了 4 个季度数据 → 仅这些指标的卡片才加 sparkline
```

---

## Sparkline JS 实现（零依赖）

```javascript
function spark(id, data, color, fill) {
  const c = document.getElementById(id);
  if (!c) return;
  const ctx = c.getContext('2d');
  const W = c.width, H = c.height, p = {t:4, b:4, l:2, r:2};
  const min = Math.min(...data), max = Math.max(...data), range = max - min || 1;
  const xs = data.map((_, i) => p.l + (i / (data.length - 1)) * (W - p.l - p.r));
  const ys = data.map(v => H - p.b - ((v - min) / range) * (H - p.t - p.b));
  ctx.clearRect(0, 0, W, H);
  if (fill) {
    ctx.beginPath();
    ctx.moveTo(xs[0], H - p.b);
    xs.forEach((x, i) => ctx.lineTo(x, ys[i]));
    ctx.lineTo(xs[xs.length - 1], H - p.b);
    ctx.closePath();
    ctx.fillStyle = fill;
    ctx.fill();
  }
  ctx.beginPath();
  ctx.moveTo(xs[0], ys[0]);
  xs.forEach((x, i) => ctx.lineTo(x, ys[i]));
  ctx.strokeStyle = color;
  ctx.lineWidth = 1.5;
  ctx.lineJoin = 'round';
  ctx.stroke();
}

// ✅ 颜色对照（fill 透明度 ≤ 0.12）
// spark('sp-rev',  [901,1135,1278,336],      '#2261F5', 'rgba(34,97,245,0.10)');   蓝
// spark('sp-gp',   [335,473,596,162],         '#00B96B', 'rgba(0,185,107,0.10)');   绿
// spark('sp-gm',   [37.2,41.7,46.6,48.2],    '#7B61FF', 'rgba(123,97,255,0.10)');  紫
// spark('sp-gmv',  [2500,4700,6800,9000],     '#D97706', 'rgba(217,119,6,0.10)');   暖橙
```

---

## 场景选择速查

| 指标类型 | Class | 颜色 |
|---------|-------|------|
| 主指标（总量、用户规模、MAU/DAU）| `.kc`（默认）| 蓝 `#2261F5` |
| 正向财务（利润、增长额）| `.kc.pos` | 绿 `#00B96B` |
| 率类（毛利率、净利率、转化率）| `.kc.purple` | 紫 `#7B61FF` |
| 电商/大促（GMV、成交额）| `.kc.warm` | 橙 `#D97706` |
| 负向/风险（亏损、下降、风险暴露）| `.kc.neg` | 红 `#E8432D` |

---

## 响应式（数据报告移动端）

```css
@media (max-width: 768px) {
  .kpi-grid-4 { grid-template-columns: repeat(2, 1fr); }
  .kpi-grid-3 { grid-template-columns: repeat(2, 1fr); }
  .kc-num     { font-size: 26px; }
}
@media (max-width: 480px) {
  .kpi-grid-4, .kpi-grid-3, .kpi-grid-2 { grid-template-columns: 1fr; }
}
```
