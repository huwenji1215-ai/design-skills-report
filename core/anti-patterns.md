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

## 常见误导性需求 & 正确处理方式

| 用户说 | 错误理解 | 正确做法 |
|--------|---------|---------|
| "让页面更漂亮" | 加渐变、加阴影、加颜色 | 收紧间距、优化字阶、统一字重 |
| "加点装饰" | 加 Emoji、光晕、彩色条 | 在区块标题加 left-border 线 |
| "更高级感" | 深色背景、发光效果 | 更多留白、精准字重、统一色系 |
| "突出重点" | 把重要内容都变彩色 | 用字号+字重突出，颜色只标注 1 处 |
| "现代一点" | 大圆角 + 渐变 + 阴影 | 强留白 + 极简边框 + 大字号数字 |
