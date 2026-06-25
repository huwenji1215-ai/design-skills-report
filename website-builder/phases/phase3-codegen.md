# phases/phase3-codegen.md — 代码生成规范

> **加载时机**：Phase 2 完成后；或续开发直接从这里入。  
> **目标**：按架构约定生成 Vue 业务代码，所有样式引用 Phase 2 注入的 Token 变量。

---

## 目录结构（相对 `web/` 的路径）

```
src/
├── index.ts                  # 应用入口：createApp(App).use(router).mount('#app')
├── App.vue                   # 布局外壳：身份门控 + <RouterView>，不写业务
├── router/index.ts           # 路由表，用 createWebHistory(window.__APP_BASE__ || '/')
├── pages/                    # 页面组件（按路由维度划分）
│   └── XxxPage.vue
├── components/               # 可复用 UI 组件（无副作用，props-driven）
│   └── XxxComponent.vue
├── composables/              # 组合式函数（跨组件共享状态 / 封装副作用）
│   └── useXxx.ts
└── services/
    ├── api.ts                # fetch 封装 + 所有接口定义
    └── auth.ts               # SSO 登录校验（勿修改）
```

---

## 强制架构约束

| 约束 | 说明 |
|------|------|
| **App.vue 不写业务** | 只做身份门控和 `<RouterView>` |
| **接口集中在 api.ts** | 禁止在 Vue 组件内直接 `fetch` |
| **路由懒加载** | 除首页外，其余页面用 `() => import('@/pages/XxxPage.vue')` |
| **全局状态用 composable** | 跨组件共享的状态放 `src/composables/` |
| **CSS 用 `<style scoped>`** | 页面/组件样式必须加 scoped |
| **全局样式仅在 App.vue `<style>`** | 不带 scoped 的全局重置放 App.vue |

---

## Vue 组件标准模板

```vue
<!-- 一句话说明组件职责 -->
<template>
  <div v-if="loading" class="state-loading">加载中…</div>
  <div v-else-if="error" class="state-error">{{ error }}</div>
  <div v-else class="page">
    <!-- 正常内容 -->
  </div>
</template>

<script setup lang="ts">
import { ref, onMounted } from 'vue';
import { getSomeData } from '@/services/api';

const loading = ref(false);
const error = ref('');
const data = ref<any>(null);

onMounted(async () => {
  loading.value = true;
  try {
    data.value = await getSomeData();
  } catch (e: any) {
    error.value = e?.message || '加载失败';
  } finally {
    loading.value = false;
  }
});
</script>

<style scoped>
/* 使用 Phase 2 注入的 Token 变量，禁止硬编码色值 */
.page {
  background: var(--color-bg-page);
  padding: var(--space-5);
}
</style>
```

> **重要**：`<style scoped>` 中所有颜色/间距/圆角/阴影必须引用 `var(--xxx)` 变量，禁止直接写 `#2563F4` 等硬编码值（品牌替换时只需改 theme.css 一处）。

---

## 内置数据查询接口（直接可用，无需自建后端）

> 完整接口文档见 `engineering/api-spec.md`，此处仅列接口选择规则。

| 数据来源 | 使用接口 | 关键参数 |
|---------|---------|---------|
| ClickHouse 表名 | `executeSql` | `catalog: 'CLICKHOUSE'`, SQL |
| BI 数据集 sourceId | `executeSql` | `catalog: 'BI_SQL'`, sourceId |
| 看板 widgetId | `queryWidgetData` | `widgetId` |
| 多维分析 shareId | `queryWidgetData` | `shareId` |
| 沙箱文件路径 | `fetchSandboxFile` | `path`（必须以 `/` 开头）|

> ⚠️ **`widgetFiltersQuery` 工具前置调用**：使用 `queryWidgetData` 前应先调 `widgetFiltersQuery` 拿筛选条件。  
> ⚠️ **沙箱文件场景**：`SITE_OWNER_USERNAME` 必须写死建站人，不能从 cookie 取访问者。

---

## 接口扩展方式

在 `src/services/api.ts` 末尾追加，复用内部 `request()` 函数：

```typescript
export function getXxxData(params: { id: number }) {
  return request('/api/v1/xxx/data', { method: 'GET', params });
}
```

新增接口前缀时，在 `rsbuild.config.js` 的 `server.proxy` 追加代理规则：

```javascript
proxy: {
  '/api': proxyWithCookie,
  '/rest/flow': proxyWithCookie,
  '/your/new/prefix': proxyWithCookie,  // 新增
},
```

---

## 数据组件规范（数据场景必读）

数据场景需要用到以下组件，加载对应规范文件：

```
KPI 卡片       → design/data-components/kpi-card.md
ECharts 图表   → design/data-components/echarts-config.md
表格           → design/data-components/table-spec.md
语义色使用规则  → design/data-components/semantic-colors.md
全局站点框架   → design/data-components/site-chrome.md
```

---

## rsbuild.config.js 关键配置

| 配置项 | 作用 | 是否修改 |
|--------|------|---------|
| `COOKIE_FILE` / `RAW_COOKIE` | 本地联调登录态 | 沙箱自动注入，不需改 |
| `PROXY_TARGET` | 代理后端域名 | 按需修改，默认 `rc-tc.corp.kuaishou.com` |
| `PORT` | dev server 端口 | 固定 8888，不改 |
| `BASE_PATH` | 沙箱反代基础路径 | 自动从 `/data_agent/users/.env` 读取 |
| `server.proxy` | 接口代理规则 | 新增接口前缀时追加 |

---

## Phase 3 完成标志

```
[ ] 所有页面已处理 loading / error / empty 三态
[ ] 接口全部在 api.ts，无组件内裸 fetch
[ ] 样式全部使用 var(--xxx)，无色值硬编码
[ ] 路由懒加载配置正确
[ ] 数据组件按规范实现（ECharts 容器用 flex:1；KPI 数字 ≥ 28px）
```

→ **进入 Phase 4（UI 质量门控）**
