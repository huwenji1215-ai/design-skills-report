# anti-patterns.md — 反模式清单

> **本文件包含**：BAD vs GOOD 对照示例 + 适用场景说明  
> **加载时机（Tier 3）**：审查 AI 生成样式质量 / 执行深度 Lint 时按需加载。  
> P0 级反模式已在 `SKILL.md §P0 Hard Rules` 中列出，本文件提供详细示例。

---

## 总原则

> 以下任意一条出现在输出中 = 确认被"AI 审美综合征"污染，必须修复。

---

## 反模式 01：Emoji 标题

```
❌ BAD:
  📊 总收入分析
  💡 核心洞察
  ⚠️ 风险提示
  🎉 重磅升级

✅ GOOD:
  总收入分析
  核心洞察
  风险提示
  重磅升级
```

> Typography（字重+字号+间距）建立层级，Emoji 不建立层级。
> 规则：标题、按钮、Badge、小标签均不得出现 Emoji。

---

## 反模式 02：卡片彩色顶条

```
❌ BAD:
.kpi-card::before {
  height: 4px;
  background: linear-gradient(90deg, #2261F5, #7B61FF);
}

✅ GOOD:
/* 无 ::before 条。用 label + 大数字 区分 KPI，不用颜色。 */
/* 如需区分指标类别，用 border-left: 3px solid var(--color-primary)（仅限 data-report）*/
```

> 彩色顶条 = 低信息密度装饰 + 破坏视觉统一性。

---

## 反模式 03：渐变背景卡片

```
❌ BAD:
.card {
  background: linear-gradient(135deg, #f0f4ff 0%, #f5f9f5 100%);
}
.header {
  background: radial-gradient(circle, rgba(34,97,245,0.1), transparent);
}

✅ GOOD:
.card   { background: #FFFFFF; }
.header { background: var(--color-bg-subtle); }
/* Landing Page header 可用极浅 mesh gradient，见 scenes/landing-page.md */
```

---

## 反模式 04：过大圆角

```
❌ BAD:  border-radius: 20px;  /* 玩具感 */
❌ BAD:  border-radius: 16px;  /* 数据/工具场景：过圆 */

✅ GOOD（数据/工具场景）: border-radius: 6px;
✅ GOOD（Landing Page）:   border-radius: 12px;  /* 最大 16px */
```

---

## 反模式 05：Delta 方向符号 ▲▼

```
❌ BAD:  <span>▲ +15.6%</span>

✅ GOOD:
<span class="delta up" style="color:var(--color-success)">
  <svg width="8" height="8" viewBox="0 0 8 8">
    <path d="M4 1L7 6H1L4 1Z" fill="currentColor"/>
  </svg>
  +15.6%
</span>
```

> 颜色承载语义，▲▼ 是冗余的低质量符号。

---

## 反模式 06：颜色过多 / 彩虹卡片

```
❌ BAD:
Card 1: 蓝色顶条
Card 2: 绿色顶条
Card 3: 紫色顶条
Card 4: 橙色顶条
→ 4 种强调色同时出现，互相竞争注意力

✅ GOOD:
全部卡片 → 白底 + 统一浅灰边框
颜色仅用于：delta 正负（绿/红）+ 主行动点（primary）
```

---

## 反模式 07：图表标题是标签而非结论

```
❌ BAD:  "年度总收入"         ← 描述图表内容
❌ BAD:  "Revenue Chart"     ← 无信息量

✅ GOOD: "总收入连续三年增长，2025 Q1 提速至 +15.6%"  ← 讲故事
✅ GOOD: "工作日流量是周末的 6 倍，波动集中在周一高峰"   ← 给出结论
```

---

## 反模式 08：装饰大于信息

判断方法：**移除该元素是否损失任何数据/信息？**

```
❌ 如果移除后零信息损失，则不应存在：
  - 纯装饰性 SVG 背景纹理（波浪线、六边形格）
  - 卡片后方的 radial-gradient 光晕
  - 多个元素的 box-shadow glow 效果
  - 每个标题后的装饰性 Badge/Pill
  - 图表区域背景色块（无数据含义）

✅ 允许存在的装饰：
  - Landing Page header 的 mesh gradient 背景（传递科技感的环境色）
  - Report header 的微质感 5 层结构（见 scenes/data-report.md）
  - 图标（有功能指向）
```

---

## 反模式 09：文本高亮滥用

```
❌ BAD（整行背景色）:
<p style="background:#EFF6FF; padding:8px">本季度营收增长15%，同比提升至……</p>

❌ BAD（高亮超过 6 个字的长句）:
<span class="highlight">电商业务实现了超预期的高质量增长</span>

❌ BAD（同段 3 种高亮颜色）:
<span class="green">增长</span>…<span class="red">风险</span>…<span class="orange">策略</span>

✅ GOOD（克制使用）:
营收 <span class="hl-num">+15.6%</span>，同比扩大。
<span class="hl-mark">AI Native 战略</span> 成为核心增长引擎。
→ 每段最多标注 1-3 个关键词/数字，不超过
```

> 原则：高亮 = 外科手术刀，不是彩笔。

