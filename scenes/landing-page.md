# scenes/landing-page.md — Landing Page / 产品官网

> **场景定位**：营销性质的单页或多页站点，目标是「传达价值主张 + 引导用户行动」。  
> 信息结构：叙事驱动（Hook → 展示价值 → 建立信任 → 行动号召）。  
> 典型受众：企业 CTO / 开发者 / 产品经理 / 企业主。  
> **不适用**：内容阅读站（→ content-doc）/ 工具后台（→ tool-app）。

---

## 一、叙事节奏（Module Flow）

> 模块顺序本身即是说服逻辑，不得随意调换。

```
01. Hero Section         ← Hook：发布新内容 / 一句话价值主张 / 核心视觉
02. Feature Highlights   ← 数据背书：用数字建立可信度（4 个横向指标）
03. Experience Center    ← 交互演示：让用户感受产品而非只看描述
04. Core Feature Zone    ← 核心卖点展开（最多 3 条，每条配视觉）
05. Product Matrix       ← 产品/能力矩阵（Tabs 切换 + 卡片阵列）
06. Advantages           ← 竞争力对比或差异化说明
07. Scenarios & Pricing  ← 场景截图展示 + 定价表
08. Trust Signals        ← 安全认证 / 合规证书 / 架构图
09. Social Proof + CTA   ← 客户 Logo 墙 + 最终转化区
```

---

## 二、视觉规范（三层映射）

### 2.1 视觉一致性

- **[用户感受]**：整个页面非常亮堂，白白的，带一点很淡的蓝色，看起来很理性很严谨。
- **[设计原理]**：大面积留白 + 浅色灰蓝区分区块，避免颜色装饰，确定性视觉语言，商务冷静。
- **[技术实现]**：主背景 `#FFFFFF`；次级区块 `#F7F9FE`；边框 `1px solid #E5E7EB`；`border-radius: 12px`（卡片）。

### 2.2 色彩系统

- **[用户感受]**：按钮是那种很正的品牌蓝，没有花里胡哨的渐变，很克制。
- **[设计原理]**：品牌色作为主行动点与高亮色，背景保持中性，颜色的职责是区分语义，不是装饰。
- **[技术实现]**：Primary `#1677FF`（或主题 A Token `--color-primary`）；辅助色只用 success/danger；Hero 背景可用 `bg-gradient-to-br from-indigo-50 via-white to-blue-50`（仅 Hero 区域）。

### 2.3 字体系统

- **[用户感受]**：标题黑黑的，正文灰一点，读起来不累。
- **[设计原理]**：标准字阶 + 严格字重，标题 semibold，正文保持高可读性，不用细字重。
- **[技术实现]**：Hero 标题 `font-size: 48px; font-weight: 700`；Section 标题 `text-3xl font-bold text-center mb-12`；正文 `text-slate-600 text-sm/base leading-relaxed`。

### 2.4 组件系统

- **[用户感受]**：东西都装在卡片里，卡片有很细的边框，鼠标放上去会浮起来一点。
- **[设计原理]**：卡片式设计（Card UI），微弱边框（1px）+ 极轻阴影界定内容，悬停增加层深（Elevation）。
- **[技术实现]**：`border border-gray-100 shadow-sm hover:shadow-md rounded-xl transition-shadow`。

### 2.5 图像与装饰

- **[用户感受]**：配图大多是软件截图，或者看起来很高级的 3D 玻璃几何图形。
- **[设计原理]**：SaaS 产品截图（UI Mockups）传递实操性，抽象科技插画传递未来感，两者组合。
- **[技术实现]**：截图 `shadow-2xl rounded-lg overflow-hidden`；背景装饰：`soft gradient blobs`（opacity ≤ 0.15，用 absolute/pointer-events-none）。

### 2.6 栅格与对齐

- **[用户感受]**：排得很整齐，一列一列的，像 Excel 表格一样规整。
- **[设计原理]**：高密度栅格，多为 3~4 列布局，中心定宽，适应海量信息展示。
- **[技术实现]**：`container mx-auto max-w-7xl px-6`；卡片阵列 `grid grid-cols-1 md:grid-cols-3 gap-6`。

### 2.7 信息层级

- **[用户感受]**：每一块都有个居中的大标题，下面跟着小字介绍，然后再列出一堆卡片。
- **[设计原理]**：区块化结构（Section Header + Card Grid），标题居中统领，建立清晰的扫描路径。
- **[技术实现]**：Section Header `text-3xl font-bold text-center mb-4` + 副文案 `text-slate-500 text-center mb-12`。

### 2.8 间距体系

- **[用户感受]**：模块之间隔得挺开，内容多但不会觉得挤。
- **[设计原理]**：较大垂直间距（Vertical Rhythm）缓解信息密度带来的压迫感。
- **[技术实现]**：区块 padding `py-20 md:py-24`；卡片内部 `p-6 md:p-8`；卡片间距 `gap-6 md:gap-8`。

---

## 三、模块级规范

