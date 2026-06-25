# scenes/content-doc.md — 内容站 / 文档站 / 知识库 / 博客

> **场景定位**：以深度阅读和内容消费为目标的页面，目标是「信息清晰传递，阅读体验舒适」。  
> 叙事结构：无固定叙事节奏，以内容自身结构为主，版式服务于阅读而非说服。  
> 典型受众：开发者（技术文档）/ 知识工作者（内容站）/ 学习者（知识库）。  
> 设计哲学：来自 taste-skill **minimalist + soft** 两个变体的结合。

---

## 一、与其他场景的核心区别

| 维度 | 内容站 | Landing Page | 工具应用 |
|------|--------|-------------|---------|
| 核心目标 | 让人读完 | 让人行动 | 让人操作 |
| 行高 | 1.8（阅读优先）| 1.5（展示优先）| 1.5（操作优先）|
| 字号 | body 16px | body 14px | body 14px |
| 最大宽度 | 680px（阅读宽度）| 1280px（全宽展示）| 满屏（利用空间）|
| 颜色密度 | 极低（接近黑白）| 中等（品牌色点缀）| 中等（状态色）|
| 动效 | 无 | 适当 | 极少 |

---

## 二、视觉规范（三层映射）

### 2.1 阅读体验

- **[用户感受]**：字很清楚，间距宽松，读起来不累，像在读一本好书。
- **[设计原理]**：内容站的核心是「可读性」（Readability），字号、行高、最大宽度三者配合，形成最佳阅读节奏。
- **[技术实现]**：body 字号 `16px`；行高 `1.8`；正文最大宽度 `680px`（prose width）；左右 padding `24px`。

### 2.2 极简颜色

- **[用户感受]**：页面颜色很少，几乎就是黑白，但有几个地方用了主题色，点缀一下。
- **[设计原理]**：内容场景中颜色是噪声，正文中出现颜色的地方应该只有「链接」和「代码高亮」，其余用黑白灰层次区分。
- **[技术实现]**：正文 `#1A1A1A`；辅助文字 `#6B7280`；链接 `var(--color-primary)` 不下划线默认，hover 显示下划线；代码块见 §代码规范。

### 2.3 字体选择（主题 C 编辑排版风格）

- **[用户感受]**：标题字体很有质感，不是那种很普通的无衬线字体。
- **[设计原理]**：内容站使用衬线字体标题 + 高可读性无衬线正文的组合，传递「专业、值得信赖」的质感。
- **[技术实现]**：标题 `'Playfair Display', Georgia, serif` 或 `'Lora', Georgia, serif`；正文 `'Source Serif 4', Georgia, serif` 或 `-apple-system, sans-serif`（偏技术的文档站用无衬线）。

### 2.4 排版层次

- **[用户感受]**：有大标题，有小标题，有正文，层次很清楚，一眼知道在哪里。
- **[设计原理]**：标题使用尺寸+字重双轴建立层次，不依赖颜色区分层级，正文中 `<strong>` 和 `<em>` 有明确视觉意义。
- **[技术实现]**：h1 `32px 700`；h2 `24px 600`；h3 `18px 600`；h4 `16px 600`；正文 `16px 400`；`strong` 用 `600` 不加颜色。

---

## 三、页面骨架

```html
<div class="doc-layout">
  <!-- 可选：左侧目录（技术文档必有）-->
  <aside class="doc-sidebar">
    <nav class="toc">
      <div class="toc-title">目录</div>
      <a class="toc-item" href="#intro">简介</a>
      <a class="toc-item active" href="#usage">使用方法</a>
      <!-- ... -->
    </nav>
  </aside>

  <!-- 主内容区 -->
  <main class="doc-main">
    <div class="doc-content prose">
      <h1>文章主标题</h1>
      <div class="doc-meta">作者 · 发布日期 · 阅读时间</div>
      <!-- 正文内容 -->
    </div>
  </main>

  <!-- 可选：右侧锚点导航（长文必有）-->
  <aside class="doc-toc-right">
    <!-- 本页导航 -->
  </aside>
</div>
```

```css
/* 整体布局 */
.doc-layout { display: flex; max-width: 1280px; margin: 0 auto; padding: 0 24px; }

/* 左侧目录 */
.doc-sidebar { width: 240px; flex-shrink: 0; padding: 32px 24px 32px 0;
               position: sticky; top: 0; height: 100vh; overflow-y: auto; }
.toc-title   { font-size: 11px; font-weight: 600; color: #9CA3AF;
               text-transform: uppercase; letter-spacing: 0.08em; margin-bottom: 12px; }
.toc-item    { display: block; padding: 5px 0; font-size: 13px; color: #6B7280;
               text-decoration: none; transition: color 0.1s; }
.toc-item:hover  { color: #111827; }
.toc-item.active { color: var(--color-primary); font-weight: 500; }

/* 主内容区 */
.doc-main    { flex: 1; padding: 48px 48px; }
.doc-content { max-width: 680px; }  /* ← 黄金阅读宽度 */
```

