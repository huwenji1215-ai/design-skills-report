# engineering/code-standards.md — Vue 组件代码规范

> 前端代码生成的基准标准。所有 Phase 3 生成的代码必须符合本规范。

---

## 组件结构模板

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
// 导入顺序：1. Vue 核心 → 2. 路由 → 3. 业务 composables → 4. 接口
import { ref, computed, watch, onMounted } from 'vue';
import { useRouter, useRoute } from 'vue-router';
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
/* 所有颜色/间距/圆角/阴影使用 Token 变量，禁止硬编码 */
.page {
  background: var(--color-bg-page);
  padding: var(--space-5);
}
.state-loading {
  color: var(--color-text-muted);
  padding: var(--space-7) 0;
  text-align: center;
}
.state-error {
  color: var(--color-negative);
  padding: var(--space-5);
}
</style>
```

---

## 强制规范

### 禁止在组件内直接 fetch

```typescript
// ❌ 错误：组件内裸 fetch
const res = await fetch('/api/v1/data');

// ✅ 正确：从 api.ts 导入
import { getSomeData } from '@/services/api';
const data = await getSomeData();
```

### 禁止硬编码色值

```css
/* ❌ 错误 */
.card { background: #FFFFFF; color: #2563F4; }

/* ✅ 正确 */
.card { background: var(--color-bg-card); color: var(--color-primary); }
```

### 路由懒加载

```typescript
// ✅ 正确：路由懒加载（除首页外）
const routes = [
  { path: '/', component: HomePage },  // 首页可直接引入
  { path: '/dashboard', component: () => import('@/pages/DashboardPage.vue') },
  { path: '/report', component: () => import('@/pages/ReportPage.vue') },
];
```

### App.vue 规范

```vue
<!-- App.vue：只做身份门控和 RouterView，不写任何业务 -->
<template>
  <RouterView v-if="authed" />
  <div v-else class="auth-loading">验证中…</div>
</template>

<script setup lang="ts">
import { useAuth } from '@/services/auth';
const { authed } = useAuth();
</script>

<style>
/* 全局样式（不加 scoped）—— 引入 Token，设置基础 body 样式 */
@import '@/assets/theme.css';
* { box-sizing: border-box; }
body {
  margin: 0;
  font-family: -apple-system, 'PingFang SC', sans-serif;
  font-size: var(--font-size-base);
  color: var(--color-text-primary);
  background: var(--color-bg-page);
}
</style>
```

---

## ECharts 容器规范

```vue
<template>
  <!-- ✅ 正确：flex 容器，高度自适应 -->
  <div class="chart-wrapper">
    <div ref="chartEl" class="chart-container" />
  </div>
</template>

<style scoped>
.chart-wrapper {
  display: flex;
  flex-direction: column;
  height: 300px;  /* 在父容器上设置高度 */
}
.chart-container {
  flex: 1;
  min-height: 0;  /* ← 关键！否则 flex 子元素不会收缩 */
}
</style>
```

```typescript
// ECharts 初始化
import * as echarts from 'echarts';
const chartEl = ref<HTMLElement>();
let chart: echarts.ECharts;

onMounted(() => {
  chart = echarts.init(chartEl.value!);
  // 使用 design/data-components/echarts-config.md 中的标准配置
});

onUnmounted(() => chart?.dispose());
```

---

## CSS 权重管理

| 层级 | 用法 | 文件 |
|------|------|------|
| 全局重置 + Token 引入 | `<style>`（无 scoped）| App.vue 唯一处 |
| 页面/组件样式 | `<style scoped>` | 所有其他组件 |
| 禁止 | `!important` / 内联 `style=""` 写色值 | — |
