# 设计智力skill 启动指南

## 项目概述
纯静态 HTML 演示项目，包含信息可视化分类体系页面及 InfoVis 自进化流水线演示页面，无需构建，使用本地 HTTP 服务器直接预览。根目录下有多个 Markdown 文档，推荐在 VSCode 内直接预览。

## Markdown 文件预览（推荐方式）

### 快速启动

无需启动服务器，在 VSCode 中直接打开 MD 文件，按 `Cmd+Shift+V` 即可渲染预览。

**根目录 Markdown 文件列表**：
- `设计Skill深度拆解-三方向.md`
- `设计Skill逻辑拆解.md`
- `设计Skill逻辑拆解_副本.md`
- `设计侧内容飞轮：构建 AI 驱动的生成-评审自进化引擎.md`

**启动后访问**：在 VSCode 编辑器内渲染，或通过已运行的 HTTP 服务以原始文本访问

```yaml
subProjectPath: .
command: "# VSCode 内置预览：Cmd+Shift+V"
cwd: .
port: null
previewUrl: null
description: Markdown 文件推荐使用 VSCode 内置预览（Cmd+Shift+V），无需额外服务
```

## infovis-taxonomy/index.html - 信息可视化分类体系

### 快速启动

```bash
cd /Users/huwenji/Desktop/设计智力skill
python3 -m http.server 8080
```

**启动后访问**：http://localhost:8080/infovis-taxonomy/index.html

```yaml
subProjectPath: infovis-taxonomy/index.html
command: python3 -m http.server 8080
cwd: .
port: 8080
previewUrl: http://localhost:8080/infovis-taxonomy/index.html
description: 信息可视化图表分类体系，涵盖5大类别16种子类，含完整SVG示意图
```

## evo-demo/pipeline-demo.html - InfoVis 自进化引擎演示

### 快速启动

```bash
cd /Users/huwenji/Desktop/设计智力skill
python3 -m http.server 8080
```

**启动后访问**：http://localhost:8080/evo-demo/pipeline-demo.html

```yaml
subProjectPath: evo-demo/pipeline-demo.html
command: python3 -m http.server 8080
cwd: .
port: 8080
previewUrl: http://localhost:8080/evo-demo/pipeline-demo.html
description: InfoVis 自进化引擎完整流水线演示，静态 HTML 页面
```
