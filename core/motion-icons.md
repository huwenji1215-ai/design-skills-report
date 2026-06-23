# core/motion-icons.md — 交互动效 + 图标体系

> **本文件包含**：交互动效规范（Transition / Animation / Micro-interaction）+ 图标引用体系  
> **适用场景**：所有场景通用，数据类场景（data-report/dashboard）有专项规则  
> **加载时机（Tier 3）**：需要实现动效或图标时按需加载

---

## 一、动效总原则

```
功能性优先：动效必须服务于交互理解，不做纯装饰性动画
克制原则：一屏内同时运动的元素 ≤ 2 个
时长规则：操作反馈 ≤ 200ms / 状态切换 ≤ 350ms / 页面过渡 ≤ 500ms
禁止无限循环动效（除状态指示点 pulse 外）
禁止 bounce / elastic / spring（工具/数据场景）；Landing Page 可适量使用
```

---

## 二、Transition 基础规则

```css
/* ── 标准时长表 ── */
:root {
  --dur-instant:  80ms;   /* hover 颜色变化 */
  --dur-fast:     150ms;  /* 按钮状态切换、Badge、Tag */
  --dur-normal:   250ms;  /* 卡片 hover elevation、Drawer 展开 */
  --dur-slow:     350ms;  /* Modal、Sidebar 折叠 / 展开 */
  --dur-page:     500ms;  /* 页面级切换、Tab 内容切换 */

  /* 缓动函数 */
  --ease-std:     cubic-bezier(0.4, 0, 0.2, 1);   /* 标准（进出均平滑）*/
  --ease-decel:   cubic-bezier(0, 0, 0.2, 1);     /* 减速（元素进入屏幕）*/
  --ease-accel:   cubic-bezier(0.4, 0, 1, 1);     /* 加速（元素离开屏幕）*/
  --ease-sharp:   cubic-bezier(0.4, 0, 0.6, 1);   /* 尖锐（工具类操作）*/
}
```

### 通用 Transition 声明

```css
/* 卡片 hover */
.card { transition: box-shadow var(--dur-normal) var(--ease-std),
                    border-color var(--dur-fast) var(--ease-std); }

/* 按钮 */
.btn  { transition: background var(--dur-fast) var(--ease-std),
                    color var(--dur-fast) var(--ease-std),
                    transform var(--dur-fast) var(--ease-std); }
.btn:active { transform: scale(0.97); }  /* 点击下压感 */

/* 链接、导航项 */
.nav-item { transition: background var(--dur-instant) var(--ease-std),
                         color var(--dur-instant) var(--ease-std); }

/* Bento 卡片上浮（主题 E 专用）*/
.bento-card { transition: transform var(--dur-normal) var(--ease-decel),
                            box-shadow var(--dur-normal) var(--ease-decel); }
.bento-card:hover { transform: translateY(-3px); }
```

---

## 三、Micro-interaction（微交互）

### 状态切换动效

```css
/* Tab 切换：active 指示线滑动 */
.tabs { position: relative; }
.tab-indicator {
  position: absolute; bottom: 0; height: 2px;
  background: var(--color-primary);
  transition: left var(--dur-normal) var(--ease-std),
              width var(--dur-normal) var(--ease-std);
}

/* Checkbox / Toggle 切换 */
.toggle {
  transition: background var(--dur-fast) var(--ease-std);
}
.toggle-thumb {
  transition: transform var(--dur-fast) var(--ease-std);
}

/* Sidebar 折叠/展开 */
.sidebar {
  transition: width var(--dur-slow) var(--ease-std),
              transform var(--dur-slow) var(--ease-std);
  overflow: hidden;
}
.sidebar.collapsed { width: 56px; }  /* icon-only 模式 */

/* Dropdown 展开 */
.dropdown-menu {
  transform-origin: top center;
  animation: dropdown-in var(--dur-normal) var(--ease-decel) both;
}
@keyframes dropdown-in {
  from { opacity: 0; transform: scaleY(0.92) translateY(-4px); }
  to   { opacity: 1; transform: scaleY(1)    translateY(0); }
}

/* Modal 进入 */
.modal-overlay {
  animation: fade-in var(--dur-normal) var(--ease-std) both;
}
.modal-content {
  animation: modal-in var(--dur-slow) var(--ease-decel) both;
}
@keyframes fade-in {
  from { opacity: 0; } to { opacity: 1; }
}
@keyframes modal-in {
  from { opacity: 0; transform: translateY(16px) scale(0.97); }
  to   { opacity: 1; transform: translateY(0)    scale(1); }
}
```

