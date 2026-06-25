# phases/phase0-requirement.md — 需求澄清

> **加载时机**：新建站点时必读，续开发 / 纯美化时跳过。  
> **目标**：在动任何代码前，锁定 4 个关键参数：`site_name` / `scene` / `theme` / `data_source`

---

## 必须澄清的 4 个维度

### 0-1 站点名（site_name）

> 命名规则（RFC 1123 hostname label，webSiteInit 强制校验）：
> - 只允许小写字母 / 数字 / 连字符 `-`
> - 长度 1-63，不能以连字符开头或结尾
> - 禁止：下划线 `_` / 大写字母 / 中文 / 点 `.`
>
> ✅ `data-agent-intro` / `kpi-dashboard-2025`
> ❌ `data_report`（下划线）/ `KPIDashboard`（大写）/ `数据看板`（中文）

### 0-2 场景（scene）

从以下 5 个中确定唯一值：

```
(1) landing-page    产品官网 / 营销页
(2) data-report     数据日报 / 周报 / 月报
(3) dashboard       数据看板 / Dashboard / 监控大屏
(4) tool-app        工具应用 / 管理系统 / 内部平台
(5) content-doc     内容站 / 文档站 / 知识库
```

### 0-3 主题风格（theme）

**数据场景（data-report / dashboard）**：
- 默认推荐 A — 企业亮色（数平蓝），直接进入 Phase 1
- 用户明确说"暗黑/深色/dark" → F — 深色霓虹

**非数据场景（landing-page / tool-app / content-doc）**：
- 询问用户风格偏好：

```
您希望是哪种视觉风格？
(A) 企业亮色 — 大厂商务风，蓝色系，干净专业
(B) 深色专业 — 暗色背景，高对比，工程感
(C) 编辑排版 — 文字优先，杂志感，衬线字体
(D) 极简轻量 — Notion/Linear 感，白底，细线条
(E) 卡片网格 — Bento 大卡片，强对比，品牌感
(自定义) 我有品牌色，告诉我色号
```

### 0-4 数据来源（data_source）

> 判断是否需要接入数据，决定 Phase 3 的接口选型。

```
是否有数据需要展示？
│
├─ 用户提到 ClickHouse 表名（如 dwd_xxx / ods_xxx）
│   → data_source = CLICKHOUSE，Phase 3 用 executeSql(catalog:'CLICKHOUSE')
│
├─ 用户提到 BI 数据集 / sourceId
│   → data_source = BI_SQL，Phase 3 用 executeSql(catalog:'BI_SQL', sourceId:xxx)
│
├─ 用户提到看板图表 / widgetId / shareId
│   → data_source = WIDGET，Phase 3 用 queryWidgetData
│
├─ 用户提到沙箱文件路径（/data_agent/users/...）
│   → data_source = SANDBOX，Phase 3 用 fetchSandboxFile，userName 写死建站人
│
├─ 需要自定义后端接口
│   → data_source = CUSTOM_API，确认接口前缀和认证方式
│
└─ 纯静态展示，无数据接口
    → data_source = STATIC
```

---

## 澄清完成后输出的参数锁定

```
✅ 已确认参数：
  site_name:   <xxx>
  scene:       <landing-page / data-report / dashboard / tool-app / content-doc>
  theme:       <A / B / C / D / E / F / custom:#XXXXXX>
  data_source: <CLICKHOUSE / BI_SQL / WIDGET / SANDBOX / CUSTOM_API / STATIC>

→ 进入 Phase 1（工程脚手架）
```

> 参数锁定后不再重复询问，后续所有 Phase 直接引用。
