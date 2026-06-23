# themes/E-bold-bento.md — 卡片网格主题（Bento 强对比）

> **适用场景**：现代 Landing Page / 产品展示 / 个人主页  
> **视觉气质**：Bento Grid，高对比，大字号，现代感，网格即内容  
> **用户印象**："感觉像 Apple 的产品展示页"、"很酷很现代"、"信息密度高但有设计感"  
> **字体组合**：DM Sans（强壮现代）+ Inter（正文数据）  
> 来自 taste-skill **brutalist 变体** 的温和版 + 现代 Bento 设计趋势

---

## CSS Token 变量（复制至 :root）

```css
:root {
  /* 品牌色（可根据产品调换，下面以深紫为示例）*/
  --color-primary:       #6D28D9;   /* 深紫，可换：#18181B 黑 / #0F4C75 深蓝 */
  --color-primary-light: #EDE9FE;
  --color-primary-dark:  #5B21B6;

  /* 对比强调（高对比度组合）*/
  --color-on-primary:    #FFFFFF;   /* 放在 primary 背景上的文字 */
  --color-accent:        #F59E0B;   /* 黄色点缀（可选）*/

  /* 语义色 */
  --color-success:  #10B981;
  --color-danger:   #EF4444;
  --color-warning:  #F59E0B;

  /* 数据语义色 */
  --color-positive: #10B981;
  --color-negative: #EF4444;
  --color-neutral:  #6B7280;

  /* 背景层级（Bento 允许不同卡片用不同底色）*/
  --color-bg-page:    #F8F8F8;   /* 整页浅灰底 */
  --color-bg-card:    #FFFFFF;   /* 白色卡片 */
  --color-bg-dark:    #18181B;   /* 深色卡片（Bento 特色：明暗交替）*/
  --color-bg-primary: #6D28D9;   /* 品牌色卡片（hero 型卡片）*/
  --color-bg-subtle:  #F3F4F6;   /* 次级卡片 */

  /* 文字（浅色卡片）*/
  --color-text-primary:   #09090B;
  --color-text-body:      #27272A;
  --color-text-secondary: #71717A;

  /* 文字（深色卡片专用）*/
  --color-text-on-dark:          #F1F5F9;
  --color-text-secondary-on-dark: #94A3B8;

  /* 边框（Bento 卡片边框稍重）*/
  --color-border: #E4E4E7;

  /* 阴影（Bento 允许略重阴影）*/
  --shadow-card: 0 2px 8px rgba(0,0,0,0.06), 0 0 1px rgba(0,0,0,0.04);
  --shadow-hover: 0 8px 24px rgba(0,0,0,0.10), 0 0 1px rgba(0,0,0,0.06);
}
```

---

## 字体配置

```css
@import url('https://fonts.googleapis.com/css2?family=DM+Sans:ital,opsz,wght@0,9..40,400;0,9..40,500;0,9..40,700;0,9..40,800&family=Inter:wght@400;500;600&display=swap');

body {
  font-family: "DM Sans", "Inter", -apple-system, "PingFang SC", sans-serif;
  background: var(--color-bg-page);
  color: var(--color-text-body);
  -webkit-font-smoothing: antialiased;
}
```

---

## Bento Grid 核心布局

```css
/* Bento 网格容器：不等宽，不等高 */
.bento-grid {
  display: grid;
  grid-template-columns: repeat(12, 1fr);
  grid-auto-rows: minmax(120px, auto);
  gap: 16px;
  max-width: 1200px; margin: 0 auto;
}

/* 卡片大小变体（通过 col/row span 实现不对称）*/
.bento-2x1  { grid-column: span 6; }   /* 宽：半宽 */
.bento-3x1  { grid-column: span 4; }   /* 宽：三分之一 */
.bento-4x1  { grid-column: span 3; }   /* 宽：四分之一 */
.bento-full { grid-column: span 12; }  /* 宽：全宽 */
.bento-8x1  { grid-column: span 8; }   /* 宽：三分之二 */
.bento-r2   { grid-row: span 2; }      /* 高：双倍高 */
.bento-r3   { grid-row: span 3; }      /* 高：三倍高 */

/* 响应式降级 */
@media (max-width: 768px) {
  .bento-2x1, .bento-3x1, .bento-4x1, .bento-8x1 { grid-column: span 12; }
}
```

---

## Bento 卡片样式变体

### 标准白色卡片

