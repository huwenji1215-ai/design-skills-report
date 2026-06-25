# core/accessibility.md — 可访问性与无障碍规范

> **本文件包含**：颜色对比度 / ARIA 语义 / 键盘导航 / 焦点管理 / 色盲友好  
> **加载时机（Tier 3）**：执行可访问性审查或需要无障碍合规时按需加载  
> **目标标准**：WCAG 2.1 AA 级（大多数商业场景的最低要求）

---

## 一、颜色对比度（最高频失误）

### 对比度最低要求

| 文字类型 | WCAG AA | WCAG AAA |
|---------|---------|---------|
| 正文（< 18px 常规 / < 14px 加粗）| 4.5:1 | 7:1 |
| 大文字（≥ 18px 常规 / ≥ 14px 加粗）| 3:1 | 4.5:1 |
| UI 组件（输入框边框、图标）| 3:1 | — |
| 纯装饰（无信息内容）| 无要求 | — |

### 各主题常用颜色对比度验证

```
主题 A（企业亮色）白底：
  文字 #1D2129 / 白底  → 18.7:1  ✅
  文字 #4E5969 / 白底  → 7.1:1   ✅
  文字 #86909C / 白底  → 3.9:1   ⚠️（仅用于辅助文字，字号需 ≥ 14px）
  文字 #C9CDD4 / 白底  → 1.7:1   ❌ 禁止用作正文
  品牌蓝 #165DFF / 白底 → 5.5:1  ✅

主题 F（深色霓虹）#060C1A底：
  文字 #E2EAF8 / #060C1A → 16.8:1 ✅
  文字 #8BA3C7 / #060C1A → 7.2:1  ✅
  文字 #4A6080 / #060C1A → 3.4:1  ⚠️（仅小字辅助信息）
  cyan #00D4FF / #060C1A → 11.2:1 ✅

❌ 高频失误：
  #9CA3AF（灰）/ #FFFFFF（白）→ 2.85:1  不达标（常见于 placeholder、label）
  #A1A7B3 / #F3F4F6          → 2.4:1   不达标
```

### 快速修复

```css
/* ❌ 常见低对比度问题及修复 */

/* placeholder 文字 */
input::placeholder {
  color: #9CA3AF;    /* ❌ 2.85:1 */
  color: #6B7280;    /* ✅ 4.6:1 */
}

/* 次要信息标签 */
.label {
  color: #9CA3AF;    /* ❌ */
  color: #71717A;    /* ✅ 4.6:1 */
}

/* Badge on light bg */
.badge {
  background: #F0F4FF;
  color: #4B72E5;    /* ✅ 5.1:1 on #F0F4FF */
}
```

---

## 二、ARIA 语义（让屏幕阅读器理解页面）

### 关键 ARIA 属性

```html
<!-- 1. 页面主要区域语义化 -->
<header role="banner">        <!-- 页眉 -->
<nav role="navigation">       <!-- 导航 -->
<main role="main">            <!-- 主内容区（每页仅一个）-->
<aside role="complementary">  <!-- 侧边栏 -->
<footer role="contentinfo">   <!-- 页脚 -->

<!-- 2. 交互组件 -->
<button type="button" aria-label="刷新数据">  <!-- 无文字的图标按钮必须有 aria-label -->
  <i data-lucide="refresh-cw"></i>
</button>

<button aria-expanded="false" aria-controls="sidebar" id="sidebar-toggle">
  折叠侧边栏
</button>
<aside id="sidebar" aria-labelledby="sidebar-toggle">...</aside>

<!-- 3. Tab 组件 -->
<div role="tablist" aria-label="数据视角">
  <button role="tab" aria-selected="true"  id="tab-1" aria-controls="panel-1">GMV</button>
  <button role="tab" aria-selected="false" id="tab-2" aria-controls="panel-2">订单</button>
</div>
<div role="tabpanel" id="panel-1" aria-labelledby="tab-1">...</div>

<!-- 4. 状态变化 -->
<div aria-live="polite" aria-atomic="true" id="status-msg">
  <!-- 动态内容变化（刷新、加载完成等）注入到这里，屏幕阅读器会朗读 -->
</div>

<!-- 5. 图表/图形的文字替代 -->
<div id="chart-main" role="img" aria-label="近一周 GMV 趋势：周一 12亿，持续增长至周日 18亿">
  <!-- ECharts canvas -->
</div>

<!-- 6. 数据表格 -->
<table>
  <caption>近7天GMV日报数据</caption>
  <thead>
    <tr>
      <th scope="col">日期</th>
      <th scope="col">GMV（亿元）</th>
      <th scope="col">环比变化</th>
    </tr>
  </thead>
</table>

<!-- 7. 加载状态 -->
<div aria-busy="true" aria-label="正在加载数据...">
  <div class="skeleton">...</div>
</div>
```

---

## 三、键盘导航（必须 100% 可用键盘操作）

```css
/* 焦点样式（禁止 outline:none 除非提供替代方案）*/

/* ❌ 绝对禁止 */
:focus { outline: none; }
button:focus { outline: none; }

/* ✅ 正确：保留并美化 focus ring */
:focus-visible {
  outline: 2px solid var(--color-primary);
  outline-offset: 2px;
  border-radius: 4px;
}

/* 仅鼠标点击时不显示（键盘 Tab 时仍显示）*/
:focus:not(:focus-visible) {
  outline: none;
}
```

