# deploy/release-flow.md — 发布流程规范

> 发布操作对应 `phases/phase5-deploy.md` 中的步骤，本文件提供详细规范补充。  
> **待 @骆潇龙 补充完善监控/回滚/CDN/灰度发布等流程。**

---

## 发布前 Checklist

```
[ ] Phase 4 UI 质量门控已全部通过
[ ] dev server 预览已确认符合预期
[ ] 用户已明确表示要发布（说了"发布"/"上线"/"deploy"）
[ ] /tmp/site-<name>.env 存在且 siteId 正确
```

---

## 发布脚本说明

### build.sh
- 执行 `cd web && pnpm run build`
- 产物在 `web/dist/`
- 构建失败时模型自主排查错误并修复

### publish-git.sh
- 参数：`<name>` `<masterBranch>`
- 输出：第一行 = 开发分支名（BRANCH），最后一行 = commit hash（COMMIT_ID）
- 失败时（git 冲突等）模型自行解决

### deploy.sh
- 参数：`<siteId>` `<commitId>` `<branch>` `<remark>`
- 调用 `/api/v1/site/publish/deploy`
- 成功返回 `publishUrl`

---

## 发布后验证

```bash
# 验证发布 URL 可访问
curl -sf <publishUrl> > /dev/null && echo "ONLINE" || echo "FAILED"
```

---

## 待补充（@骆潇龙）

- [ ] CDN 缓存刷新流程
- [ ] 灰度发布规范（百分比放量）
- [ ] 回滚操作步骤
- [ ] 监控告警接入
- [ ] 多环境（dev/staging/prod）发布规范
- [ ] 文件组织规范（README 模板/文档规范）
