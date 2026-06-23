# themes/A-enterprise-light.md — 企业亮色主题

> **适用场景**：Landing Page ★ / 工具应用 / 数据日报  
> **视觉气质**：科技商务感，干净克制，「大厂风」，Ant Design 系统，阿里云蓝。  
> **用户印象**："看起来很专业大厂"、"非常干净整洁"、"清爽的科技蓝"、"值得信赖"  
> **字体组合**：Inter（标题）+ PingFang SC 中文补字

---

## CSS Token 变量（复制至 :root）

```css
:root {
  /* 品牌色 */
  --color-primary:       #1677FF;   /* 阿里云蓝 / Ant Design blue-6 */
  --color-primary-light: #E6F4FF;   /* 主色背景浅色 */
  --color-primary-dark:  #0958D9;   /* 主色 hover/active */

  /* 语义色 */
  --color-success:  #52C41A;
  --color-danger:   #FF4D4F;
  --color-warning:  #FAAD14;

  /* 数据语义色（报告/看板中使用）*/
  --color-positive: #2EAD5E;  /* 增长/达成 */
  --color-negative: #D95040;  /* 下降/风险 */
  --color-neutral:  #9CA3AF;  /* 中性/持平 */

  /* 背景层级 */
  --color-bg-page:   #F7F9FE;  /* 极浅蓝灰，整页底色 */
  --color-bg-card:   #FFFFFF;  /* 卡片白底 */
  --color-bg-subtle: #F0F5FF;  /* 次级信息带（如 Feature Highlights 条）*/

  /* 文字层级 */
  --color-text-primary:   #1D2129;  /* 标题/重要文字 */
  --color-text-body:      #4E5969;  /* 正文 */
  --color-text-secondary: #86909C;  /* 辅助说明 */
  --color-text-disabled:  #C9CDD4;  /* 禁用/placeholder */

  /* 边框与分隔 */
  --color-border:  #E5E8EF;
  --color-divider: #F2F3F5;

  /* 阴影 */
  --shadow-sm: 0 1px 4px rgba(0, 0, 0, 0.08);
  --shadow-md: 0 4px 12px rgba(0, 0, 0, 0.10);
  --shadow-lg: 0 8px 32px rgba(0, 0, 0, 0.12);
}
```

---

## 字体配置

```css
body {
  font-family: "Inter", -apple-system, "PingFang SC", "Helvetica Neue", Arial, sans-serif;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
}
```

---

## 主题专属组件样式

### Hero 区域背景

```css
/* Landing Page Hero 区域的 mesh gradient（仅 Hero 可用）*/
.hero-bg {
  background: linear-gradient(135deg, #EFF6FF 0%, #FFFFFF 50%, #F0F5FF 100%);
  position: relative;
  overflow: hidden;
}

/* Hero 装饰光晕（absolute 定位，pointer-events:none）*/
.hero-blob-1 {
  position: absolute; top: -120px; right: -80px;
  width: 600px; height: 480px;
  background: radial-gradient(ellipse, rgba(22,119,255,0.08) 0%, transparent 65%);
  pointer-events: none;
}
.hero-blob-2 {
  position: absolute; bottom: -80px; left: -60px;
  width: 400px; height: 300px;
  background: radial-gradient(ellipse, rgba(99,102,241,0.06) 0%, transparent 65%);
  pointer-events: none;
}
```

### 卡片样式

```css
.card {
  background: var(--color-bg-card);
  border: 1px solid var(--color-border);
  border-radius: 12px;
  padding: 24px;
  transition: box-shadow 0.2s;
}
.card:hover { box-shadow: var(--shadow-md); }

/* 产品矩阵卡片（更紧凑）*/
.card-feature {
  background: var(--color-bg-card);
  border: 1px solid var(--color-border);
  border-radius: 10px;
  padding: 20px;
  transition: border-color 0.2s, box-shadow 0.2s;
}
.card-feature:hover {
  border-color: var(--color-primary-light);
  box-shadow: var(--shadow-sm);
}
```

### 按钮样式

```css
.btn-primary {
  background: var(--color-primary);
  color: #FFFFFF;
  border: none;
  padding: 10px 24px;
  border-radius: 6px;
  font-size: 14px;
  font-weight: 500;
  cursor: pointer;
  transition: background 0.15s;
}
.btn-primary:hover { background: var(--color-primary-dark); }

.btn-secondary {
  background: #FFFFFF;
  color: var(--color-text-body);
  border: 1px solid var(--color-border);
  padding: 9px 24px;
  border-radius: 6px;
  font-size: 14px;
  cursor: pointer;
  transition: border-color 0.15s, color 0.15s;
}
.btn-secondary:hover { border-color: var(--color-primary); color: var(--color-primary); }
```

### Badge / Tag 样式

```css
.tag {
  display: inline-flex; align-items: center;
  background: var(--color-primary-light);
  color: var(--color-primary);
  font-size: 12px; font-weight: 500;
  padding: 2px 10px; border-radius: 9999px;
}
.tag-new {
  background: #F6FFED;
  color: #389E0D;
}
```

### Section 标题

```css
.section-header {
  text-align: center;
  margin-bottom: 48px;
}
.section-title {
  font-size: 32px; font-weight: 700;
  color: var(--color-text-primary);
  margin-bottom: 12px;
}
.section-subtitle {
  font-size: 16px;
  color: var(--color-text-secondary);
  max-width: 560px; margin: 0 auto;
  line-height: 1.6;
}
```

---

## ECharts 配色（数据场景使用）

```javascript
const THEME_A_PALETTE = [
  '#1677FF',  // 主色蓝
  '#52C41A',  // 绿
  '#FAAD14',  // 橙
  '#FF4D4F',  // 红
  '#722ED1',  // 紫
  '#13C2C2',  // 青
  '#8B8FA8',  // 灰蓝
];
```

---

## Self-Check 补充项（主题 A 专属）

```
[ ] 主色使用 #1677FF（不偏紫，不偏绿）
[ ] 页面底色 #F7F9FE（不是纯白 #FFF）
[ ] Hero 光晕 blob 设置了 pointer-events: none
[ ] 卡片 border-radius 12px（Landing Page）或 6-8px（数据/工具场景）
[ ] 按钮有 hover 状态（background 深一档）
[ ] 正向 delta 使用 #2EAD5E（不是 #52C41A Ant 绿）
[ ] 负向 delta 使用 #D95040（不是 #FF4D4F Ant 红）
```