---

## 反模式 10：字体选择 "AI 默认组合"

```
❌ 高风险字体（会让页面立刻"看起来像 AI 生成"）:
  Inter + Roboto 双用           ← 冗余，不统一
  Space Grotesk + Inter         ← 科技感过强，廉价
  Arial 直接上生产              ← 系统默认，无设计感
  100+ 种 Google Font 随意选   ← 缺乏设计判断

✅ 推荐使用（见各主题文件的字体配置）:
  主题 A（企业）:   Inter + PingFang SC（系统字体栈）
  主题 B（深色）:   Inter + PingFang SC
  主题 C（编辑）:   Playfair Display（标题）+ Source Serif 4（正文）
  主题 D（极简）:   Geist（标题）+ Inter（正文）
  主题 E（卡片）:   DM Sans（粗壮）+ Inter（正文）
```

---

## 反模式 11：响应式遗漏

```
❌ BAD:
.grid { grid-template-columns: repeat(4, 1fr); }  /* 移动端挤压 */

✅ GOOD:
.grid {
  grid-template-columns: repeat(4, 1fr);
}
@media (max-width: 768px) {
  .grid { grid-template-columns: 1fr 1fr; }
}
@media (max-width: 480px) {
  .grid { grid-template-columns: 1fr; }
}
```

---

---

## 反模式 12：多列高度不对齐

```
❌ BAD（flex 同行卡片高度不一，悬空留白）:
.card-row { display: flex; gap: 16px; }
/* 内容多的卡片撑开，内容少的卡片矮一截，底部对不齐 */

✅ GOOD（强制拉伸对齐）:
.card-row { display: grid; grid-template-columns: repeat(3, 1fr); gap: 16px; align-items: stretch; }
.card { display: flex; flex-direction: column; }
.card-body { flex: 1; }  /* 内容区自动撑满 */
```

> 同行卡片高度不一 = 版面破碎感 = 设计师最不能接受的低级错误之一

---

## 反模式 13：滥用 position:absolute 装饰元素

```
❌ BAD（装饰 blob 遮挡内容）:
.hero::after {
  position: absolute; width: 400px; height: 400px;
  border-radius: 50%;
  background: radial-gradient(#7B61FF, transparent);
  top: -100px; right: -200px;
  /* 未设 z-index 和 pointer-events，可能遮挡文字 */
}

✅ GOOD（安全装饰方式）:
.hero-blob {
  position: absolute; z-index: 0; pointer-events: none;
  opacity: 0.12;  /* ≤ 0.15 */
  /* 内容区 z-index: 1，确保内容始终在装饰层之上 */
}
.hero-content { position: relative; z-index: 1; }
```

> 规则：装饰 blob 必须 `pointer-events:none` + `z-index:0`，内容层 `z-index:1`。

---

## 反模式 14：按钮视觉权重混乱

```
❌ BAD（所有按钮等权重，行动点不突出）:
<button class="btn-primary">开始使用</button>   /* 实心蓝色 */
<button class="btn-primary">查看文档</button>    /* 同样实心蓝色 */
<button class="btn-primary">联系我们</button>    /* 同样实心蓝色 */

✅ GOOD（按钮层级系统）:
<button class="btn-primary">立即开始</button>   /* 实心：唯一主行动 */
<button class="btn-secondary">查看文档</button> /* 描边：次要行动 */
<button class="btn-ghost">联系我们</button>     /* 文本：辅助行动 */
```

```css
.btn-primary   { background: var(--color-primary); color: #FFF; }
.btn-secondary { background: transparent; border: 1px solid var(--color-primary); color: var(--color-primary); }
.btn-ghost     { background: transparent; color: var(--color-primary); text-decoration: none; }
/* 原则：一屏/一区块内 btn-primary ≤ 2 个 */
```

---

## 反模式 15：颜色对比度不足（可读性差）

```
❌ BAD（低对比度，无障碍失败）:
.badge { background: #E5E7EB; color: #9CA3AF; }  /* 对比度 ≈ 2.5:1，不达标 */
.link  { color: #93C5FD; }  /* 浅蓝在白底 ≈ 2.8:1，不达标 */

✅ GOOD（WCAG AA 最低标准 4.5:1）:
.badge    { background: #F0F5FF; color: #2563EB; }  /* 对比度 ≈ 6.5:1 ✓ */
.link     { color: #2563EB; }  /* 白底 ≈ 7.0:1 ✓ */
.subtext  { color: #6B7280; }  /* 白底 ≈ 4.6:1 ✓ */

/* 最低门槛（正文）: 4.5:1
   大文字（≥18px 常规 / ≥14px 加粗）: 3:1
   禁止：浅灰底 + 浅灰字、白底 + 浅蓝字 */
```

---

## 反模式 16：表单元素/输入框设计失范