```css
.bento-card {
  background: var(--color-bg-card);
  border: 1px solid var(--color-border);
  border-radius: 16px;   /* Bento 允许更大圆角 */
  padding: 28px;
  box-shadow: var(--shadow-card);
  transition: box-shadow 0.2s, transform 0.2s;
  overflow: hidden;
}
.bento-card:hover {
  box-shadow: var(--shadow-hover);
  transform: translateY(-2px);
}
```

### 深色卡片（Bento 明暗交替）

```css
.bento-card.dark {
  background: var(--color-bg-dark);
  border-color: #2D2D30;
  color: var(--color-text-on-dark);
}
.bento-card.dark .bento-title { color: var(--color-text-on-dark); }
.bento-card.dark .bento-desc  { color: var(--color-text-secondary-on-dark); }
```

### 品牌色卡片（最吸睛的 Hero 卡片）

```css
.bento-card.brand {
  background: var(--color-bg-primary);
  border: none;
  color: var(--color-on-primary);
}
.bento-card.brand .bento-num  { color: #FFFFFF; }
.bento-card.brand .bento-desc { color: rgba(255,255,255,0.75); }
```

### 渐变卡片（谨慎使用，仅限 1-2 张）

```css
.bento-card.gradient {
  background: linear-gradient(135deg, #667EEA 0%, #764BA2 100%);
  border: none;
  color: #FFFFFF;
}
```

---

## Bento 卡片内容规范

```css
/* 大数字展示型卡片 */
.bento-num {
  font-size: 52px; font-weight: 800;
  line-height: 1.0; letter-spacing: -0.04em;
  color: var(--color-text-primary);
  font-variant-numeric: tabular-nums;
}
.bento-num-unit { font-size: 20px; font-weight: 600; vertical-align: super; }

/* 卡片标题 */
.bento-title { font-size: 18px; font-weight: 700;
               color: var(--color-text-primary); margin-bottom: 8px; }

/* 卡片描述 */
.bento-desc  { font-size: 14px; color: var(--color-text-secondary); line-height: 1.5; }

/* 卡片眉标（小标签，在标题上方）*/
.bento-eyebrow {
  font-size: 11px; font-weight: 600;
  text-transform: uppercase; letter-spacing: 0.08em;
  color: var(--color-primary);
  margin-bottom: 8px;
}
```

---

## 典型 Bento 布局示例（Landing Page）

```html
<div class="bento-grid">
  <!-- 主 Hero 卡片：全宽 -->
  <div class="bento-card bento-full" style="min-height:280px">
    <div class="bento-eyebrow">产品发布</div>
    <h1 class="bento-title" style="font-size:40px">大标题吸引注意力</h1>
    <p class="bento-desc">简短有力的价值主张，不超过两行。</p>
  </div>

  <!-- 数据亮点卡片（品牌色）-->
  <div class="bento-card brand bento-2x1">
    <div class="bento-num">98%<span class="bento-num-unit">↑</span></div>
    <div class="bento-desc">客户满意度</div>
  </div>

  <!-- 功能介绍（深色）-->
  <div class="bento-card dark bento-2x1">
    <div class="bento-eyebrow">核心能力</div>
    <div class="bento-title">实时协同</div>
    <div class="bento-desc">多人同步编辑，毫秒级响应</div>
  </div>

  <!-- 三个等宽小卡片 -->
  <div class="bento-card bento-3x1">...</div>
  <div class="bento-card bento-3x1">...</div>
  <div class="bento-card bento-3x1">...</div>
</div>
```

---

## 三旋钮参数（taste-skill 变体参数）

```
VARIANCE  = 8/10  （高：不对称网格、明暗卡片交替、大小对比）
MOTION    = 4/10  （hover 上浮 translateY(-2px)，数字计数动效可选）
DENSITY   = 6/10  （中高：信息密度高，但有大字号提供视觉呼吸）
```

---

## Self-Check 补充项（主题 E 专属）

```
[ ] Bento 网格使用 grid-template-columns: repeat(12, 1fr)
[ ] 卡片大小有差异（至少 3 种 span 组合）
[ ] 深色卡片文字使用 #F1F5F9（不是 #FFFFFF，太刺眼）
[ ] 品牌色卡片最多占 25% 的卡片数量（不宜过多）
[ ] 大数字 font-size ≥ 40px，letter-spacing 负值（-0.03em 以上）
[ ] 卡片 border-radius 12-16px（Bento 允许更大圆角）
[ ] hover 状态有 transform: translateY(-2px)（轻微上浮）
[ ] 响应式：移动端所有卡片变为 span 12（单列）
[ ] 渐变卡片 ≤ 2 张（保持整体克制）
```
