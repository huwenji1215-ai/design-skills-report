# phases/phase-patch.md — 局部修改流程

> **加载时机**：站点已建成，用户要求修改某个**具体细节**时。  
> **核心原则**：**最小范围修改**——用户改颜色就只动 Token，改组件就只动该组件的 scoped 样式，绝不因为局部修改而重写整个页面。

---

## 修改类型识别

```
用户说了什么？
│
├─ "把颜色改成 XX" / "换个主题" / "改成暗色" / "主色换成 #XXXXXX"
│   → 类型：主题替换（Theme Switch）
│
├─ "把这个卡片/图表/按钮/标签 改一下"
│   → 类型：组件局部调整（Component Patch）
│
├─ "加一个页面" / "加一个图表" / "加筛选器"
│   → 类型：功能新增（Feature Add）→ 走完整 Phase 3 流程（新增，不修改现有）
│
├─ "页面布局调整" / "重新排列模块"
│   → 类型：结构调整（Layout Change）→ 需确认范围，谨慎修改
│
└─ "改一下 XX 数据来源 / 换个接口"
    → 类型：数据接口调整（API Patch）→ 只改 api.ts 和对应组件的调用处
```

---

## 主题替换（Theme Switch）

**规则：只动 `web/src/assets/theme.css`，不动任何 `.vue` 文件。**

```
1. 加载目标主题文件（design/themes/{theme}.md）
2. 获取新主题的 Token 值
3. 覆盖写入 web/src/assets/theme.css 的 :root 变量
4. 如用 Tailwind，同步更新 tailwind.config.js 的 theme.extend
5. 验证：刷新预览，确认变化符合预期
```

品牌自定义时：
```
1. 加载 design/core/brand-token-derivation.md
2. 执行品牌色推导
3. 按推导结果写入 theme.css
```

**禁止**：为了换主题而修改组件内的 `style` 属性或 `class` 硬编码。

---

## 组件局部调整（Component Patch）

**规则：只修改该组件文件的 `<style scoped>` 或 `<template>` 中指定的部分，不动其他组件。**

执行步骤：
```
1. 确认目标组件文件路径（src/components/XxxComponent.vue 或 src/pages/XxxPage.vue）
2. 阅读该组件现有代码，理解当前实现
3. 仅修改用户指定的内容（颜色/圆角/间距/字号/布局）
4. 修改后在同文件的 <style scoped> 中更新对应规则
5. 如涉及 Token 变量（var(--xxx)），确认使用正确的变量名
6. 不改其他组件
```

**常见场景：**

| 用户要求 | 操作范围 |
|---------|---------|
| "卡片圆角太大了" | 该卡片组件 `<style scoped>` 中 `border-radius` |
| "这个按钮颜色不对" | 该按钮组件中 `background-color` 或 `color` |
| "图表太高了" | ECharts 容器 `height` / `min-height` |
| "标题字太小" | 对应文字的 `font-size` |
| "卡片间距太大" | 父级容器 `gap` 或 `padding` |

---

## 功能新增（Feature Add）

不修改现有组件，新增功能按完整 Phase 3 流程执行：
1. 新增页面 → `src/pages/NewPage.vue`
2. 新增组件 → `src/components/NewComponent.vue`
3. 新增接口 → `src/services/api.ts` 末尾追加
4. 新增路由 → `src/router/index.ts` 追加（懒加载）

---

## 数据接口调整（API Patch）

```
1. 只修改 src/services/api.ts 中对应函数
2. 只修改调用该接口的组件中的调用参数
3. 不修改组件的样式层
```

---

## 禁止行为

```
❌ 因为改一个按钮颜色而重写整个页面
❌ 因为换主题而修改所有组件内的 class 和 style
❌ 在修改 A 组件时顺带"优化"不相关的 B 组件
❌ 用 <style> 全局规则覆盖某个局部效果（必须加 scoped）
❌ 把现有 CSS 变量引用改回硬编码值
```

---

## 修改完成后

执行 Phase 4 的 P0 规则快检（仅检查修改涉及的范围），确认无副作用后告知用户完成。
