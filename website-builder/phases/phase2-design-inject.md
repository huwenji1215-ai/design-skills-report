# phases/phase2-design-inject.md — 设计系统注入

> **加载时机**：新建站点 Phase 1 完成后；或用户要求"美化/换主题"时。  
> **目标**：把设计 Token 体系注入到项目，确保后续所有 UI 代码使用统一变量。  
> **这是设计域与工程域的衔接口，两边都必须经过这里。**

---

## 执行流程

### Step 1：加载场景规范

根据 Phase 0 确认的 `scene` 值，加载对应文件：

```
scene = landing-page  → 加载 design/scenes/landing-page.md
scene = data-report   → 加载 design/scenes/data-report.md
scene = dashboard     → 加载 design/scenes/dashboard.md
scene = tool-app      → 加载 design/scenes/tool-app.md
scene = content-doc   → 加载 design/scenes/content-doc.md
```

### Step 2：加载主题并生成 Token

根据 Phase 0 确认的 `theme` 值：

**标准主题（A-F）**：
```
theme = A → 加载 design/themes/A-enterprise-light.md
theme = B → 加载 design/themes/B-dark-pro.md
theme = C → 加载 design/themes/C-editorial.md
theme = D → 加载 design/themes/D-minimal.md
theme = E → 加载 design/themes/E-bold-bento.md
theme = F → 加载 design/themes/F-dark-neon.md
```

**品牌自定义（custom:#XXXXXX）**：
```
→ 加载 design/core/brand-token-derivation.md
→ 执行品牌色推导：主色 → 完整色阶 → 语义色 → 图表色
→ 生成自定义 Token 体系
```

### Step 3：写入 CSS Token 文件

在 `web/src/assets/theme.css` 中写入 `:root` 变量：

```css
/* 由 website-builder Phase 2 自动生成 — 主题：A-enterprise-light */
:root {
  /* 主色 */
  --color-primary:       #2563F4;
  --color-primary-dark:  #1E54D4;
  --color-primary-light: #EBF1FE;

  /* 背景层 */
  --color-bg-page:    #F7F8FA;
  --color-bg-card:    #FFFFFF;
  --color-bg-hover:   #F0F2F5;

  /* 文字 */
  --color-text-primary:   #1A1D2E;
  --color-text-secondary: #4B4D63;
  --color-text-muted:     #9A9CB0;
  --color-text-inverse:   #FFFFFF;

  /* 语义色 */
  --color-positive: #18A058;
  --color-negative: #F04848;
  --color-warning:  #F0800A;

  /* 边框 */
  --color-border:       #DFE0E8;
  --color-border-focus: #2563F4;

  /* 图表序列色（独立于 UI Token，不与语义色重叠）*/
  --chart-color-1: #2563F4;
  --chart-color-2: #2CA8C2;
  --chart-color-3: #A45FF5;
  --chart-color-4: #F5A623;
  --chart-color-5: #5CB85C;
  --chart-color-6: #E74C3C;
  --chart-color-7: #34495E;
  --chart-color-8: #1ABC9C;
  --chart-color-9: #F39C12;

  /* 字号（5 级体系）*/
  --font-size-xl:   24px;
  --font-size-lg:   18px;
  --font-size-base: 14px;
  --font-size-sm:   12px;
  --font-size-xs:   11px;

  /* 圆角 */
  --radius-card:  8px;
  --radius-btn:   6px;
  --radius-tag:   4px;
  --radius-input: 6px;

  /* 阴影 */
  --shadow-sm: 0 1px 4px rgba(37,99,244,0.06);
  --shadow-md: 0 4px 12px rgba(37,99,244,0.10);
  --shadow-lg: 0 8px 24px rgba(37,99,244,0.14);

  /* 间距（8px 基准）*/
  --space-1: 4px;
  --space-2: 8px;
  --space-3: 12px;
  --space-4: 16px;
  --space-5: 24px;
  --space-6: 32px;
  --space-7: 48px;
  --space-8: 64px;
}
```

> 其他主题的 `:root` 值见各 `design/themes/*.md` 文件，替换对应色值即可。

### Step 4：生成 Tailwind 配置（如项目使用 Tailwind）

若工程侧使用 Tailwind CSS + Headless UI 技术栈，将 Token 同步到 `tailwind.config.js`：

```javascript
// tailwind.config.js（由 Phase 2 注入，与 theme.css 保持同步）
module.exports = {
  theme: {
    extend: {
      colors: {
        primary: {
          DEFAULT: '#2563F4',
          dark:    '#1E54D4',
          light:   '#EBF1FE',
        },
        'bg-page':  '#F7F8FA',
        'bg-card':  '#FFFFFF',
        'bg-hover': '#F0F2F5',
        'text-primary':   '#1A1D2E',
        'text-secondary': '#4B4D63',
        'text-muted':     '#9A9CB0',
        positive: '#18A058',
        negative: '#F04848',
        warning:  '#F0800A',
        border:   '#DFE0E8',
      },
      borderRadius: {
        card:  '8px',
        btn:   '6px',
        tag:   '4px',
        input: '6px',
      },
      boxShadow: {
        sm: '0 1px 4px rgba(37,99,244,0.06)',
        md: '0 4px 12px rgba(37,99,244,0.10)',
        lg: '0 8px 24px rgba(37,99,244,0.14)',
      },
      fontSize: {
        xl:   '24px',
        lg:   '18px',
        base: '14px',
        sm:   '12px',
        xs:   '11px',
      },
      spacing: {
        1: '4px', 2: '8px', 3: '12px', 4: '16px',
        5: '24px', 6: '32px', 7: '48px', 8: '64px',
      },
    },
  },
};
```

> 完整的 6套主题 Tailwind 配置见 `references/tailwind-bridge.md`。

### Step 5：在 App.vue 中引入全局样式

```vue
<!-- App.vue <style>（不加 scoped）-->
<style>
@import '@/assets/theme.css';

* { box-sizing: border-box; }
body {
  margin: 0;
  font-family: -apple-system, 'PingFang SC', sans-serif;
  font-size: var(--font-size-base);
  color: var(--color-text-primary);
  background: var(--color-bg-page);
}
</style>
```

---

## Phase 2 完成标志

```
[ ] theme.css 已写入 web/src/assets/
[ ] App.vue 已 @import theme.css
[ ] 如用 Tailwind → tailwind.config.js 已更新 theme.extend
[ ] 已加载对应 scenes/*.md（了解页面结构要求）
[ ] 主题文件已加载（了解具体色值和特殊规则）
```

→ **进入 Phase 3（代码生成）**
