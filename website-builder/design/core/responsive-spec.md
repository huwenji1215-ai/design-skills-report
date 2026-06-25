# core/responsive-spec.md — 响应式设计完整规范

> **本文件包含**：断点体系 / 字号缩放 / 间距缩放 / 组件响应规则 / 移动端触控标准  
> **加载时机（Tier 3）**：生成或审查需要响应式适配的页面时按需加载  
> **核心原则**：Desktop-first 用于数据/工具类，Mobile-first 用于 Landing Page / 内容类

---

## 一、断点体系（标准 4 档）

```css
:root {
  /* 4 个标准断点（与场景约定一致）*/
  --bp-sm:  480px;   /* 手机（竖屏）*/
  --bp-md:  768px;   /* 平板 / 大手机（横屏）*/
  --bp-lg:  1024px;  /* 小桌面 / 平板（横屏）*/
  --bp-xl:  1280px;  /* 标准桌面 */
  --bp-2xl: 1440px;  /* 宽屏桌面 */
}

/* 使用方式（Mobile-first，从小向大覆盖）*/
/* @media (min-width: 480px)  { ... }   SM 以上 */
/* @media (min-width: 768px)  { ... }   MD 以上 */
/* @media (min-width: 1024px) { ... }   LG 以上 */
/* @media (min-width: 1280px) { ... }   XL 以上 */
```

### 场景默认策略

| 场景 | 策略 | 最小支持宽度 |
|------|------|------------|
| Landing Page | Mobile-first | 320px |
| Content Doc | Mobile-first | 320px |
| Data Report | Desktop-first | 768px（移动端降级）|
| Dashboard | Desktop-first | 1024px（不支持手机）|
| Tool App | Desktop-first | 768px |

---

## 二、字号响应缩放

```css
/* 5 级字号体系 × 3 个断点 */

/* 移动端（< 768px）*/
:root {
  --text-display: 28px;  /* 大屏 40px → 移动端 28px */
  --text-h1:      22px;  /* 大屏 24px → 移动端 22px */
  --text-h2:      16px;  /* 大屏 16px → 不变 */
  --text-body:    14px;  /* 不变 */
  --text-small:   12px;  /* 不变 */
}

/* 平板（768px+）*/
@media (min-width: 768px) {
  :root {
    --text-display: 36px;
    --text-h1:      24px;
  }
}

/* 桌面（1280px+）*/
@media (min-width: 1280px) {
  :root {
    --text-display: 40px;
  }
}
```

### 禁止用法

```
❌ 禁止在移动端使用 display 级字号做正文（>28px 的字只在 hero 主标题）
❌ 禁止 font-size: calc(2vw + 10px) 这类流体字号（失去设计控制）
✅ 使用断点媒体查询阶梯式缩放，而非连续流体
```

---

## 三、间距缩放原则

```css
/* 间距不等比缩放：移动端越小比例越大地压缩 */

/* 区块间距（Section 之间的 padding）*/
.section-spacing {
  padding: 48px 20px;         /* 移动端 */
}
@media (min-width: 768px) {
  .section-spacing { padding: 64px 32px; }
}
@media (min-width: 1024px) {
  .section-spacing { padding: 80px 48px; }
}

/* 卡片内边距 */
.card {
  padding: 16px;              /* 移动端 */
}
@media (min-width: 768px) {
  .card { padding: 20px 24px; }
}
@media (min-width: 1280px) {
  .card { padding: 24px 28px; }
}

/* 栅格间距 */
.grid { gap: 12px; }
@media (min-width: 768px) { .grid { gap: 16px; } }
@media (min-width: 1024px) { .grid { gap: 20px; } }
```

---

## 四、栅格响应规则

```css
/* Landing Page 卡片阵列 */
.feature-grid {
  display: grid;
  grid-template-columns: 1fr;           /* 手机：1列 */
  gap: 12px;
}
@media (min-width: 640px) {
  .feature-grid { grid-template-columns: repeat(2, 1fr); gap: 16px; }  /* 2列 */
}
@media (min-width: 1024px) {
  .feature-grid { grid-template-columns: repeat(3, 1fr); gap: 20px; }  /* 3列 */
}

/* KPI 卡片 */
.kpi-grid-4 {
  grid-template-columns: repeat(2, 1fr);  /* 移动端：2列 */
}
@media (min-width: 768px) {
  .kpi-grid-4 { grid-template-columns: repeat(4, 1fr); }  /* 桌面：4列 */
}

/* 两栏布局（图文/图表）*/
.two-col {
  display: flex; flex-direction: column; gap: 16px;  /* 移动端：单列 */
}
@media (min-width: 768px) {
  .two-col { flex-direction: row; align-items: flex-start; }
}
```

