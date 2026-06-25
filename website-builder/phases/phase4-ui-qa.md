# phases/phase4-ui-qa.md — UI 质量门控

> **加载时机**：代码生成完成后，交付给用户前必执行。  
> **目标**：通过设计 P0 规则 + 场景专项 + 工程专项三层检查，确保输出质量。

---

## 第一层：P0 规则快检（任何一项违反即返工）

```
通用基础
[ ] 无 Emoji（标题/按钮/标签/正文/图例/Tooltip，全部排查）
[ ] 配色全部使用 var(--color-xxx)，无硬编码色值
[ ] 字号使用 5 级体系（xl/lg/base/sm/xs），无第 6 级
[ ] border-radius ≤ 12px（landing-page 场景可放宽到 16px）
[ ] 非灰彩色 ≤ 3 种（不含语义色 positive/negative/warning）
[ ] 发光效果（glow）仅限 F-dark-neon；其他主题无发光/渐变扩散
[ ] float 布局完全消除（全部 grid / flex）
[ ] font-weight 无 100 / 300（最低 400）
[ ] 正文文字对比度 ≥ 4.5:1（WCAG AA 标准）

数据场景专属（scene = data-report / dashboard 时必查）
[ ] 无彩色顶条 card colored top bar
[ ] KPI 数字字号 ≥ 28px，且是区域内最大字号
[ ] ECharts 容器高度用 flex:1;min-height:0，无固定 px 高度
[ ] 图表多系列色与语义色（绿/红）无颜色混淆
[ ] delta 值用颜色+箭头图标双重编码（色盲友好）

工程专属
[ ] loading / error / empty 三态全部覆盖
[ ] 接口全在 api.ts，无组件内裸 fetch
[ ] CSS 全部 <style scoped>，无全局污染（App.vue 除外）
[ ] 路由懒加载正确（首页除外）
[ ] 沙箱文件场景：SITE_OWNER_USERNAME 已写死建站人
```

---

## 第二层：场景专项 Self-Check

加载当前场景文件末尾的 Self-Check 列表：

```
scene = landing-page  → design/scenes/landing-page.md § Self-Check
scene = data-report   → design/scenes/data-report.md § Self-Check
scene = dashboard     → design/scenes/dashboard.md § Self-Check
scene = tool-app      → design/scenes/tool-app.md § Self-Check
scene = content-doc   → design/scenes/content-doc.md § Self-Check
```

---

## 第三层：主题专项 Self-Check

加载当前主题文件末尾的 Self-Check 列表：

```
theme = A → design/themes/A-enterprise-light.md § Self-Check
theme = B → design/themes/B-dark-pro.md § Self-Check
theme = C → design/themes/C-editorial.md § Self-Check
theme = D → design/themes/D-minimal.md § Self-Check
theme = E → design/themes/E-bold-bento.md § Self-Check
theme = F → design/themes/F-dark-neon.md § Self-Check
```

---

## 常见返工原因速查

| 发现问题 | 修复路径 |
|---------|---------|
| 颜色写死 `#2563F4` | 替换为 `var(--color-primary)` |
| ECharts 容器高度 `height: 300px` | 改为 `flex: 1; min-height: 0;` + 父元素 `display: flex` |
| KPI 数字太小（如 18px）| 改为 `font-size: var(--font-size-xl)` + `font-weight: 700` |
| card 顶部有颜色条 | 删除 `border-top: 3px solid var(--color-primary)` |
| 有标题 Emoji | 删除 emoji，保留文字 |
| loading 状态缺失 | 加 `v-if="loading"` 分支，见 phase3-codegen.md 模板 |
| 多列卡片高度不齐 | 父级加 `align-items: stretch` |

---

## Phase 4 完成后

- 所有检查项全部通过 → **等待用户确认是否发布**
- 有检查项未通过 → 返回 Phase 3 修复，不主动进入 Phase 5

> ⚠️ **Phase 5（发布）仅在用户明确说"发布"/"上线"/"deploy" 时才执行，Phase 4 完成不等于自动发布。**
