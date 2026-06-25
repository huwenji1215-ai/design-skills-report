# deploy/build-spec.md — 构建配置说明

> rsbuild.config.js 关键配置参考，及构建相关注意事项。

---

## 关键配置项

| 配置项 | 作用 | 是否需要修改 |
|--------|------|------------|
| `COOKIE_FILE` / `RAW_COOKIE` | 本地联调登录态 | 沙箱已自动注入到 `/data_agent/users/.agent-cookie/`，不需要手填 |
| `PROXY_TARGET` | 代理的后端域名 | 按需修改，默认 `rc-tc.corp.kuaishou.com` |
| `PORT` | dev server 端口 | 默认 8888，跟 webSiteInit.devUrl 一致，不改 |
| `CDN_TOKEN` | KCDN 上传 token | 生产构建时需要，开发时忽略 |
| `BASE_PATH` | 沙箱反代基础路径 | 自动从 `/data_agent/users/.env` 读取 |
| `server.proxy` | 接口代理规则 | 新增接口前缀时追加 |

---

## 新增代理前缀

```javascript
// rsbuild.config.js
server: {
  proxy: {
    '/api': proxyWithCookie,
    '/rest/flow': proxyWithCookie,
    '/dp': proxyWithCookie,
    '/your/new/prefix': proxyWithCookie,  // 新增：复用 proxyWithCookie
  },
},
```

---

## 构建常见问题

| 问题 | 原因 | 解决 |
|------|------|------|
| 构建报 TS 类型错误 | 类型不匹配 | 修复类型，或加 `as any` 临时绕过 |
| 依赖找不到 | pnpm install 未完成 | `pnpm install --no-frozen-lockfile` |
| ECharts 包体积警告 | 全量引入 | 改为按需引入（`echarts/core`）|
| 样式在 dev 正常但 build 后丢失 | scoped CSS hash 问题 | 检查是否有 `>>>` 或 `/deep/` 语法（rsbuild 不支持）|