### 数据刷新动效

```css
/* 刷新旋转图标 */
.refresh-btn.loading .icon {
  animation: spin var(--dur-page) linear infinite;
}
@keyframes spin {
  from { transform: rotate(0deg); }
  to   { transform: rotate(360deg); }
}

/* 数字变化（Counter 动效，纯 CSS 无法实现，使用 JS）*/
/* 见下方 §数字递增动效 JS */

/* Skeleton 加载态 */
.skeleton {
  background: linear-gradient(90deg,
    var(--color-bg-subtle) 25%,
    rgba(255,255,255,0.6) 50%,
    var(--color-bg-subtle) 75%
  );
  background-size: 400% 100%;
  animation: skeleton-shimmer 1.5s ease-in-out infinite;
  border-radius: 4px;
}
@keyframes skeleton-shimmer {
  0%   { background-position: 100% 0; }
  100% { background-position: -100% 0; }
}
```

### 数字递增动效（KPI 数字加载时）

```javascript
/**
 * 数字递增动效 — 用于 KPI 数字首次加载
 * @param {string} id - 元素 ID
 * @param {number} target - 目标值
 * @param {number} duration - 动画时长 ms（建议 800-1200）
 * @param {string} prefix - 前缀（如 '¥'）
 * @param {string} suffix - 后缀（如 '亿', '%'）
 */
function countUp(id, target, duration = 1000, prefix = '', suffix = '') {
  const el = document.getElementById(id);
  if (!el) return;
  const start = performance.now();
  const isFloat = !Number.isInteger(target);
  const decimals = isFloat ? (String(target).split('.')[1] || '').length : 0;
  function update(now) {
    const elapsed = now - start;
    const progress = Math.min(elapsed / duration, 1);
    // ease-out cubic
    const eased = 1 - Math.pow(1 - progress, 3);
    const current = eased * target;
    el.textContent = prefix + current.toFixed(decimals).replace(/\B(?=(\d{3})+(?!\d))/g, ',') + suffix;
    if (progress < 1) requestAnimationFrame(update);
  }
  requestAnimationFrame(update);
}
// 用法：countUp('kpi-gmv', 12831712, 1000, '', '');
// 用法：countUp('kpi-rate', 48.2, 800, '', '%');
```

---

## 四、图标体系

### 推荐图标库（按场景选择）

| 库名 | 特点 | 适用主题 | CDN 引入 |
|------|------|---------|---------|
| **Lucide Icons** | 简洁线性，24x24，SVG sprite | A/D/E（通用）| `lucide.dev` |
| **Heroicons** | Tailwind 官方，outline + solid 两套 | A/D（工具/内容）| `heroicons.com` |
| **Phosphor Icons** | 6 种粗细，中性优雅 | B/C（深色/编辑）| `phosphoricons.com` |
| **Tabler Icons** | 4500+ 图标，细线风格 | D（极简）| `tabler.io/icons` |

### 图标引入方式（推荐：SVG Sprite 或 CDN）