### 模块 01：Hero Section

```
布局：   左右分栏（文字左 / 视觉右），cols-2，items-center
背景：   Hero 区域可用 mesh gradient：from-indigo-50 via-white to-blue-50
顶部：   可选通栏公告 Banner（增加紧迫感）：bg-blue-600 text-white text-sm text-center py-2
左侧：   标签（Badge）+ 主标题（display 级）+ 副标题 + 双按钮（主/次）
右侧：   产品截图 / 3D 插画（floating animation 可选）
按钮：   主按钮 bg-blue-600 text-white px-8 py-3 rounded-lg hover:bg-blue-700
        次按钮 border border-gray-200 text-slate-700 px-8 py-3 rounded-lg hover:bg-gray-50
移动端：单列，视觉素材移至文字下方
```

### 模块 02：Feature Highlights（数字横条）

```
布局：   4 列横向（grid-cols-4），bg-slate-50，py-12
内容：   每格：图标/大数字 + 说明文案（text-sm）
分隔：   divide-x divide-gray-200（格之间用竖线分隔）
字号：   大数字 text-2xl font-bold，说明 text-sm text-slate-500
```

### 模块 03：Experience Center（体验中心）

```
布局：   非对称栅格，12 列网格，左 5 右 7
左侧：   功能列表（2×2 网格），每格：图标 + 标题 + 说明文
右侧：   沉浸式预览卡片（如聊天窗口 / 编辑器模拟）
右侧视觉：bg-gradient-to-br from-blue-600 to-blue-500 text-white，rounded-2xl，shadow-2xl
```

### 模块 04：Core Feature Zone（核心卖点）

```
结构：   最多 3 条卖点，每条独立区块
布局：   左右交替（奇数左图右文，偶数左文右图）
卡片：   bg-white border border-gray-100 shadow-sm rounded-2xl p-8
强调项：  左边框 border-l-4 border-blue-600（可选）
```

### 模块 05：Product Matrix（产品矩阵）

```
选项卡：  border-b，active 标签 border-b-2 border-blue-600 font-semibold
卡片网格：grid-cols-3（大屏），gap-4
卡片内容：图标 + 名称（h2）+ 描述（body）+ Badge 标签 + 链接
Badge：   bg-blue-100 text-blue-600 text-xs px-2 py-0.5 rounded-full
hover：   hover:shadow-lg hover:border-blue-200 transition-all
```

### 模块 06：Advantages（优势列表）

```
背景：   bg-slate-50 py-20
布局：   grid-cols-4
每列：   蓝色小标题（text-blue-600 font-semibold）+ 多个 check item
Check：  ✓ 图标（svg）+ 文案（text-sm text-slate-700）
```

### 模块 07：Scenarios & Pricing

```
截图：   浏览器外壳包装（顶部有圆点 + URL 栏），shadow-2xl rounded-xl overflow-hidden
定价表：  卡片式（border，高亮推荐档用 ring-2 ring-blue-600）
交互：   可选 Input/Slider 费用估算器
```

### 模块 08：Trust Signals（安全与信任）

```
架构图：  bg-[#EEF2FF] p-8 rounded-2xl（蓝紫浅色背景）
证书卡：  grid-cols-4，white bg，border，icon + 认证名称 + 发证机构
可选：   glass effect（backdrop-blur-sm bg-white/80）
```

### 模块 09：Social Proof + Footer CTA

```
Logo 墙：  grayscale opacity-60 hover:grayscale-0 hover:opacity-100 transition-all
          flex-wrap gap-8 items-center justify-center
Footer CTA：bg-blue-600 text-white py-20 text-center
           标题 text-3xl font-bold mb-4 + 副文案 + 按钮（白底蓝字 / 描边白色）
```

---

## 四、响应式断点

```css
/* 默认：mobile-first */
/* sm: 640px  — 2 列卡片 */
/* md: 768px  — Hero 分栏 */
/* lg: 1024px — 3-4 列全展开 */
/* xl: 1280px — 最大宽度锁定 */

.hero-grid {
  display: grid;
  grid-template-columns: 1fr;
}
@media (min-width: 768px) {
  .hero-grid { grid-template-columns: 1fr 1fr; align-items: center; }
}
```

---

## 五、Self-Check 补充项（Landing Page 专属）

```
[ ] Hero 区有明确的一句话价值主张（display 级字号）
[ ] 主行动按钮（CTA）在首屏内可见
[ ] 至少有一处信任信号（Logo 墙 / 认证 / 数字背书）
[ ] 图片（截图/插画）不直接放裸 <img>，用容器包裹并设圆角/阴影
[ ] 背景装饰（blob/gradient）已设 pointer-events: none
[ ] Footer CTA 使用全宽色块（bg-blue-600 或等价主题色）
[ ] 响应式：移动端单列，视觉素材位于文字下方
[ ] 模块顺序遵循叙事节奏（Hero → 数字 → 演示 → 卖点 → 矩阵 → 优势 → 定价 → 信任 → CTA）
```