```
❌ BAD（常见 AI 生成的输入框问题）:
input { border: none; border-radius: 20px; background: #F3F4F6; }
/* 圆角过大 + 无底线/无边框 = 没有"可交互"感 */

select { /* 无任何自定义，浏览器原生样式 */ }
/* 与页面设计系统完全不一致 */

✅ GOOD（输入框标准规范）:
input, select, textarea {
  height: 36px;
  padding: 0 12px;
  border: 1px solid var(--color-border);
  border-radius: 6px;   /* 工具/数据场景 */
  background: #FFFFFF;
  font-size: 14px; color: var(--color-text-primary);
  outline: none;
  transition: border-color 150ms;
}
input:focus, select:focus {
  border-color: var(--color-primary);
  box-shadow: 0 0 0 2px var(--color-primary-light);  /* focus ring */
}
/* 错误状态 */
input.error { border-color: var(--color-danger); }
input.error:focus { box-shadow: 0 0 0 2px rgba(239,68,68,0.15); }
```

---

## 反模式 17：字间距/行高与字号不配套

```
❌ BAD（标题行高太大，正文太紧）:
h1 { font-size: 40px; line-height: 1.8; }  /* 行高过大，标题松垮 */
p  { font-size: 14px; line-height: 1.2; }  /* 行高过小，正文拥挤难读 */

✅ GOOD（字号与行高对应关系）:
大标题（40-48px）:  line-height: 1.1 - 1.2; letter-spacing: -0.03em 到 -0.04em
中标题（24-32px）:  line-height: 1.2 - 1.3; letter-spacing: -0.02em
小标题（16-20px）:  line-height: 1.3 - 1.5;
正文（13-15px）:    line-height: 1.6 - 1.8;
小字（11-12px）:    line-height: 1.5 - 1.6;

/* 中文正文推荐 line-height: 1.8（比英文稍大，中文字形方）*/
/* 标题字号越大，letter-spacing 越应该为负值（kerning）*/
```

---

## 反模式 18：图表数据缺失时 crash

```
❌ BAD（数据为空时图表直接挂掉或显示空白）:
const chart = echarts.init(el);
chart.setOption({ series: [{ data: props.data }] });
// 如果 props.data 是 [] 或 null，ECharts 显示空轴，没有任何提示

✅ GOOD（空数据友好降级）:
if (!data || data.length === 0) {
  // 显示"暂无数据"占位状态
  el.innerHTML = '<div class="empty-state">暂无数据</div>';
  return;
}
chart.setOption({...});

/* 空状态样式 */
.empty-state {
  display: flex; align-items: center; justify-content: center;
  height: 200px; font-size: 13px; color: var(--color-text-secondary);
  border: 1px dashed var(--color-border); border-radius: 6px;
}
```

---

## 反模式 19：Z-index 层叠战争

```
❌ BAD（随意设置 z-index，导致弹窗被遮挡/导航穿透）:
.modal   { z-index: 99999; }
.sidebar { z-index: 100000; }
.tooltip { z-index: 999999999; }

✅ GOOD（标准化 z-index 层级）:
:root {
  --z-base:     1;      /* 普通卡片/内容层 */
  --z-dropdown: 100;    /* Dropdown/Select 弹出层 */
  --z-sticky:   200;    /* Sticky 导航/FilterBar */
  --z-overlay:  300;    /* Modal 遮罩层 */
  --z-modal:    400;    /* Modal 内容层 */
  --z-tooltip:  500;    /* Tooltip/Popover */
  --z-toast:    600;    /* Toast 通知（最顶层）*/
}
```

---

## 反模式 20：移动端 tap 区域过小

```
❌ BAD（图标按钮 16px，手指难以准确点击）:
.icon-btn { width: 16px; height: 16px; }
.nav-item { padding: 4px 8px; }

✅ GOOD（移动端最小触控面积 44x44px）:
.icon-btn {
  min-width: 44px; min-height: 44px;
  display: flex; align-items: center; justify-content: center;
}
/* 图标视觉尺寸可以是 20px，但触控区域 ≥ 44px */

.nav-item {
  min-height: 44px;
  padding: 0 16px;
  display: flex; align-items: center;
}
```

> Apple HIG / Google Material 均要求最小触控区域 44x44px。

---

## 常见误导性需求 & 正确处理方式（扩展版）

| 用户说 | 错误理解 | 正确做法 |
|--------|---------|---------|
| "让页面更漂亮" | 加渐变、加阴影、加颜色 | 收紧间距、优化字阶、统一字重 |
| "加点装饰" | 加 Emoji、光晕、彩色条 | 在区块标题加 left-border 线 |
| "更高级感" | 深色背景、发光效果 | 更多留白、精准字重、统一色系 |
| "突出重点" | 把重要内容都变彩色 | 用字号+字重突出，颜色只标注 1 处 |
| "现代一点" | 大圆角 + 渐变 + 阴影 | 强留白 + 极简边框 + 大字号数字 |
| "加动效" | 到处加 transition 和 animation | 只在交互反馈处加 150-250ms transition |
| "更像 XX 公司的风格" | 模仿配色 | 先读 core/three-layer-spec.md，从 User→Design→Tech 三层映射入手 |
| "品牌色是 #XXXXXX" | 直接用作背景大面积铺色 | 品牌色只用于 primary CTA / active 状态 / 语义点缀，背景保持中性 |