---

## 五、导航栏响应规则

```css
/* 桌面：Horizontal Top Nav */
.nav { display: flex; align-items: center; gap: 8px; }

/* 平板（768px-）：隐藏导航，显示汉堡菜单 */
@media (max-width: 767px) {
  .nav { display: none; }
  .hamburger { display: flex; }  /* 汉堡按钮 */
  
  /* 移动端抽屉菜单 */
  .nav-mobile {
    position: fixed; top: 48px; left: 0; right: 0; bottom: 0;
    background: #FFFFFF; z-index: 200;
    padding: 16px;
    transform: translateX(-100%);
    transition: transform 250ms cubic-bezier(0.4, 0, 0.2, 1);
  }
  .nav-mobile.open { transform: translateX(0); }
}
```

---

## 六、数据平台移动端降级策略

> 数据类场景（Dashboard/Report）本不适合小屏，但必须有降级方案：

```css
/* 宽度 < 768px：数据表格横向滚动 */
@media (max-width: 767px) {
  .table-wrapper { overflow-x: auto; -webkit-overflow-scrolling: touch; }
  .data-table { min-width: 600px; }  /* 表格不换行，整体横向拖动 */
  
  /* 左侧 Sidebar 隐藏，顶部显示下拉菜单代替 */
  .left-sidebar { display: none; }
  .mobile-nav-dropdown { display: block; }
  
  /* 图表降为竖向单列 */
  .chart-grid-2col { grid-template-columns: 1fr; }
  
  /* 提示用户使用桌面端 */
  .desktop-only-hint {
    display: block;
    background: #FFF7ED; border: 1px solid #FED7AA;
    border-radius: 6px; padding: 10px 14px;
    font-size: 13px; color: #92400E;
    margin-bottom: 16px;
    text-align: center;
  }
}

/* 宽度 ≥ 768px 时隐藏提示 */
@media (min-width: 768px) {
  .desktop-only-hint { display: none; }
  .mobile-nav-dropdown { display: none; }
}
```

---

## 七、Landing Page 移动端专项规则

```css
/* Hero Section 移动端调整 */
@media (max-width: 767px) {
  .hero-headline { font-size: 28px; line-height: 1.2; }
  .hero-subtext  { font-size: 15px; }
  .hero-cta      { width: 100%; justify-content: center; }  /* 按钮全宽 */
  .hero-image    { margin-top: 32px; order: 1; }  /* 图片移到下方 */
  .hero-text     { order: 0; }
}

/* Pricing 表格移动端：横向可滚动或折叠为卡片 */
@media (max-width: 767px) {
  .pricing-table  { display: none; }
  .pricing-cards  { display: flex; flex-direction: column; gap: 16px; }
}
@media (min-width: 768px) {
  .pricing-table  { display: table; }
  .pricing-cards  { display: none; }
}
```

---

## 八、触控规范（移动端）

```css
/* ✅ P0：所有可点击元素最小触控区域 44×44px */
.btn, .nav-item, .tab, .card-action {
  min-height: 44px;
}

/* 图标按钮（视觉小但触控区大）*/
.icon-btn {
  width: 44px; height: 44px;
  display: flex; align-items: center; justify-content: center;
  /* 图标本身可以是 20px */
}

/* 表单元素移动端 */
@media (max-width: 767px) {
  input, select, textarea {
    font-size: 16px !important;  /* ⚠️ 必须 ≥ 16px，防止 iOS 自动缩放页面 */
    height: 44px;
  }
}

/* 禁止 hover-only 交互（移动端无 hover）*/
/* 任何 :hover 展示的内容，必须同时有 :focus 或点击触发的备用方案 */
```

---

## 九、响应式 Self-Check

```
[ ] 所有 4 列布局在 480px 以下降级为 1 列（不是挤在 4 列）
[ ] 所有 3 列布局在 768px 以下降级为 ≤2 列
[ ] 两栏图文在 768px 以下变为单列（图文垂直排列）
[ ] 横向滚动的数据表格有 overflow-x:auto + min-width 防止内容消失
[ ] 移动端导航有汉堡菜单或折叠方案
[ ] input/select 在移动端 font-size ≥ 16px（防 iOS 缩放）
[ ] 所有可点击元素 min-height ≥ 44px（移动端 tapTarget）
[ ] Hero 标题移动端 ≤ 32px（过大导致截行）
[ ] 按钮在移动端是否全宽（CTA 按钮宽度 ≥ 200px）
[ ] 没有只在 hover 时才显示的关键信息（移动端无 hover）
[ ] 深色主题在移动端 OLED 下检查可读性（#000 vs #060C1A 差别）
```
