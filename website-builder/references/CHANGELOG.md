# CHANGELOG.md

## v1.0.0 — 2026-06-25

### 🎉 初始版本：website-builder（合并发布）

**本版本由 `web-site-beautifier` + `data-app-builder` 融合而来，新增 phases 工程流水线层。**

---

### 融合内容

**来自 web-site-beautifier（设计域，设计版本继承）**
- `design/scenes/`：5 大场景规范（landing-page / data-report / dashboard / tool-app / content-doc）
- `design/themes/`：A-F 6 套主题（A 企业亮色数平蓝 #2563F4 / B 深色专业 / C 编辑排版 / D 极简轻量 / E 卡片网格 / F 深色霓虹）
- `design/core/`：设计原则（design-tokens / anti-patterns 20条 / three-layer-spec / brand-token-derivation / responsive-spec / accessibility / motion-icons）
- `design/data-components/`：数据组件规范（kpi-card / echarts-config / table-spec / semantic-colors / site-chrome）

**来自 data-app-builder（工程域）**
- `engineering/scripts/`：6 个 bash 脚本（setup-node / init-site / install-and-start / build / publish-git / deploy）
- `engineering/api-spec.md`：3 个内置接口（CK SQL / 看板 Widget / 沙箱文件）
- `references/mobile-adaptation.md`：移动端适配规范

---

### 新增内容

**phases/ — 工程执行流水线（6 个文件）**
- `phase0-requirement.md`：需求澄清（站点名/场景/主题/数据来源 4 个维度）
- `phase1-scaffold.md`：工程脚手架（clone/install/dev-server）
- `phase2-design-inject.md`：设计系统注入（theme.css + Tailwind 配置生成）
- `phase3-codegen.md`：代码生成规范（Vue 架构约束 + 接口选型）
- `phase4-ui-qa.md`：UI 质量门控（P0 规则 + 场景 + 主题三层检查）
- `phase5-deploy.md`：构建发布（build/git/deploy 三步）
- `phase-patch.md`：局部修改流程（主题替换/组件局部/功能新增/接口调整）

**references/ — 共享参考**
- `tailwind-bridge.md`：6 套主题 → Tailwind theme.extend 完整转换表 + Headless UI 示例
- `component-protocol.md`：组件沉淀协议草案（三层体系/元数据格式/搜索协议/待信红林补充）

**deploy/ — 部署域（待骆潇龙补充完善）**
- `build-spec.md`：rsbuild 构建配置
- `release-flow.md`：发布流程（监控/回滚待补充）

---

### 架构设计原则

- **三域职责分离**：设计域（`design/`）/ 工程域（`engineering/`）/ 部署域（`deploy/`）各职能独立迭代
- **Phase 流水线**：Phase 0-5 线性流程 + phase-patch 并行修改流程
- **渐进式加载**：Tier 0-4 按需加载，避免上下文爆炸
- **Token 双轨**：CSS 自定义属性（`:root`）+ Tailwind `theme.extend` 同步注入，兼容两种工程方案
- **局部修改隔离**：phase-patch 明确最小修改范围，防止局部改动破坏整体