```html
<!-- 方案 A：Lucide CDN（推荐，按需加载）-->
<script src="https://unpkg.com/lucide@latest/dist/umd/lucide.min.js"></script>
<script>lucide.createIcons();</script>

<!-- 使用方式（任意位置）-->
<i data-lucide="trending-up" class="icon"></i>
<i data-lucide="refresh-cw" class="icon spinning"></i>
<i data-lucide="chevron-down" class="icon"></i>

<!-- 方案 B：内联 SVG（零依赖，适合性能敏感场景）-->
<svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor"
     stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
  <polyline points="23 6 13.5 15.5 8.5 10.5 1 18"></polyline>
  <polyline points="17 6 23 6 23 12"></polyline>
</svg>
```

```css
/* 图标基础样式 */
.icon {
  display: inline-block;
  width: 16px; height: 16px;
  vertical-align: middle;
  flex-shrink: 0;
  color: currentColor;  /* 继承文字颜色 */
}
.icon-sm { width: 14px; height: 14px; }
.icon-md { width: 20px; height: 20px; }
.icon-lg { width: 24px; height: 24px; }
.icon-xl { width: 32px; height: 32px; }
```

### 数据平台常用图标速查（Lucide 名称）

| 功能 | Lucide 图标名 |
|------|-------------|
| 刷新数据 | `refresh-cw` |
| 下载/导出 | `download` |
| 筛选 | `filter` |
| 日期选择 | `calendar` |
| 搜索 | `search` |
| 设置 | `settings` |
| 更多操作 | `more-horizontal` |
| 折叠/展开行 | `chevron-right` / `chevron-down` |
| 上升趋势 | `trending-up` |
| 下降趋势 | `trending-down` |
| 信息提示 | `info` |
| 告警 | `alert-triangle` |
| 用户 | `user` |
| 主页 | `home` |
| 图表 | `bar-chart-2` |
| 数据表 | `table` |
| 锁定 | `lock` |
| 分享 | `share-2` |
| 全屏 | `maximize-2` |
| 拖拽排序 | `grip-vertical` |

---

## 五、数据场景图标规范（data-report / dashboard 专属）

```css
/* 图标与文字对齐（内联场景）*/
.label-with-icon {
  display: inline-flex;
  align-items: center;
  gap: 6px;
  font-size: 13px;
  color: var(--color-text-secondary);
}
.label-with-icon .icon { color: var(--color-text-secondary); }

/* 指标说明 tooltip 触发图标 */
.metric-info-icon {
  width: 14px; height: 14px;
  color: #9CA3AF;
  cursor: help;
  transition: color var(--dur-instant);
}
.metric-info-icon:hover { color: var(--color-primary); }

/* 卡片右上角操作图标（...更多）*/
.card-actions {
  position: absolute; top: 16px; right: 16px;
  display: flex; gap: 8px; align-items: center;
  opacity: 0; transition: opacity var(--dur-fast);
}
.card:hover .card-actions { opacity: 1; }
.card-action-btn {
  width: 24px; height: 24px;
  display: flex; align-items: center; justify-content: center;
  border-radius: 4px; cursor: pointer; color: #9CA3AF;
  transition: background var(--dur-instant), color var(--dur-instant);
}
.card-action-btn:hover { background: #F3F4F6; color: #374151; }
```

---

## 六、禁止项

```
❌ 禁止使用 Emoji 作为功能图标（❌✅⚠️📊 等）
❌ 禁止在数据/工具场景使用彩色图标（图标颜色应继承文字色）
❌ 禁止在图标上叠加装饰阴影（glow 效果）
❌ 禁止无限旋转图标（除 loading 状态外）
❌ 禁止用不同图标库混搭（统一选一套）
❌ 禁止图标与文字垂直不对齐（必须 align-items: center + gap）

✅ 图标颜色应语义化：
   - 操作图标：inherit（继承文字色）
   - 正向指标旁：--semantic-positive（绿）
   - 负向指标旁：--semantic-negative（红）
   - 警告提示旁：--color-warning（橙）
   - 信息说明旁：--color-text-secondary（灰）
```
