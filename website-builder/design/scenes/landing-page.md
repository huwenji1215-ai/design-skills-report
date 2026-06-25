# scenes/landing-page.md — Landing Page / 产品官网

> **场景定位**：营销性质的单页或多页站点，目标是「传达价值主张 + 引导用户行动」。  
> 信息结构：叙事驱动（Hook → 展示价值 → 建立信任 → 行动号召）。  
> 典型受众：企业 CTO / 开发者 / 产品经理 / 企业主。  
> **不适用**：内容阅读站（→ content-doc）/ 工具后台（→ tool-app）。
>
> **⚠️ 颜色使用说明**：本文件三层映射的 Tech 层给出的颜色是「默认主题 A 的参考实现」。  
> 当用户有品牌定制需求时，颜色数值替换为品牌 Token（见 `core/brand-token-derivation.md`），  
> 但 User 层感受目标和 Design 层设计原理**保持不变**。

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

> **读法**：User → Design 是原则层（不变），Tech 是参考实现（可随品牌替换）。

### 2.1 视觉一致性

- **[用户感受]**：整个页面非常亮堂，以浅色为主，带一点很淡的品牌色，看起来很理性很严谨，不会觉得在看广告。
- **[设计原理]**：大面积留白 + 浅色区块区分内容组，避免颜色装饰，用确定性视觉语言传递商务可信感。
- **[技术实现（参考 — 主题 A）]**：主背景 `var(--color-bg-card)` = `#FFFFFF`；次级区块 `var(--color-bg-page)` = `#F7F8FA`；边框 `1px solid var(--color-border)`；卡片圆角 `border-radius: 12px`。

### 2.2 色彩系统

- **[用户感受]**：按钮是那种很正的品牌色，没有花里胡哨的渐变，很克制，只有少数地方用了颜色。
- **[设计原理]**：品牌色作为主行动点与高亮色，背景保持中性灰白，颜色的职责是区分语义（哪里可以点，哪里是重要数据），不是装饰。
- **[技术实现（参考 — 主题 A）]**：Primary `var(--color-primary)` = `#2563F4`；辅助色只用 success/danger；Hero 背景可用 `linear-gradient(135deg, var(--color-primary-50), #FFFFFF)`（仅 Hero 区域，透明度控制）。

### 2.3 字体系统

- **[用户感受]**：标题黑黑的粗粗的，正文灰一点，读起来不累，字号大小有明显层次感。
- **[设计原理]**：标准字阶（5 级）+ 严格字重（标题 700，正文 400），字号层级建立视觉扫描路径，正文行距保持高可读性（line-height 1.7-1.8）。
- **[技术实现（参考 — 主题 A）]**：Hero 标题 `font-size: 48px; font-weight: 700; letter-spacing: -0.03em`；Section 标题 `font-size: 32px; font-weight: 700; text-align: center; margin-bottom: 12px`；正文 `font-size: 15px; color: var(--color-text-body); line-height: 1.7`。

### 2.4 组件系统

- **[用户感受]**：东西都装在卡片里，卡片有很细的边框，鼠标放上去会浮起来一点，有种轻轻触碰的反馈感。
- **[设计原理]**：卡片式设计（Card UI），微弱边框（1px）+ 极轻阴影界定内容边界，悬停时增加层深（Elevation），让卡片"活"起来而不显僵硬。
- **[技术实现（参考 — 主题 A）]**：`background: var(--color-bg-card); border: 1px solid var(--color-border); border-radius: 12px; box-shadow: var(--shadow-sm); transition: box-shadow 200ms; hover: box-shadow: var(--shadow-md)`。

### 2.5 图像与装饰

- **[用户感受]**：配图大多是软件截图，或者看起来很高级的玻璃几何图形，背景有非常淡的光晕，不会抢占注意力。
- **[设计原理]**：SaaS 产品截图（UI Mockups）传递实操性，抽象科技插画传递未来感；背景装饰只为营造"品牌调"氛围，透明度严格控制，不能影响文字阅读。
- **[技术实现（参考 — 主题 A）]**：截图 `box-shadow: var(--shadow-lg); border-radius: 12px; overflow: hidden`；装饰 blob：`position:absolute; pointer-events:none; opacity: ≤0.10`，颜色用品牌色的 `radial-gradient`。

### 2.6 栅格与对齐

