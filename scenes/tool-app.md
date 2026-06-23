# scenes/tool-app.md — 工具型应用 / 内部系统 / B 端后台

> **场景定位**：以操作效率为目标的功能性界面，目标是「快速完成任务，减少认知负担」。  
> 叙事结构：无叙事节奏（工具无叙事），只有操作流：导航 → 内容区 → 操作面板。  
> 典型受众：内部员工 / 运营人员 / 管理员 / 高频使用者。  
> 设计哲学：来自 impeccable 的 **Product Mode**（效率优先，信息密度高，交互明确）。

---

## 一、与 Landing Page 的核心区别

| 维度 | Landing Page（brand mode） | 工具应用（product mode） |
|------|--------------------------|----------------------|
| 目标 | 打动/说服用户 | 帮用户完成任务 |
| 信息密度 | 中等（重视呼吸感） | 高（减少点击路径） |
| 动效 | 可适当丰富（传递活力） | 最小化（避免分心） |
| 颜色用途 | 品牌感知 + 情绪 | 功能区分 + 状态反馈 |
| 字体大小 | 展示性（large hero text） | 实用性（body text 主导） |
| 空白 | 刻意留大（视觉呼吸）| 精确用（不浪费空间） |

---

## 二、视觉规范（三层映射）

### 2.1 整体布局

- **[用户感受]**：左边是导航，右边是内容，和大多数 SaaS 后台一样，很熟悉。
- **[设计原理]**：Sidebar + Main Content 是工具型应用的标准布局，认知成本最低。
- **[技术实现]**：`display:flex`；Sidebar `width: 240px`（紧凑版 `200px`）；Main `flex:1; overflow-y:auto`。

### 2.2 视觉克制

- **[用户感受]**：页面很干净，没有花哨的东西，专注在内容本身。
- **[设计原理]**：工具界面中装饰 = 噪声，用边框和间距区分区域，不用背景色块和渐变。
- **[技术实现]**：底色 `#F5F5F5` 或 `#FAFAFA`；卡片 `#FFFFFF`；边框 `1px solid #E4E4E7`；`border-radius: 6px`。

### 2.3 字体与间距

- **[用户感受]**：字比官网小一点，感觉信息更密，但不拥挤。
- **[设计原理]**：工具界面 body text 主导（14px），标题降级，大量使用 label + value pair 模式。
- **[技术实现]**：页面 body `14px`；表格行高 `40px`；表单 label `12px` uppercase；padding 紧凑 `16px`。

### 2.4 交互反馈

- **[用户感受]**：点了按钮有反应，选中的项会高亮，很清楚我在操作哪里。
- **[设计原理]**：工具界面的核心是「操作确认感」，每个交互都需要清晰的视觉反馈（active/hover/disabled/loading）。
- **[技术实现]**：Nav item active `bg-blue-50 text-blue-600 font-medium`；hover `bg-gray-100`；disabled `opacity-40 cursor-not-allowed`。

---

## 三、页面骨架

```html
<div class="app-layout">
  <!-- Sidebar -->
  <aside class="sidebar">
    <div class="sidebar-logo"><!-- 产品 Logo --></div>
    <nav class="sidebar-nav">
      <a class="nav-item active" href="#">数据概览</a>
      <a class="nav-item" href="#">任务管理</a>
      <a class="nav-item" href="#">设置</a>
    </nav>
    <div class="sidebar-user"><!-- 用户头像 + 名字 --></div>
  </aside>

  <!-- Main -->
  <main class="main-content">
    <!-- Topbar -->
    <div class="topbar">
      <div class="topbar-title">数据概览</div>
      <div class="topbar-actions">
        <button class="btn-secondary">导出</button>
        <button class="btn-primary">新建</button>
      </div>
    </div>

    <!-- Page Content -->
    <div class="page-body">
      <!-- content here -->
    </div>
  </main>
</div>
```

