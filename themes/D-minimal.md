# themes/D-minimal.md — 极简轻量主题

> **适用场景**：工具型应用 ★ / 内容站 / 轻量 Landing Page  
> **视觉气质**：Linear / Notion / Vercel 感，无装饰，内容即设计，专注当下任务  
> **用户印象**："干干净净，没有多余的东西"、"像 Notion"、"感觉很现代"、"不花哨但很高级"  
> **字体组合**：Geist（标题）+ Inter（正文），或 Inter 单一字体  
> 来自 taste-skill **minimalist-skill** 变体

---

## CSS Token 变量（复制至 :root）

```css
:root {
  /* 品牌色（中性黑或极深灰）*/
  --color-primary:       #18181B;   /* 近黑（更像 Notion/Linear）*/
  --color-primary-light: #F4F4F5;   /* 极浅灰 */
  --color-primary-dark:  #09090B;

  /* 强调色（只有一个，克制使用）*/
  --color-accent:        #7C3AED;   /* 可换：深蓝 #1D4ED8 / 黑色主题直接用 #18181B */
  --color-accent-light:  #F5F3FF;

  /* 语义色 */
  --color-success:  #16A34A;
  --color-danger:   #DC2626;
  --color-warning:  #D97706;

  /* 数据语义色 */
  --color-positive: #16A34A;
  --color-negative: #DC2626;
  --color-neutral:  #9CA3AF;

  /* 背景层级（纯净白色系）*/
  --color-bg-page:   #FFFFFF;   /* 纯白，极简主义的核心 */
  --color-bg-card:   #FFFFFF;
  --color-bg-subtle: #FAFAFA;   /* 几乎不可见的分区 */

  /* 文字层级（接近黑白）*/
  --color-text-primary:   #09090B;  /* 近纯黑 */
  --color-text-body:      #3F3F46;  /* 深灰 */
  --color-text-secondary: #71717A;  /* 中灰 */
  --color-text-disabled:  #D4D4D8;

  /* 边框（极浅，几乎不存在）*/
  --color-border:  #E4E4E7;
  --color-divider: #F4F4F5;

  /* 极简阴影（几乎无）*/
  --shadow-sm: 0 1px 2px rgba(0, 0, 0, 0.05);
  --shadow-md: 0 2px 8px rgba(0, 0, 0, 0.06);
}
```

---

## 字体配置

```css
/* Geist 是 Vercel 出品的现代无衬线字体，备选 Inter */
@import url('https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap');
/* Geist: 如有本地安装或通过 npm 引入 */

body {
  font-family: "Geist", "Inter", -apple-system, "PingFang SC", sans-serif;
  font-size: 14px;
  background: var(--color-bg-page);
  color: var(--color-text-body);
  -webkit-font-smoothing: antialiased;
}
```

---

## 主题专属组件样式

> **极简主题的核心原则**：去除一切非必要视觉元素，  
> 层级靠字重和字号建立，空间靠间距而非颜色区分。

### 卡片（最极简版）

```css
/* Option A：仅用边框，无阴影 */
.card {
  background: var(--color-bg-card);
  border: 1px solid var(--color-border);
  border-radius: 8px;
  padding: 20px 24px;
}
/* 不加 hover shadow，纯靠边框颜色变化 */
.card:hover { border-color: var(--color-text-secondary); }

/* Option B：仅有浅灰背景，无边框（更 Notion 风）*/
.card-ghost {
  background: var(--color-bg-subtle);
  border-radius: 8px;
  padding: 20px 24px;
  border: none;
}
```

### 导航（Linear 风格）

```css
/* Sidebar */
.sidebar { background: #FAFAFA; border-right: 1px solid #E4E4E7; }
.nav-section-title {
  font-size: 11px; font-weight: 600; color: #71717A;
  text-transform: uppercase; letter-spacing: 0.06em;
  padding: 16px 12px 6px;
}
.nav-item { color: #3F3F46; padding: 6px 12px; border-radius: 6px; font-size: 13px; }
.nav-item:hover  { background: #F4F4F5; color: #09090B; }
.nav-item.active { background: #F4F4F5; color: #09090B; font-weight: 500; }

/* 顶部 Topbar */
.topbar { background: rgba(255,255,255,0.85); backdrop-filter: blur(8px);
          border-bottom: 1px solid #E4E4E7; }
```

### 按钮

```css
/* 极简按钮，无多余装饰 */
.btn-primary {
  background: var(--color-primary);
  color: #FFFFFF;
  border: none;
  padding: 7px 16px; border-radius: 6px;
  font-size: 13px; font-weight: 500;
  transition: background 0.1s;
}
.btn-primary:hover { background: #2D2D30; }

/* Ghost 按钮 */
.btn-ghost {
  background: transparent;
  color: var(--color-text-secondary);
  border: 1px solid var(--color-border);
  padding: 6px 14px; border-radius: 6px; font-size: 13px;
}
.btn-ghost:hover { background: var(--color-bg-subtle); color: var(--color-text-body); }
```

### 标签（Notion 风）

```css
/* 极简 Tag：几乎无颜色，靠边框和淡背景 */
.tag { background: #F4F4F5; color: #3F3F46;
       border-radius: 4px; font-size: 12px;
       padding: 2px 8px; font-weight: 400; }
.tag:hover { background: #E4E4E7; }
```

### 分隔线

```css
/* 分隔区块时，不用背景色，用超细的线 */
.section-divider {
  border: none;
  border-top: 1px solid var(--color-divider);
  margin: 40px 0;
}
```

### 输入框（极简版）

```css
.input {
  border: none;
  border-bottom: 1px solid var(--color-border);  /* 只有底线 */
  border-radius: 0;
  background: transparent;
  padding: 6px 0; font-size: 14px;
  transition: border-color 0.15s;
}
.input:focus { outline: none; border-bottom-color: var(--color-primary); }

/* 或者带圆角的 Notion 风 */
.input-rounded {
  border: 1px solid var(--color-border);
  border-radius: 6px; padding: 7px 10px;
  font-size: 14px; background: #FAFAFA;
}
.input-rounded:focus { background: #FFFFFF; border-color: #A1A1AA; outline: none; }
```

---

## 三旋钮参数（taste-skill minimalist-skill 风格）

```
VARIANCE  = 2/10  （布局极度规则，几乎不做视觉实验）
MOTION    = 1/10  （仅必要的 opacity/transform，100ms 以内）
DENSITY   = 5/10  （中等密度，不压缩也不过分留白）
```

---

## Self-Check 补充项（主题 D 专属）

```
[ ] 页面底色是纯白 #FFFFFF（极简主义核心）
[ ] 卡片无装饰性阴影（只有 hover 时出现，或完全无阴影）
[ ] 颜色种类 ≤ 2（near-black + 一个强调色）
[ ] 无渐变（连 Hero 区域也不用 mesh gradient）
[ ] 边框极浅（#E4E4E7 或更淡），不是 #D1D5DB
[ ] 按钮无圆形胶囊样式（border-radius ≤ 8px）
[ ] 所有动效 duration ≤ 150ms
[ ] 没有多余的图标或插画（内容本身就是视觉）
```