- **[用户感受]**：排得很整齐，一列一列的，内容再多也不会觉得乱。
- **[设计原理]**：高密度栅格（3~4列），中心定宽容器，卡片等高对齐（grid + stretch），建立整体版面的秩序感。
- **[技术实现（参考 — 主题 A）]**：容器 `max-width: 1200px; margin: 0 auto; padding: 0 24px`；卡片阵列 `display: grid; grid-template-columns: repeat(3, 1fr); gap: 20px; align-items: stretch`。

### 2.7 信息层级

- **[用户感受]**：每一块都有个居中的大标题，下面跟着小字介绍，然后再列出一堆卡片，路径很清晰。
- **[设计原理]**：Section Header（标题 + 副文案）+ Card Grid 的标准区块化结构，标题居中统领，副文案补充语境，卡片承载详情——建立清晰的三层信息扫描路径。
- **[技术实现（参考 — 主题 A）]**：Section 标题 `font-size: 32px; font-weight: 700; text-align: center; margin-bottom: 12px; color: var(--color-text-primary)`；副文案 `font-size: 16px; color: var(--color-text-secondary); text-align: center; max-width: 560px; margin: 0 auto 48px`。

### 2.8 间距体系

- **[用户感受]**：模块之间隔得挺开，内容多但不会觉得挤，有一种透气的感觉。
- **[设计原理]**：较大垂直节奏（Vertical Rhythm）缓解信息密度带来的压迫感，让眼睛有"换气点"，引导用户逐区块消费内容。
- **[技术实现（参考 — 主题 A）]**：区块 `padding: 80px 0`（移动端 `48px 0`）；卡片内部 `padding: 24px`；卡片间距 `gap: 20px`。

---

## 三、模块级规范

> **重要**：以下每个模块中的颜色值是参考实现，  
> 统一替换规则：`blue-600` / `bg-blue-600` → 品牌主色 Token `var(--color-primary)`，  
> `blue-50` / `bg-blue-50` → `var(--color-primary-50)`，依此类推。

### 模块 01：Hero Section

```
布局原则：左右分栏（文字左 / 视觉右），桌面端并排，移动端垂直堆叠
背景原则：品牌色调的极浅渐变（透明度 ≤ 0.10），营造品牌氛围但不喧宾夺主

顶部     可选通栏公告 Banner（增加紧迫感，品牌色背景，白色文字，text-sm，居中，py-2）
左侧     Badge 标签（品牌色浅背景 + 品牌色文字，font-size:12px）
         主标题（display 级，48px+，font-weight:700，letter-spacing:-0.03em）
         副标题（text-secondary，font-size:18-20px，line-height:1.6）
         双按钮（主：品牌色实心 / 次：白底描边品牌色）
右侧     产品截图 / 插画（shadow-lg，rounded-xl，可选轻微浮动动画）
移动端   单列，右侧视觉移至文字下方
```

### 模块 02：Feature Highlights（数字横条）

```
布局原则：4列横向网格，浅灰背景区块区分 Hero，内容节奏感强
         
背景     var(--color-bg-page)（区别于 Hero 的白色背景）
布局     4 列等宽，格之间用 1px 竖分隔线
内容     每格：大数字（28px，700）+ 单位（18px，400）+ 说明文案（13px，text-secondary）
字色     大数字用 var(--color-primary) 或 var(--color-text-primary)（两者皆可，看品牌调性）
```

### 模块 03：Experience Center（体验中心）

```
布局原则：非对称双列（信息密度适中），左侧展示卖点列表，右侧是产品的沉浸式预览

布局     12列网格，左5右7（或左7右5）
左侧     功能列表（2×2），每格：24px 图标 + 标题（16px,600）+ 说明（14px,text-body）
右侧     沉浸式预览卡：品牌色渐变背景（from-primary to-primary-dark），圆角16px，shadow-2xl
         内部可放聊天气泡、输入框模拟等，白色/半透明元素
```

### 模块 04：Core Feature Zone（核心卖点）

```
布局原则：最多3条，左右交替，每条是独立的重量级区块
         
数量     ≤ 3 条（超过3条按优先级裁剪）
布局     奇数条：左图/右文；偶数条：左文/右图（增加节奏变化）
卡片     白底，1px border，轻阴影，圆角12px，padding:32px
强调     左侧可用 4px 品牌色竖线（border-left）做视觉锚点
```

### 模块 05：Product Matrix（产品矩阵）

