# themes/C-editorial.md — 编辑排版主题

> **适用场景**：内容站 ★ / 知识库 / 深度报告 / 高质感 Landing Page  
> **视觉气质**：杂志感，高端克制，内容优先，来自 taste-skill soft-skill 变体  
> **用户印象**："像在读一本高质量的杂志"、"很有质感，不像那种千篇一律的网站"、"字体很好看"  
> **字体组合**：Playfair Display（大标题）+ Source Serif 4 或 Inter（正文）

---

## CSS Token 变量（复制至 :root）

```css
:root {
  /* 品牌色（冷静的深绛红，区别于「科技蓝」）*/
  --color-primary:       #2D3436;   /* 近黑，高端气质 */
  --color-primary-light: #F8F8F6;   /* 极浅暖灰 */
  --color-primary-dark:  #1A1A1A;

  /* 强调色（一个点缀，不宜过多）*/
  --color-accent:        #E17055;   /* 暖陶红（可换：深绿 #27AE60 / 靛蓝 #2C3E50）*/
  --color-accent-light:  #FDF0ED;

  /* 语义色 */
  --color-success:  #27AE60;
  --color-danger:   #C0392B;
  --color-warning:  #E67E22;

  /* 数据语义色 */
  --color-positive: #27AE60;
  --color-negative: #C0392B;
  --color-neutral:  #95A5A6;

  /* 背景层级（暖白 + 极浅暖灰）*/
  --color-bg-page:   #FAFAF8;   /* 带一点米白暖调 */
  --color-bg-card:   #FFFFFF;
  --color-bg-subtle: #F5F5F0;   /* 次级区块，略暖 */

  /* 文字层级 */
  --color-text-primary:   #1A1A1A;  /* 近黑标题 */
  --color-text-body:      #374151;  /* 深灰正文 */
  --color-text-secondary: #6B7280;  /* 辅助说明 */
  --color-text-disabled:  #D1D5DB;

  /* 边框（更柔和）*/
  --color-border:  #E8E8E4;
  --color-divider: #F0F0EB;

  /* 阴影（比较柔和）*/
  --shadow-sm: 0 1px 3px rgba(0, 0, 0, 0.06);
  --shadow-md: 0 4px 16px rgba(0, 0, 0, 0.08);
}
```

---

## 字体配置（关键：主题 C 的核心差异化）

```css
/* 需要引入 Google Fonts */
@import url('https://fonts.googleapis.com/css2?family=Playfair+Display:wght@400;600;700&family=Source+Serif+4:ital,wght@0,300;0,400;0,600;1,400&family=Inter:wght@400;500;600&display=swap');

body {
  font-family: "Source Serif 4", "Georgia", "PingFang SC", serif;
  color: var(--color-text-body);
  background: var(--color-bg-page);
  -webkit-font-smoothing: antialiased;
}

/* 大标题使用 Playfair Display */
h1, h2, .display-text {
  font-family: "Playfair Display", "Georgia", serif;
  font-weight: 700;
  color: var(--color-text-primary);
  letter-spacing: -0.02em;
}

/* 数据 / UI 组件用回 Inter（无衬线更清晰）*/
.ui-text, .data-text, button, .badge, .nav-item, .form-label, table {
  font-family: "Inter", -apple-system, "PingFang SC", sans-serif;
}
```

---

## 主题专属组件样式

### 版式标题

```css
.display-hero  { font-size: 56px; font-weight: 700; line-height: 1.1;
                 letter-spacing: -0.03em; color: var(--color-text-primary); }
.section-title { font-size: 36px; font-weight: 700; line-height: 1.2;
                 letter-spacing: -0.02em; color: var(--color-text-primary); }

/* 标题前装饰线（编辑风格特征）*/
.titled-section h2::before {
  content: '';
  display: block;
  width: 40px; height: 3px;
  background: var(--color-accent);
  margin-bottom: 16px;
  border-radius: 2px;
}
```

### 卡片（更柔和边框）

```css
.card {
  background: var(--color-bg-card);
  border: 1px solid var(--color-border);
  border-radius: 8px;
  padding: 28px 32px;
  transition: box-shadow 0.25s ease;
}
.card:hover { box-shadow: var(--shadow-md); }
```

### 引用块（编辑专用）

```css
.pullquote {
  border-left: none;
  border-top: 2px solid var(--color-text-primary);
  border-bottom: 2px solid var(--color-text-primary);
  padding: 20px 0;
  margin: 32px 0;
  font-family: "Playfair Display", serif;
  font-size: 22px;
  font-style: italic;
  color: var(--color-text-primary);
  line-height: 1.5;
}
```

### 强调块

```css
.highlight-block {
  background: var(--color-accent-light);
  border-left: 3px solid var(--color-accent);
  border-radius: 0 6px 6px 0;
  padding: 16px 20px;
  margin: 24px 0;
  font-size: 15px; color: var(--color-text-body);
}
```

### 按钮（编辑风格：边框优先）

```css
.btn-primary {
  background: var(--color-primary);
  color: #FFFFFF; border: none;
  padding: 10px 24px; border-radius: 4px;
  font-family: "Inter", sans-serif;
  font-size: 14px; font-weight: 500;
  letter-spacing: 0.02em;
}
.btn-outline {
  background: transparent;
  color: var(--color-text-primary);
  border: 1.5px solid var(--color-text-primary);
  padding: 9px 24px; border-radius: 4px;
  font-family: "Inter", sans-serif;
  font-size: 14px; font-weight: 500;
}
.btn-outline:hover { background: var(--color-text-primary); color: #FFFFFF; }
```

### 标签/分类

```css
.category-tag {
  display: inline-block;
  font-family: "Inter", sans-serif;
  font-size: 11px; font-weight: 600;
  text-transform: uppercase; letter-spacing: 0.08em;
  color: var(--color-accent);
  /* 无背景色，纯文字 + 颜色区分 */
}

/* 文章列表卡片 */
.article-card {
  border-bottom: 1px solid var(--color-divider);
  padding: 24px 0;
}
.article-card:last-child { border-bottom: none; }
```

---

## 三旋钮参数（taste-skill soft/minimalist 风格）

```
VARIANCE  = 5/10  （有适度排版变化：不对称布局、大字号对比）
MOTION    = 2/10  （极少动效，只有 hover 过渡）
DENSITY   = 4/10  （阅读优先，留白充分）
```

---

## Self-Check 补充项（主题 C 专属）

```
[ ] 大标题使用 Playfair Display 或等价衬线字体
[ ] 正文行高 ≥ 1.75（阅读优先场景）
[ ] 页面底色是 #FAFAF8（带一点暖调，不是纯白 #FFFFFF）
[ ] 强调色（accent）仅在 1-2 处使用（标题装饰线 / 引用块边框）
[ ] 无彩虹色、无渐变装饰
[ ] 按钮字体使用 Inter（UI 组件回归无衬线）
[ ] 卡片 padding 比其他主题略大（28-32px）体现呼吸感
[ ] Google Fonts 链接已正确引入（或本地字体替换）
```