---

## 四、文字排版规范（Prose 样式）

```css
.prose { font-size: 16px; line-height: 1.8; color: #1A1A1A; }

.prose h1 { font-size: 32px; font-weight: 700; line-height: 1.2;
            margin: 0 0 8px; color: #111827; }
.prose h2 { font-size: 24px; font-weight: 600; line-height: 1.3;
            margin: 48px 0 16px; color: #111827;
            padding-bottom: 8px; border-bottom: 1px solid #E5E7EB; }
.prose h3 { font-size: 18px; font-weight: 600; line-height: 1.4;
            margin: 32px 0 12px; color: #111827; }
.prose p  { margin: 0 0 20px; }

/* 链接 */
.prose a  { color: var(--color-primary); text-decoration: none; }
.prose a:hover { text-decoration: underline; }

/* 引用块 */
.prose blockquote {
  border-left: 3px solid #E5E7EB;
  margin: 24px 0; padding: 4px 20px;
  color: #6B7280; font-style: italic;
}

/* 代码规范 */
.prose code {
  font-family: 'JetBrains Mono', 'Fira Code', 'Courier New', monospace;
  font-size: 13px; background: #F3F4F6;
  padding: 2px 5px; border-radius: 4px; color: #C7254E;
}
.prose pre {
  background: #1E293B; border-radius: 8px;
  padding: 20px 24px; overflow-x: auto; margin: 24px 0;
}
.prose pre code {
  background: transparent; color: #E2E8F0; font-size: 13px;
  padding: 0; border-radius: 0;
}

/* 列表 */
.prose ul, .prose ol { padding-left: 24px; margin: 0 0 20px; }
.prose li  { margin-bottom: 6px; }

/* 分隔线 */
.prose hr  { border: none; border-top: 1px solid #E5E7EB; margin: 48px 0; }

/* 图片 */
.prose img { max-width: 100%; border-radius: 8px;
             border: 1px solid #E5E7EB; margin: 24px 0; }

/* 表格 */
.prose table { width: 100%; border-collapse: collapse; margin: 24px 0; font-size: 14px; }
.prose th    { font-weight: 600; font-size: 12px; text-transform: uppercase;
               letter-spacing: 0.06em; color: #6B7280;
               padding: 8px 12px; border-bottom: 2px solid #E5E7EB; text-align: left; }
.prose td    { padding: 10px 12px; border-bottom: 1px solid #F3F4F6; }
```

---

## 五、文档元数据组件

```html
<!-- 文章 Meta 信息 -->
<div class="doc-meta">
  <img src="avatar.jpg" class="doc-avatar" alt="作者头像">
  <div>
    <span class="doc-author">作者姓名</span>
    <div class="doc-date-read">
      <time>2025 年 6 月 23 日</time>
      <span>·</span>
      <span>约 8 分钟阅读</span>
    </div>
  </div>
</div>

<!-- 标签 -->
<div class="doc-tags">
  <span class="doc-tag">设计系统</span>
  <span class="doc-tag">前端</span>
</div>
```

```css
.doc-meta    { display: flex; align-items: center; gap: 12px; margin-bottom: 32px; }
.doc-avatar  { width: 40px; height: 40px; border-radius: 50%; object-fit: cover; }
.doc-author  { font-size: 14px; font-weight: 500; color: #111827; }
.doc-date-read { font-size: 13px; color: #6B7280; display: flex; gap: 6px; }
.doc-tag     { display: inline-block; background: #F3F4F6;
               color: #374151; font-size: 12px;
               padding: 3px 10px; border-radius: 9999px; margin-right: 6px; }
```

---

## 六、Self-Check 补充项（Content Doc 专属）

```
[ ] 正文字号 ≥ 16px，行高 ≥ 1.8
[ ] 正文最大宽度 ≤ 720px（不宜过宽）
[ ] 标题层级清晰（h1 > h2 > h3），不跳级
[ ] h2 有分隔线（border-bottom）
[ ] 代码块使用等宽字体 + 暗色背景
[ ] 行内代码有背景色区分（不与正文混淆）
[ ] 引用块有左边框区分
[ ] 图片有圆角 + 浅边框
[ ] 表格表头 uppercase，不使用颜色背景区分
[ ] 链接颜色区分正文（primary 色），hover 有下划线
[ ] 无 Emoji 在标题中出现
[ ] 响应式：移动端 Sidebar 折叠，正文 padding 缩小
```