```
布局原则：Tab 切换 + 卡片阵列，允许展示大量产品但不一次性压垮用户

选项卡   下划线式：active 状态 2px 品牌色底线 + 品牌色文字
卡片网格 grid-cols-3（桌面），gap:16px
卡片内容 24px 图标 + 产品名（16px,600）+ 描述（13px,text-secondary）+ Badge + 链接箭头
hover    border-color 换为品牌色浅色，shadow 轻微加强
Badge    品牌色浅背景（--color-primary-light）+ 品牌色文字，圆角4px
```

### 模块 06：Advantages（优势列表）

```
布局原则：简洁清单式，快速传递竞争力，不需要图片

背景     var(--color-bg-page)
布局     grid-cols-4（桌面），grid-cols-2（移动端）
每列     品牌色小标题（font-weight:600，14px）+ 多个 Check item
Check    SVG 勾号图标（品牌色）+ 文案（13px，text-body）
         勾号不用 Emoji ✓ 而用内联 SVG（保持尺寸精准）
```

### 模块 07：Scenarios & Pricing

```
截图呈现  浏览器外壳包装（顶部圆点 + URL栏）
         shadow-2xl，rounded-xl，overflow:hidden
         外壳颜色：灰色（中性，不喧宾夺主）

定价表   卡片式，3档（免费/基础/企业）
         推荐档：品牌色描边（ring/border，2px）+ 顶部品牌色标签"推荐"
         非推荐档：标准白底灰边框
         价格数字：display 级大号（40px+，700）
```

### 模块 08：Trust Signals（安全与信任）

```
架构图   品牌色极浅背景（--color-primary-50），圆角16px，内边距32px
         图标统一大小（32px），颜色跟随品牌色或中性灰

证书卡   grid-cols-4
         白底，border，shadow-sm，图标+认证名称+发证机构（text-secondary）
         不加颜色（信任感来自整洁，不来自颜色）
```

### 模块 09：Social Proof + Footer CTA

```
Logo 墙  灰度处理（grayscale）+ opacity:0.6
         hover：取消灰度 + opacity:1（transition-all 300ms）
         flex-wrap，gap:32px，居中排列

Footer CTA  品牌主色全宽背景（var(--color-primary)）
            白色标题（36px,700）+ 副文案（white,opacity:0.85）
            白色描边按钮（出现在深色背景时）
```

---

## 四、响应式断点

```css
/* mobile-first，4 档断点 */
/* 480px  — 小手机竖屏 */
/* 768px  — 平板/双列开始 */
/* 1024px — Hero 左右分栏 */
/* 1280px — 容器最大宽度锁定 */

.container { max-width: 1200px; margin: 0 auto; padding: 0 20px; }
@media (min-width: 768px)  { .container { padding: 0 32px; } }
@media (min-width: 1280px) { .container { padding: 0 48px; } }

/* Hero 分栏 */
.hero-grid { display: flex; flex-direction: column; gap: 32px; }
@media (min-width: 1024px) {
  .hero-grid { flex-direction: row; align-items: center; gap: 64px; }
  .hero-text { flex: 1; }
  .hero-visual { flex: 1.2; }
}

/* 卡片网格 */
.card-grid { display: grid; grid-template-columns: 1fr; gap: 16px; }
@media (min-width: 640px)  { .card-grid { grid-template-columns: repeat(2, 1fr); } }
@media (min-width: 1024px) { .card-grid { grid-template-columns: repeat(3, 1fr); gap: 20px; } }
```

---

## 五、Self-Check 补充项（Landing Page 专属）

```
叙事结构：
[ ] Hero 区有明确的一句话价值主张（display 级字号，≥40px）
[ ] 主行动按钮（CTA）在首屏内可见
[ ] 模块顺序遵循叙事节奏（Hero→数字→演示→卖点→矩阵→优势→定价→信任→CTA）
[ ] 至少有一处信任信号（Logo 墙 / 认证 / 数字背书）

颜色与品牌：
[ ] 如有品牌色，已替换 --color-primary 及衍生 Token
[ ] 颜色仅用于行动点（按钮）、高亮标签（Badge）和区块标题，背景保持浅灰白
[ ] 装饰 blob 已设 pointer-events:none，opacity ≤ 0.10

版式：
[ ] 图片（截图/插画）用容器包裹并设圆角 + 阴影（不裸 img）
[ ] Footer CTA 使用品牌色全宽背景
[ ] 同行卡片高度对齐（grid + align-items:stretch）

响应式：
[ ] 移动端单列，视觉素材位于文字下方
[ ] 移动端 Hero 标题 ≤ 32px
[ ] 移动端按钮宽度 ≥ 200px（或全宽）
```
