# engineering/api-spec.md — 内置数据查询接口规范

> 用户提到 CK 表 / BI 数据集 / 看板 widgetId 时，**必须使用本文件描述的内置接口**，禁止自建后端。  
> 接口前缀 `/rest/flow` 已在默认代理规则中，Cookie 自动携带，无需手动传认证。

---

## 接口 1：SQL 执行

**`POST /rest/flow/api/v1/sql/execute`**

| 字段 | 类型 | 必填 | 说明 |
|------|------|------|------|
| `catalog` | string | 是 | `CLICKHOUSE` 或 `BI_SQL` |
| `sql` | string | 是 | SQL 语句 |
| `sourceId` | number | catalog=BI_SQL 时必填 | BI 数据集 ID |

返回：`{ code: 0, data: [{ columns: [{columnName, columnTypeName}], dataList: [[...], ...] }] }`

---

## 接口 2：看板图表查询

> ⚠️ **调用前应先调 `widgetFiltersQuery` 工具**获取可用筛选条件（targetId / 时间范围 / 维度筛选等），再构造 filters 参数传入。

**`POST /rest/flow/api/v1/dashboard/widget/data-query`**

| 字段 | 类型 | 必填 | 说明 |
|------|------|------|------|
| `widgetId` | number | 二选一 | 看板图表 ID |
| `shareId` | string | 二选一 | OLAP 多维分析 shareId（优先级高于 widgetId）|
| `filters` | array | 否 | 修改筛选条件，每项 `{targetId, filterValue}` |
| `removedFilterTargetIds` | number[] | 否 | 要移除的筛选条件 targetId 列表 |
| `dynamicDims` | string[] | 否 | 替换动态维度 |
| `removedFieldNames` | string[] | 否 | 移除业务维度（更粗粒度聚合）|
| `calculateType` | string | 否 | `daily_avg`=日均，`summary`=汇总 |
| `timeAggregation` | string | 否 | `day`/`week`/`month`/`quarter`/`year`/`all` |
| `timeCycleParams` | array | 否 | 同环比：`[{showName, granularityType, returnType, type}]` |

返回结构同接口 1。积木表可能返回多项，每项 `description` 为该段标题。

---

## 接口 3：沙箱文件下载

**`GET /rest/flow/api/v1/sandbox/download`**

| 字段 | 类型 | 必填 | 说明 |
|------|------|------|------|
| `path` | string | 是 | 沙箱内文件绝对路径（必须以 `/` 开头，不含 `..`）|
| `userName` | string | 是 | **建站人邮箱前缀**（必须写死，不能从 cookie 取访问者）|

> ⚠️ `userName` 一定要写死建站人，后端若从 cookie 取则会拿到访问者自己的沙箱，导致 404。

返回：二进制流（非 JSON）。404 = 文件不存在，400 = 路径非法。

---

## api.ts 标准封装（复制到 `src/services/api.ts`）

```typescript
// 建站人 userName，沙箱文件读取统一用此，不能换成访问者
const SITE_OWNER_USERNAME = 'YOUR_USERNAME_HERE'; // Phase 0 确认的 userName

/** SQL 执行（ClickHouse / BI 数据集）*/
export function executeSql(params: {
  catalog: 'CLICKHOUSE' | 'BI_SQL';
  sql: string;
  sourceId?: number;
}) {
  return request('/rest/flow/api/v1/sql/execute', {
    method: 'POST',
    body: JSON.stringify(params),
  });
}

/** 看板图表数据查询 */
export function queryWidgetData(params: {
  widgetId?: number;
  shareId?: string;
  filters?: Array<{ targetId: number; filterValue: Record<string, any> }>;
  removedFilterTargetIds?: number[];
  dynamicDims?: string[];
  removedFieldNames?: string[];
  calculateType?: 'daily_avg' | 'summary';
  timeAggregation?: 'day' | 'week' | 'month' | 'quarter' | 'year' | 'all';
  filterConfigId?: number;
  timeCycleParams?: Array<{
    showName?: string;
    granularityType?: string;
    returnType?: 'percent' | 'value';
    type?: 1 | 2;
  }>;
}) {
  return request('/rest/flow/api/v1/dashboard/widget/data-query', {
    method: 'POST',
    body: JSON.stringify(params),
  });
}

/** 将 columns + dataList 转为对象数组 */
export function parseTableData(tableResult: {
  columns: Array<{ columnName: string }>;
  dataList: any[][];
}): Record<string, any>[] {
  const { columns, dataList } = tableResult;
  return dataList.map(row =>
    Object.fromEntries(columns.map((col, i) => [col.columnName, row[i]]))
  );
}

/** 沙箱文件下载链接（给 <a href> / window.open / <img src> 用）*/
export function buildSandboxDownloadUrl(path: string): string {
  const u = encodeURIComponent(SITE_OWNER_USERNAME);
  const p = encodeURIComponent(path);
  return `/rest/flow/api/v1/sandbox/download?userName=${u}&path=${p}`;
}

/** 拉取沙箱文件内容（返回 Response，调用方自行 .text() / .json() / .blob()）*/
export async function fetchSandboxFile(path: string): Promise<Response> {
  const res = await fetch(buildSandboxDownloadUrl(path), { credentials: 'include' });
  if (!res.ok) {
    const msg = await res.text().catch(() => '');
    throw new Error(`沙箱文件下载失败 [${res.status}]: ${msg || res.statusText}`);
  }
  return res;
}
```

---

## 场景速查

| 数据来源 | 使用接口 | 关键参数 |
|---------|---------|---------|
| CK 表名（dwd_xxx / ods_xxx）| `executeSql` | `catalog: 'CLICKHOUSE'` + SQL |
| BI 数据集 sourceId | `executeSql` | `catalog: 'BI_SQL'` + sourceId |
| 看板 widgetId | `queryWidgetData` | widgetId |
| 多维分析 shareId | `queryWidgetData` | shareId |
| 要改时间范围/维度 | `queryWidgetData` | filters / dynamicDims |
| 要同环比对比 | `queryWidgetData` | timeCycleParams |
| 沙箱内文件（csv/json/图片）| `fetchSandboxFile` 或 `buildSandboxDownloadUrl` | path（`/` 开头）|
