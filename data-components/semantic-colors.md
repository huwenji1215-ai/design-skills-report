# data-components/semantic-colors.md — 语义色使用规则

> **适用场景**：data-report / dashboard（所有数据类场景）  
> **加载时机（Tier 3）**：审查/生成数据类页面的颜色时按需加载。  
> 本文件来源于 DesignAI-reports 设计系统，与 kpi-card / echarts-config 共享同一套语义。

---

## 一、核心语义色定义

```css
/* 数据语义色（全场景通用，不随主题变化）*/
:root {
  --semantic-positive: #2EAD5E;   /* 增长 / 达成 / 安全 / 正向 */
  --semantic-negative: #D95040;   /* 下降 / 风险 / 错误 / 负向 */
  --semantic-neutral:  #9CA3AF;   /* 持平 / 中性 / 无变化 */
  --semantic-forecast: #D97706;   /* 预测值 / 预算 / 临近阈值 */

  /* 主色（品牌数据色，跟随主题但有默认值）*/
  --semantic-primary: #2261F5;    /* 主系列颜色 */
}
```

> ⚠️ 语义色不随主题（A/B/C/D/E）变化，始终保持以上颜色。  
> 深色主题（B）中使用更亮版本（见 `themes/B-dark-pro.md`）。

---

## 二、Delta（涨跌）使用规则

### 正确用法

```html
<!-- ✅ 正确：用颜色 + 小箭头 SVG -->
<span class="delta up">
  <svg width="8" height="8" viewBox="0 0 8 8" fill="none">
    <path d="M4 1L7 6H1L4 1Z" fill="currentColor"/>
  </svg>
  +15.6%
</span>

<span class="delta down">
  <svg width="8" height="8" viewBox="0 0 8 8" fill="none">
    <path d="M4 7L1 2H7L4 7Z" fill="currentColor"/>
  </svg>
  -3.2%
</span>

<span class="delta neu">持平</span>
```

```css
.delta      { display:inline-flex; align-items:center; gap:3px;
              font-size:12px; font-weight:500; }
.delta.up   { color: var(--semantic-positive); }
.delta.down { color: var(--semantic-negative); }
.delta.neu  { color: var(--semantic-neutral); }
```

### 禁止用法

```
❌ 正向 delta 用 ▲ 字符
❌ 负向 delta 用 ▼ 字符
❌ 正向 delta 用红色（反向！严重违规）
❌ delta 用三角形 emoji（▲▼ emoji）
❌ 预测值使用正/负颜色（应用 forecast 暖橙色）
```

---

## 三、状态色（State Colors）

> 用于表示系统/业务运行状态，区别于涨跌的「趋势语义色」。

```css
:root {
  --state-ok:       #22C55E;   /* 正常 / 健康 / 通过 */
  --state-warn:     #F59E0B;   /* 预警 / 注意 / 临近 */
  --state-critical: #EF4444;   /* 异常 / 严重 / 失败 */
  --state-info:     #3B82F6;   /* 信息 / 提示 */
  --state-inactive: #9CA3AF;   /* 停用 / 已下线 */
}
```

### 状态 Badge 组件

```html
<span class="status-badge ok">正常</span>
<span class="status-badge warn">预警</span>
<span class="status-badge critical">异常</span>
<span class="status-badge info">进行中</span>
<span class="status-badge inactive">已停用</span>
```

```css
.status-badge {
  display: inline-flex; align-items: center; gap: 5px;
  padding: 2px 8px; border-radius: 9999px;
  font-size: 11px; font-weight: 500;
}
.status-badge::before {
  content: ''; display: block; width: 6px; height: 6px; border-radius: 50%;
  background: currentColor;
}
.status-badge.ok       { color: #16A34A; background: #F0FDF4; }
.status-badge.warn     { color: #B45309; background: #FFFBEB; }
.status-badge.critical { color: #DC2626; background: #FEF2F2; }
.status-badge.info     { color: #1D4ED8; background: #EFF6FF; }
.status-badge.inactive { color: #6B7280; background: #F3F4F6; }
```

---

## 四、多分类颜色（图表中的多系列）

> 最多 10 色，按顺序取用，禁止随意选色。

```javascript
// CF 标准 10 色序列
const CF_PALETTE = [
  '#3B7FF5',  // 主蓝
  '#2BBD8E',  // 翠绿
  '#F5A623',  // 橙
  '#E8532A',  // 暖红
  '#6B48C8',  // 紫
  '#00B8D4',  // 青
  '#7B8FAB',  // 蓝灰
  '#8BC34A',  // 草绿
  '#F0477A',  // 粉红
  '#9B27AF',  // 深紫
];

// 单系列图表：始终使用 #3B7FF5
// 两系列对比：#3B7FF5（当前）+ #E8532A（对比）
// 涨跌对比：#2EAD5E（增长）+ #D95040（下降）
```

### 分类颜色使用规则

```
≤ 2 系列：主色 + 对比色（蓝+红，或蓝+绿）
3-5 系列：按 CF_PALETTE 顺序取前 N 色
6-10 系列：CF_PALETTE 全用
> 10 系列：优先考虑合并分类；若必须超过 10，后续用 hatch 纹理区分

绝对禁止：
❌ 随意挑选彩虹色（多少色就挑多少）
❌ 对同类数据使用相近色（难以区分）
❌ 对单系列使用多色（无意义的颜色变化）
```

---

## 五、热力色（Heatmap）

```css
/* 数据热力：从浅到深的连续色阶（蓝色系）*/
.heatmap-1 { background: #EFF6FF; }  /* 最低 */
.heatmap-2 { background: #BFDBFE; }
.heatmap-3 { background: #93C5FD; }
.heatmap-4 { background: #60A5FA; }
.heatmap-5 { background: #3B82F6; }
.heatmap-6 { background: #2563EB; }
.heatmap-7 { background: #1D4ED8; color: #FFF; }  /* 最高 */

/* 使用规则：
   - 单维度强度：蓝色系（从浅到深）
   - 正负双向：绿（正）→ 灰（中）→ 红（负）
*/
```

---

## 六、颜色使用优先级（总原则）

```
1. 数据语义优先：颜色表达涨跌/状态，不表达美观
2. 数量克制：非灰色彩色 ≤ 3 种（除多分类图表外）
3. 顺序固定：多系列必须按 CF_PALETTE 顺序，不随意选色
4. 禁止装饰性用色：颜色只承载数据含义，不做装饰
5. 无色情况：数据中性时使用 --semantic-neutral（灰色）
```
