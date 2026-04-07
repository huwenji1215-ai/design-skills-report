<?xml version="1.0" encoding="UTF-8"?>
<map version="1.0.1">
  <node TEXT="设计 Skill 体系" COLOR="#ffffff" BACKGROUND_COLOR="#1a1a2e" STYLE="bubble" FOLDED="false">
    <node TEXT="UI 生成 [7个 Skill]" COLOR="#388bfd" STYLE="bubble" FOLDED="false" POSITION="right">
      <node TEXT="A. 原型类 [低保真-&gt;走查]" COLOR="#388bfd" STYLE="fork" FOLDED="false">
        <node TEXT="[P1] 单页 HTML 原型" COLOR="#e6821e" STYLE="bubble">
          <richcontent TYPE="NOTE">ID: UI-A1 | 优先级: P1 | 技术路线: LLM + 纯HTML | 竞品对标: Claude Artifacts | 2天可交付: yes | 描述: 快速生成单文件HTML原型，浏览器直接打开，用于走查沟通</richcontent>
        </node>
        <node TEXT="[P2] 可交互多页原型" COLOR="#999999" STYLE="bubble">
          <richcontent TYPE="NOTE">ID: UI-A2 | 优先级: P2 | 技术路线: 待定 | 竞品对标: Figma Make | 2天可交付: no | 描述: 多页流转可点击原型，技术路线待评审</richcontent>
        </node>
      </node>
      <node TEXT="B. 生产类 [直达生产代码]" COLOR="#388bfd" STYLE="fork" FOLDED="false">
        <node TEXT="[P0] B端增删改查控制台" COLOR="#cc0000" STYLE="bubble">
          <richcontent TYPE="NOTE">ID: UI-B1 | 优先级: P0 | 技术路线: LLM + shadcn/ui + Tailwind | 竞品对标: v0.dev | 2天可交付: yes | 描述: 输入业务实体描述，输出列表页+表单页+详情页完整React代码</richcontent>
        </node>
        <node TEXT="[P1] 数据可视化仪表盘" COLOR="#e6821e" STYLE="bubble">
          <richcontent TYPE="NOTE">ID: UI-B2 | 优先级: P1 | 技术路线: LLM + ECharts/Recharts | 竞品对标: Vercel AI | 2天可交付: warn | 描述: 输入数据结构，输出含折线/柱状/饼图的监控仪表盘页面</richcontent>
        </node>
        <node TEXT="[P1] H5 营销落地页" COLOR="#e6821e" STYLE="bubble">
          <richcontent TYPE="NOTE">ID: UI-B3 | 优先级: P1 | 技术路线: LLM + 移动端HTML | 竞品对标: Framer AI | 2天可交付: yes | 描述: 输入活动主题/品牌色/CTA，输出移动端375px适配的H5落地页</richcontent>
        </node>
        <node TEXT="[P2] 移动端 Android/iOS" COLOR="#999999" STYLE="bubble">
          <richcontent TYPE="NOTE">ID: UI-B4 | 优先级: P2 | 技术路线: 待评审 | 竞品对标: Bolt.new | 2天可交付: no | 描述: Android Compose / iOS SwiftUI，技术路线需评审</richcontent>
        </node>
        <node TEXT="[P1] 图标智能选配" COLOR="#e6821e" STYLE="bubble">
          <richcontent TYPE="NOTE">ID: UI-B5 | 优先级: P1 | 技术路线: 语义检索 + SVG输出 | 竞品对标: Figma图标插件 | 2天可交付: yes | 描述: 输入功能描述，推荐3-5个候选图标，输出SVG代码片段</richcontent>
        </node>
      </node>
    </node>
    <node TEXT="图片生成 [8个 Skill]" COLOR="#3fb950" STYLE="bubble" FOLDED="false" POSITION="right">
      <node TEXT="C. LLM代码型 [可编辑矢量]" COLOR="#3fb950" STYLE="fork" FOLDED="false">
        <node TEXT="[P0] SVG 矢量插画生成" COLOR="#cc0000" STYLE="bubble">
          <richcontent TYPE="NOTE">ID: IMG-C1 | 优先级: P0 | 技术路线: LLM直出SVG (GPT-4o/Claude) | 竞品对标: GPT-4o SVG输出 | 2天可交付: yes | 描述: 输入主题描述，生成可在Figma编辑的SVG矢量插画，&lt;10KB，适合空状态页/UI配图</richcontent>
        </node>
      </node>
      <node TEXT="D. 模型调用型 [Diffusion/多模态]" COLOR="#3fb950" STYLE="fork" FOLDED="false">
        <node TEXT="[P1] 文生图（通用）" COLOR="#e6821e" STYLE="bubble">
          <richcontent TYPE="NOTE">ID: IMG-D1 | 优先级: P1 | 技术路线: Gemini 2.5 Flash(Nano Banana)/Flux.1按场景选 | 竞品对标: Gemini 2.5 Flash Image | 2天可交付: yes | 描述: 综合质量首选Gemini 2.5 Flash(Nano Banana)，文字渲染-&gt;GPT-4o，写实-&gt;Flux.1，合规-&gt;Firefly</richcontent>
        </node>
        <node TEXT="[P2] 文生图（品牌风格锁定）" COLOR="#999999" STYLE="bubble">
          <richcontent TYPE="NOTE">ID: IMG-D2 | 优先级: P2 | 技术路线: LoRA微调/风格参考 | 竞品对标: Midjourney --sref | 2天可交付: no | 描述: 品牌色+风格参考图锁定生成风格，需工程评审</richcontent>
        </node>
        <node TEXT="[P1] 图生图（风格迁移）" COLOR="#e6821e" STYLE="bubble">
          <richcontent TYPE="NOTE">ID: IMG-D3 | 优先级: P1 | 技术路线: GPT-4o Image / SD img2img | 竞品对标: Adobe Firefly | 2天可交付: yes | 描述: 原图+改写指令-&gt;保留结构改变风格</richcontent>
        </node>
        <node TEXT="[P2] 局部重绘 Inpainting" COLOR="#999999" STYLE="bubble">
          <richcontent TYPE="NOTE">ID: IMG-D4 | 优先级: P2 | 技术路线: SD Inpainting | 竞品对标: Adobe Firefly | 2天可交付: warn | 描述: 遮罩指定区域局部重绘，技术可行需评审</richcontent>
        </node>
      </node>
      <node TEXT="E. 文案驱动型 [文案-&gt;配图]" COLOR="#3fb950" STYLE="fork" FOLDED="false">
        <node TEXT="[P1] 文案驱动配图（路由型）" COLOR="#e6821e" STYLE="bubble">
          <richcontent TYPE="NOTE">ID: IMG-E1 | 优先级: P1 | 技术路线: 意图路由+多子Skill并行 | 竞品对标: 无直接竞品 | 2天可交付: warn | 描述: 输入文案，并行评估SVG/文生图/图库三条路线，展示3个候选方案</richcontent>
        </node>
        <node TEXT="[P2] 长文自动插图" COLOR="#999999" STYLE="bubble">
          <richcontent TYPE="NOTE">ID: IMG-E2 | 优先级: P2 | 技术路线: 多步流水线 | 竞品对标: 无直接竞品 | 2天可交付: no | 描述: 从长文中判断插图位置并自动生成，需拆解成多步流水线</richcontent>
        </node>
      </node>
      <node TEXT="F. 运营裂变型 [一图多尺寸]" COLOR="#3fb950" STYLE="fork" FOLDED="false">
        <node TEXT="[P1] 图片裂变·多尺寸适配" COLOR="#e6821e" STYLE="bubble">
          <richcontent TYPE="NOTE">ID: IMG-F1 | 优先级: P1 | 技术路线: 主体检测+Outpainting+批量导出 | 竞品对标: Adobe Express / 即时设计 | 2天可交付: yes | 描述: 一张主图-&gt;自动裁切/补全为App Banner/方图/微信封面/抖音竖版等多尺寸</richcontent>
        </node>
      </node>
    </node>
    <node TEXT="视频/动效生成 [8个 Skill]" COLOR="#da3633" STYLE="bubble" FOLDED="false" POSITION="right">
      <node TEXT="F. 代码型动效 [L1-L2 设计系统可用]" COLOR="#da3633" STYLE="fork" FOLDED="false">
        <node TEXT="[P0] HTML+CSS 微动效（L1）" COLOR="#cc0000" STYLE="bubble">
          <richcontent TYPE="NOTE">ID: VID-F1 | 优先级: P0 | 技术路线: LLM + CSS Animations | 竞品对标: Framer Motion示例 | 2天可交付: yes | 描述: 按钮涟漪/骨架屏/页面入场/背景动效/数字滚动，优先GPU加速属性</richcontent>
        </node>
        <node TEXT="[P1] SVG 动效（SMIL/CSS）" COLOR="#e6821e" STYLE="bubble">
          <richcontent TYPE="NOTE">ID: VID-F2 | 优先级: P1 | 技术路线: LLM + SVG Animations | 竞品对标: CSS Tricks | 2天可交付: yes | 描述: 带动画的SVG文件，适合Logo动效/品牌Reveal/Loading图形，L1-L2</richcontent>
        </node>
      </node>
      <node TEXT="G. Lottie型动效 [移动端/跨平台]" COLOR="#da3633" STYLE="fork" FOLDED="false">
        <node TEXT="[PoC] Lottie JSON 生成 (PoC)" COLOR="#4a90d9" STYLE="bubble">
          <richcontent TYPE="NOTE">ID: VID-G1 | 优先级: PoC | 技术路线: OmniLottie（CVPR 2026，已开源） | 竞品对标: OmniLottie arXiv:2603.02138 | 2天可交付: no | 描述: AI直接生成Lottie JSON，可在iOS/Android/Web原生渲染，约50KB</richcontent>
        </node>
        <node TEXT="[P1] Figma-&gt;Lottie 一键导出" COLOR="#e6821e" STYLE="bubble">
          <richcontent TYPE="NOTE">ID: VID-G2 | 优先级: P1 | 技术路线: Magic Animator Beta（2025.07） | 竞品对标: Magic Animator/Lottielab | 2天可交付: yes | 描述: Figma设计稿一键添加动效并导出Lottie JSON/MP4/GIF</richcontent>
        </node>
      </node>
      <node TEXT="H. 程序化视频（Remotion） [数据·叙事·演示 P1]" COLOR="#da3633" STYLE="fork" FOLDED="false">
        <node TEXT="[P1] 数据可视化视频" COLOR="#e6821e" STYLE="bubble">
          <richcontent TYPE="NOTE">ID: VID-H1 | 优先级: P1 | 技术路线: LLM + React + Remotion | 竞品对标: Remotion Showcase | 2天可交付: yes | 描述: 输入数据(JSON/CSV)+叙事结构，生成可渲染为MP4的数据可视化视频</richcontent>
        </node>
        <node TEXT="[P1] 汇报/年报叙事视频" COLOR="#e6821e" STYLE="bubble">
          <richcontent TYPE="NOTE">ID: VID-H2 | 优先级: P1 | 技术路线: LLM + Remotion + 动态排版 | 竞品对标: Remotion Showcase | 2天可交付: yes | 描述: 输入PPT内容/文字大纲，生成带镜头切换/文字入场/数字增长的汇报型叙事视频</richcontent>
        </node>
        <node TEXT="[P1] UI原型演示视频" COLOR="#e6821e" STYLE="bubble">
          <richcontent TYPE="NOTE">ID: VID-H3 | 优先级: P1 | 技术路线: LLM + Remotion + UI模拟组件 | 竞品对标: Remotion Showcase | 2天可交付: warn | 描述: 输入多张UI截图+交互流程描述，生成模拟用户操作的演示视频</richcontent>
        </node>
      </node>
      <node TEXT="I. AI视频生成 [写实/营销型]" COLOR="#da3633" STYLE="fork" FOLDED="false">
        <node TEXT="[P2] 文生视频（营销素材）" COLOR="#999999" STYLE="bubble">
          <richcontent TYPE="NOTE">ID: VID-I1 | 优先级: P2 | 技术路线: Kling 3.0 / Veo 3.1 API | 竞品对标: Kling 3.0 | 2天可交付: warn | 描述: 文本描述-&gt;5-20秒视频，营销场景，API接入成本待评估</richcontent>
        </node>
        <node TEXT="[P2] 图生视频（设计稿动起来）" COLOR="#999999" STYLE="bubble">
          <richcontent TYPE="NOTE">ID: VID-I2 | 优先级: P2 | 技术路线: Kling 3.0 / Veo 3.1 API | 竞品对标: Kling 3.0 | 2天可交付: warn | 描述: 设计稿截图-&gt;加自然运动的展示视频，支持4K@60fps最长20s</richcontent>
        </node>
      </node>
    </node>
    <node TEXT="文档生成 [9个 Skill]" COLOR="#d29930" STYLE="bubble" FOLDED="false" POSITION="left">
      <node TEXT="J. PPT 演示文档 [高频设计场景]" COLOR="#d29930" STYLE="fork" FOLDED="false">
        <node TEXT="[P0] PPT 美化/视觉优化" COLOR="#cc0000" STYLE="bubble">
          <richcontent TYPE="NOTE">ID: DOC-J1 | 优先级: P0 | 技术路线: LLM + PptxGenJS | 竞品对标: Beautiful.ai / Gamma | 2天可交付: yes | 描述: 输入已有PPT，大幅提升视觉层次、字体规范、色彩体系，输出可编辑.pptx</richcontent>
        </node>
        <node TEXT="[P1] PPT 生成（信息架构型）" COLOR="#e6821e" STYLE="bubble">
          <richcontent TYPE="NOTE">ID: DOC-J2 | 优先级: P1 | 技术路线: LLM + 结构化模板 | 竞品对标: Skywork Agent | 2天可交付: yes | 描述: 输入主题/大纲，生成逻辑严谨的PPT，符合金字塔原理/SCQA结构</richcontent>
        </node>
        <node TEXT="[P1] PPT 生成（美学表现型）" COLOR="#e6821e" STYLE="bubble">
          <richcontent TYPE="NOTE">ID: DOC-J3 | 优先级: P1 | 技术路线: LLM + AI配图 + 模板 | 竞品对标: Gamma / 张月光系 | 2天可交付: warn | 描述: 输入主题，生成高颜值PPT，每页配图&gt;=30%，适合对外展示/品牌提案</richcontent>
        </node>
        <node TEXT="[P1] PPT图片化输出（不可编辑）" COLOR="#e6821e" STYLE="bubble">
          <richcontent TYPE="NOTE">ID: DOC-J4 | 优先级: P1 | 技术路线: HTML/CSS + Puppeteer截图 | 竞品对标: 无直接竞品 | 2天可交付: yes | 描述: 输入内容-&gt;HTML排版-&gt;Puppeteer逐页截图-&gt;PDF/PNG打包，适合直接分发/社媒分享</richcontent>
        </node>
      </node>
      <node TEXT="K. UX研究报告类 [可用性/体验/满意度]" COLOR="#d29930" STYLE="fork" FOLDED="false">
        <node TEXT="[P1] 竞品分析文档生成" COLOR="#e6821e" STYLE="bubble">
          <richcontent TYPE="NOTE">ID: DOC-K1 | 优先级: P1 | 技术路线: 搜索 + LLM 结构化分析 | 竞品对标: 无直接竞品 | 2天可交付: yes | 描述: 输入竞品名称，自动调研生成功能矩阵+截图说明+差异洞察</richcontent>
        </node>
        <node TEXT="[P1] 可用性分析报告" COLOR="#e6821e" STYLE="bubble">
          <richcontent TYPE="NOTE">ID: DOC-K2 | 优先级: P1 | 技术路线: LLM + Nielsen启发式 | 竞品对标: 无直接竞品 | 2天可交付: yes | 描述: 输入用户研究数据，生成含P0-P2问题分级+用户原话引用+改进建议的可用性报告</richcontent>
        </node>
        <node TEXT="[P1] 用户体验地图（UX Map）" COLOR="#e6821e" STYLE="bubble">
          <richcontent TYPE="NOTE">ID: DOC-K3 | 优先级: P1 | 技术路线: LLM + SVG可视化输出 | 竞品对标: 无直接竞品 | 2天可交付: yes | 描述: 输入用户旅程描述/访谈数据，生成各触点情绪曲线+痛点+机会点的可视化UX Map</richcontent>
        </node>
        <node TEXT="[P1] 满意度调研分析报告" COLOR="#e6821e" STYLE="bubble">
          <richcontent TYPE="NOTE">ID: DOC-K4 | 优先级: P1 | 技术路线: 数据分析+LLM洞察 | 竞品对标: 无直接竞品 | 2天可交付: yes | 描述: 输入NPS/CSAT/满意度问卷原始数据，自动清洗分析，生成含核心指标/趋势对比/用户分群洞察的报告</richcontent>
        </node>
      </node>
    </node>
    <node TEXT="评测 [8个 Skill]" COLOR="#8957e5" STYLE="bubble" FOLDED="false" POSITION="left">
      <node TEXT="M. UI/界面评测 [可用性+规范+还原]" COLOR="#8957e5" STYLE="fork" FOLDED="false">
        <node TEXT="[P0] UI 可用性评测" COLOR="#cc0000" STYLE="bubble">
          <richcontent TYPE="NOTE">ID: EVAL-M1 | 优先级: P0 | 技术路线: GPT-4o Vision + 规则引擎 | 竞品对标: TRAIL模型 + Nielsen十原则 | 2天可交付: yes | 描述: 输入UI截图，评估信息层级/视觉引导/交互一致性/可读性，输出P0-P2问题清单+综合评分</richcontent>
        </node>
        <node TEXT="[P1] 视觉规范合规评测" COLOR="#e6821e" STYLE="bubble">
          <richcontent TYPE="NOTE">ID: EVAL-M2 | 优先级: P1 | 技术路线: 颜色/字体/间距提取+Token比对 | 竞品对标: 内部 Design Token 规范 | 2天可交付: yes | 描述: 检查UI是否符合Design Token规范，输出违规点清单+合规率百分比</richcontent>
        </node>
        <node TEXT="[P1] UI 还原度评测" COLOR="#e6821e" STYLE="bubble">
          <richcontent TYPE="NOTE">ID: EVAL-M3 | 优先级: P1 | 技术路线: 图像对齐比对+多模态差异识别 | 竞品对标: 内部稿-码对比标准 | 2天可交付: warn | 描述: Figma设计稿 vs 前端实现截图，自动识别颜色/间距/字体偏差，输出红线标注报告</richcontent>
        </node>
      </node>
      <node TEXT="N. 视觉/图片评测 [AQE美学评测]" COLOR="#8957e5" STYLE="fork" FOLDED="false">
        <node TEXT="[P0] 美学质量评测（AQE）" COLOR="#cc0000" STYLE="bubble">
          <richcontent TYPE="NOTE">ID: EVAL-N1 | 优先级: P0 | 技术路线: 多模态视觉模型 + AQE矩阵 | 竞品对标: 内部 AQE 框架 | 2天可交付: yes | 描述: 图片美学多维评分：视觉和谐度30%+构图平衡25%+风格一致20%+细节精致15%+品牌契合10%，&gt;=7分合格</richcontent>
        </node>
        <node TEXT="[P1] 品牌合规评测" COLOR="#e6821e" STYLE="bubble">
          <richcontent TYPE="NOTE">ID: EVAL-N2 | 优先级: P1 | 技术路线: 品牌规范库 + 视觉比对 | 竞品对标: 内部品牌规范 | 2天可交付: warn | 描述: 检查设计稿/图片是否符合品牌色/Logo使用/字体规范，输出违规标注</richcontent>
        </node>
      </node>
      <node TEXT="O/P. 文档+走查评测 [PPT结构+设计走查]" COLOR="#8957e5" STYLE="fork" FOLDED="false">
        <node TEXT="[P1] PPT 内容结构评测" COLOR="#e6821e" STYLE="bubble">
          <richcontent TYPE="NOTE">ID: EVAL-O1 | 优先级: P1 | 技术路线: python-pptx + LLM评判 | 竞品对标: 金字塔原理标准 | 2天可交付: yes | 描述: 评估PPT信息架构/逻辑连贯性/信息密度/表达清晰度/视觉规范，输出结构优化建议</richcontent>
        </node>
        <node TEXT="[P1] 自动化设计走查" COLOR="#e6821e" STYLE="bubble">
          <richcontent TYPE="NOTE">ID: EVAL-P1 | 优先级: P1 | 技术路线: 规则引擎 + 多模态视觉 | 竞品对标: 内部走查规则集 | 2天可交付: warn | 描述: 输入设计稿+走查规则，自动执行视觉规范/可用性/无障碍/业务逻辑四类走查</richcontent>
        </node>
        <node TEXT="[P2] 生成-评测自进化流水线" COLOR="#999999" STYLE="bubble">
          <richcontent TYPE="NOTE">ID: EVAL-Q1 | 优先级: P2 | 技术路线: 生成Skill + 评测Skill 串联 | 竞品对标: infovis-autoevo模式 | 2天可交付: no | 描述: 生成-&gt;评测-&gt;差异计算-&gt;重新生成的闭环，评分&gt;=阈值才通过</richcontent>
        </node>
      </node>
    </node>
  </node>
</map>