```javascript
// Tab 顺序应与视觉顺序一致
// 使用 tabindex="0" 使非交互元素可聚焦
// 使用 tabindex="-1" 使元素可编程聚焦但不在 Tab 序列中

// Modal 打开时：焦点锁定在 Modal 内部
function trapFocus(modalEl) {
  const focusable = modalEl.querySelectorAll(
    'button, [href], input, select, textarea, [tabindex]:not([tabindex="-1"])'
  );
  const first = focusable[0];
  const last = focusable[focusable.length - 1];
  
  modalEl.addEventListener('keydown', (e) => {
    if (e.key !== 'Tab') return;
    if (e.shiftKey) {
      if (document.activeElement === first) { e.preventDefault(); last.focus(); }
    } else {
      if (document.activeElement === last) { e.preventDefault(); first.focus(); }
    }
  });
  first.focus(); // 打开时自动聚焦第一个元素
}

// Modal 关闭时：焦点还原到触发按钮
function closeModal(triggerBtn) {
  modal.close();
  triggerBtn.focus(); // 还原焦点
}

// Dropdown/菜单：支持方向键导航
// 下拉菜单 + ArrowDown/ArrowUp 移动焦点
// Enter/Space 选中
// Escape 关闭
```

---

## 四、色盲友好设计

> 约 8% 男性有色觉缺陷（主要是红绿色盲），不能单靠颜色传递信息。

```
❌ 只用颜色区分（色盲用户无法分辨）:
  绿色 badge = 成功
  红色 badge = 失败

✅ 颜色 + 图标/形状/文字 双重传递:
  ✓ 成功（绿色 + 对勾图标）
  ✗ 失败（红色 + 叉号图标）

❌ 图表中 红色/绿色 两条折线（红绿色盲无法区分）:
  Line 1: color: #00B96B（绿）
  Line 2: color: #E8432D（红）

✅ 图表 + 不同线形 + 图例文字:
  Line 1: color: #3B82F6（蓝）, lineStyle: { type: 'solid' }
  Line 2: color: #F59E0B（橙）, lineStyle: { type: 'dashed' }
```

```css
/* delta 涨跌：颜色 + 箭头图标（双重编码）*/
.delta.up::before {
  content: '';
  display: inline-block;
  width: 0; height: 0;
  border-left: 4px solid transparent;
  border-right: 4px solid transparent;
  border-bottom: 6px solid currentColor;
  margin-right: 3px;
}
.delta.down::before {
  border-top: 6px solid currentColor;
  border-bottom: none;
}
/* 即使无法区分红绿颜色，箭头方向也能明确传递涨跌信息 */
```

---

## 五、动效与可访问性

```css
/* 尊重用户系统的"减少动态效果"设置 */
@media (prefers-reduced-motion: reduce) {
  /* 禁用所有动画 */
  *, *::before, *::after {
    animation-duration: 0.01ms !important;
    animation-iteration-count: 1 !important;
    transition-duration: 0.01ms !important;
  }
  
  /* 保留状态过渡，但极短 */
  .btn, .card, .nav-item {
    transition: none;
  }
}
```

---

## 六、深色模式自动适配

```css
/* 支持系统级深色模式切换 */
@media (prefers-color-scheme: dark) {
  /* 如果页面有亮/暗双模式 */
  :root {
    --color-bg-page: #1A1A2E;
    --color-text-primary: #E2E8F0;
    --color-border: rgba(255,255,255,0.12);
  }
}

/* 如果页面不打算支持深色模式：在 <head> 中声明 */
/* <meta name="color-scheme" content="light"> */
```

---

## 七、语言与文字方向

```html
<!-- 页面必须声明语言 -->
<html lang="zh-CN">  <!-- 中文 -->
<html lang="en">     <!-- 英文 -->
<html lang="zh-TW">  <!-- 繁中 -->

<!-- 双语混排时 -->
<h1 lang="en">DataAgent</h1>
<p lang="zh-CN">快手数据智能平台</p>
```

---

## 八、可访问性 Self-Check

```
颜色对比度：
[ ] 所有正文文字对比度 ≥ 4.5:1（白底 ≥ #595959）
[ ] 所有大文字（≥18px）对比度 ≥ 3:1
[ ] UI 组件（输入框边框、图标）对比度 ≥ 3:1
[ ] 深色主题下 #8BA3C7 等辅助字色对比度已验证

ARIA：
[ ] 图标按钮有 aria-label（无文字内容时）
[ ] 数据图表有 role="img" + aria-label（描述关键数据结论）
[ ] Tab 组件有 role="tablist" + aria-selected
[ ] Modal 有 aria-modal="true" + 焦点锁定
[ ] 动态数据区有 aria-live="polite"

键盘：
[ ] 所有交互元素可用 Tab 键访问
[ ] 有 :focus-visible 样式（不是 outline:none）
[ ] Modal 打开后焦点在弹窗内，关闭后还原
[ ] Dropdown 支持键盘上下键 + Escape 关闭

色盲友好：
[ ] 涨跌数据用颜色 + 图标双重表达
[ ] 图表多系列不只用红绿区分，有不同线形或标记形状
[ ] 状态 Badge 有图标辅助（不只靠颜色）

其他：
[ ] <html lang="xx"> 已声明
[ ] 数据表格有 <caption> 或 aria-label
[ ] 图片有 alt 文字（装饰性图片用 alt=""）
[ ] @media (prefers-reduced-motion) 下动画已禁用
```