```css
.app-layout      { display: flex; height: 100vh; overflow: hidden; }
.sidebar         { width: 240px; flex-shrink: 0; background: #FFFFFF;
                   border-right: 1px solid #E4E4E7; display: flex; flex-direction: column; }
.sidebar-logo    { padding: 20px 16px 16px; border-bottom: 1px solid #E4E4E7; }
.sidebar-nav     { flex: 1; padding: 8px; overflow-y: auto; }
.nav-item        { display: flex; align-items: center; gap: 8px;
                   padding: 8px 12px; border-radius: 6px;
                   font-size: 14px; color: #374151; text-decoration: none;
                   transition: background 0.1s; cursor: pointer; }
.nav-item:hover  { background: #F3F4F6; }
.nav-item.active { background: #EFF6FF; color: #2563EB; font-weight: 500; }

.main-content    { flex: 1; overflow-y: auto; background: #F9FAFB; }
.topbar          { display: flex; justify-content: space-between; align-items: center;
                   padding: 16px 24px; background: #FFFFFF;
                   border-bottom: 1px solid #E4E4E7; position: sticky; top: 0; z-index: 10; }
.topbar-title    { font-size: 16px; font-weight: 600; color: #111827; }
.page-body       { padding: 24px; }
```

---

## 四、组件规范

### 按钮

```css
.btn-primary   { background: #2563EB; color: #FFF; border: none;
                 padding: 7px 14px; border-radius: 6px; font-size: 13px;
                 font-weight: 500; cursor: pointer; transition: background 0.1s; }
.btn-primary:hover    { background: #1D4ED8; }
.btn-secondary { background: #FFFFFF; color: #374151;
                 border: 1px solid #D1D5DB; padding: 7px 14px;
                 border-radius: 6px; font-size: 13px; cursor: pointer; }
.btn-secondary:hover  { background: #F9FAFB; }
.btn-danger    { background: #EF4444; color: #FFF; /* 删除/危险操作 */ }
```

### 表单元素

```css
.form-label  { font-size: 12px; font-weight: 500; color: #374151;
               text-transform: uppercase; letter-spacing: 0.06em; margin-bottom: 4px; }
.form-input  { width: 100%; padding: 7px 10px; border: 1px solid #D1D5DB;
               border-radius: 6px; font-size: 14px; color: #111827;
               background: #FFF; transition: border-color 0.1s; }
.form-input:focus { outline: none; border-color: #2563EB;
                    box-shadow: 0 0 0 2px rgba(37,99,235,0.15); }
.form-hint   { font-size: 12px; color: #6B7280; margin-top: 4px; }
```

### 数据表格

```css
.data-table  { width: 100%; border-collapse: collapse; }
.data-table th { font-size: 11px; font-weight: 600; color: #6B7280;
                 text-transform: uppercase; letter-spacing: 0.06em;
                 padding: 0 16px 8px; text-align: left; border-bottom: 1px solid #E5E7EB; }
.data-table td { padding: 0 16px; height: 40px; font-size: 14px;
                 color: #374151; border-bottom: 1px solid #F3F4F6; }
.data-table tr:hover td { background: #F9FAFB; }
```

### Badge / Tag

```css
.badge         { display: inline-flex; align-items: center; gap: 4px;
                 padding: 2px 8px; border-radius: 9999px; font-size: 11px; font-weight: 500; }
.badge-blue    { background: #EFF6FF; color: #1D4ED8; }
.badge-green   { background: #F0FDF4; color: #166534; }
.badge-red     { background: #FEF2F2; color: #991B1B; }
.badge-yellow  { background: #FFFBEB; color: #92400E; }
.badge-gray    { background: #F3F4F6; color: #374151; }
```

---

## 五、三旋钮参数（来自 taste-skill VARIANCE/MOTION/DENSITY）

> 工具应用的默认值（可根据具体产品调整）：

```
VARIANCE  = 2/10  （布局稳定，几乎不做实验性排版）
MOTION    = 1/10  （仅必要的状态切换动效，无装饰性动画）
DENSITY   = 7/10  （信息密度高，紧凑 padding，多行列）
```

> 如果产品偏向对外展示（如 SaaS 官方后台 Demo），可以：  
> VARIANCE = 4，MOTION = 3，DENSITY = 5（更接近 Landing Page 风格）

---

## 六、Self-Check 补充项（Tool App 专属）

```
[ ] Sidebar 导航有 active 状态高亮
[ ] Topbar 是 sticky 定位（滚动时不消失）
[ ] 表单 input 有 focus 状态（ring + border-color 变化）
[ ] 按钮有 hover + active + disabled 状态
[ ] 操作性按钮（新建/确认）和危险操作（删除）视觉区分明显
[ ] 表格表头 uppercase，数字列右对齐 + tabular-nums
[ ] 无装饰性渐变背景（page bg 只用 #F9FAFB 或 #F5F5F5）
[ ] 无 Emoji 标签（状态用 Badge，不用图标 Emoji）
[ ] 响应式：移动端 Sidebar 折叠为汉堡菜单
```
