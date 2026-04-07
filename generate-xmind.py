#!/usr/bin/env python3
"""
生成兼容 XMind 8 / XMind 2022+ 的 .xmind 文件
格式：ZIP 包含 content.xml + META-INF/container.xml + meta.xml
此格式兼容性最广，XMind 6/8/2020/2022 均可打开
"""
import zipfile
import uuid
import os
from datetime import datetime
from xml.etree.ElementTree import Element, SubElement, tostring
from xml.dom import minidom

def uid():
    return str(uuid.uuid4())

def ts_ms():
    return str(int(datetime.now().timestamp() * 1000))

# ── XML 美化输出 ────────────────────────────────────────────
def pretty_xml(element):
    raw = tostring(element, encoding="unicode")
    reparsed = minidom.parseString(raw)
    return reparsed.toprettyxml(indent="  ", encoding="UTF-8").decode("utf-8")

# ── 优先级 → XMind marker ───────────────────────────────────
P_MARKER = {
    "P0":  "priority-1",
    "P1":  "priority-2",
    "P2":  "priority-3",
    "PoC": "priority-4",
}

# ── 叶节点：具体 Skill ──────────────────────────────────────
def make_skill_topic(parent_el, s):
    topic = SubElement(parent_el, "topic", {
        "id": uid(),
        "created": ts_ms(),
        "modified": ts_ms(),
    })
    title = SubElement(topic, "title")
    title.text = s["label"]

    # 备注
    note_text = (
        f"ID: {s['id']}\n"
        f"优先级: {s['priority']}\n"
        f"技术路线: {s['tech']}\n"
        f"竞品对标: {s['benchmark']}\n"
        f"描述: {s['desc']}\n"
        f"2天可交付: {s['deliverable']}"
    )
    notes_el = SubElement(topic, "notes")
    plain_el = SubElement(notes_el, "plain")
    plain_el.text = note_text

    # 优先级 marker
    if s["priority"] in P_MARKER:
        markers_el = SubElement(topic, "marker-refs")
        SubElement(markers_el, "marker-ref", {"marker-id": P_MARKER[s["priority"]]})

    return topic

# ── 分类节点（A.原型类 等）──────────────────────────────────
def make_group_topic(parent_el, g):
    topic = SubElement(parent_el, "topic", {
        "id": uid(),
        "created": ts_ms(),
        "modified": ts_ms(),
    })
    label = g["label"]
    if g.get("sub"):
        label = f"{g['label']}  [{g['sub']}]"
    title = SubElement(topic, "title")
    title.text = label

    kids = g.get("children", [])
    if kids:
        children_el = SubElement(topic, "children")
        topics_el = SubElement(children_el, "topics", {"type": "attached"})
        for s in kids:
            make_skill_topic(topics_el, s)
    return topic

# ── 方向节点（5大方向）──────────────────────────────────────
def make_direction_topic(parent_el, d):
    topic = SubElement(parent_el, "topic", {
        "id": uid(),
        "created": ts_ms(),
        "modified": ts_ms(),
    })
    title = SubElement(topic, "title")
    title.text = f"{d['label']}  [{d['sub']}]"

    kids = d.get("children", [])
    if kids:
        children_el = SubElement(topic, "children")
        topics_el = SubElement(children_el, "topics", {"type": "attached"})
        for g in kids:
            make_group_topic(topics_el, g)
    return topic

# ── 完整数据（5大方向 · 40个 Skill）────────────────────────
ALL_DATA = [
    {
        "id": "ui", "label": "🖥 UI 生成", "sub": "7个 Skill",
        "children": [
            {
                "label": "A. 原型类", "sub": "低保真->走查",
                "children": [
                    {"id":"UI-A1","label":"单页 HTML 原型","priority":"P1","deliverable":"yes","tech":"LLM + 纯HTML","benchmark":"Claude Artifacts","desc":"快速生成单文件HTML原型，浏览器直接打开，用于走查沟通"},
                    {"id":"UI-A2","label":"可交互多页原型","priority":"P2","deliverable":"no","tech":"待定","benchmark":"Figma Make","desc":"多页流转可点击原型，技术路线待评审"},
                ]
            },
            {
                "label": "B. 生产类", "sub": "直达生产代码",
                "children": [
                    {"id":"UI-B1","label":"B端增删改查控制台","priority":"P0","deliverable":"yes","tech":"LLM + shadcn/ui + Tailwind","benchmark":"v0.dev","desc":"输入业务实体描述，输出列表页+表单页+详情页完整React代码"},
                    {"id":"UI-B2","label":"数据可视化仪表盘","priority":"P1","deliverable":"warn","tech":"LLM + ECharts/Recharts","benchmark":"Vercel AI","desc":"输入数据结构，输出含折线/柱状/饼图的监控仪表盘页面"},
                    {"id":"UI-B3","label":"H5 营销落地页","priority":"P1","deliverable":"yes","tech":"LLM + 移动端HTML","benchmark":"Framer AI","desc":"输入活动主题/品牌色/CTA，输出移动端375px适配的H5落地页"},
                    {"id":"UI-B4","label":"移动端 Android/iOS","priority":"P2","deliverable":"no","tech":"待评审","benchmark":"Bolt.new","desc":"Android Compose / iOS SwiftUI，技术路线需评审"},
                    {"id":"UI-B5","label":"图标智能选配","priority":"P1","deliverable":"yes","tech":"语义检索 + SVG输出","benchmark":"Figma图标插件","desc":"输入功能描述，推荐3-5个候选图标，输出SVG代码片段"},
                ]
            },
        ]
    },
    {
        "id": "img", "label": "图片生成", "sub": "8个 Skill",
        "children": [
            {
                "label": "C. LLM代码型", "sub": "可编辑矢量",
                "children": [
                    {"id":"IMG-C1","label":"SVG 矢量插画生成","priority":"P0","deliverable":"yes","tech":"LLM直出SVG (GPT-4o/Claude)","benchmark":"GPT-4o SVG输出","desc":"输入主题描述，生成可在Figma编辑的SVG矢量插画，<10KB，适合空状态页/UI配图"},
                ]
            },
            {
                "label": "D. 模型调用型", "sub": "Diffusion/多模态",
                "children": [
                    {"id":"IMG-D1","label":"文生图（通用）","priority":"P1","deliverable":"yes","tech":"Gemini 2.5 Flash(Nano Banana)/Flux.1按场景选","benchmark":"Gemini 2.5 Flash Image","desc":"综合质量首选Gemini 2.5 Flash(Nano Banana)，文字渲染->GPT-4o，写实->Flux.1，合规->Firefly"},
                    {"id":"IMG-D2","label":"文生图（品牌风格锁定）","priority":"P2","deliverable":"no","tech":"LoRA微调/风格参考","benchmark":"Midjourney --sref","desc":"品牌色+风格参考图锁定生成风格，需工程评审"},
                    {"id":"IMG-D3","label":"图生图（风格迁移）","priority":"P1","deliverable":"yes","tech":"GPT-4o Image / SD img2img","benchmark":"Adobe Firefly","desc":"原图+改写指令->保留结构改变风格，如改成扁平插画风/换深色背景"},
                    {"id":"IMG-D4","label":"局部重绘 Inpainting","priority":"P2","deliverable":"warn","tech":"SD Inpainting","benchmark":"Adobe Firefly","desc":"遮罩指定区域局部重绘，技术可行需评审"},
                ]
            },
            {
                "label": "E. 文案驱动型", "sub": "文案->配图",
                "children": [
                    {"id":"IMG-E1","label":"文案驱动配图（路由型）","priority":"P1","deliverable":"warn","tech":"意图路由+多子Skill并行","benchmark":"无直接竞品","desc":"输入文案，并行评估SVG/文生图/图库三条路线，展示3个候选方案"},
                    {"id":"IMG-E2","label":"长文自动插图","priority":"P2","deliverable":"no","tech":"多步流水线","benchmark":"无直接竞品","desc":"从长文中判断插图位置并自动生成，需拆解成多步流水线"},
                ]
            },
            {
                "label": "F. 运营裂变型", "sub": "一图多尺寸",
                "children": [
                    {"id":"IMG-F1","label":"图片裂变·多尺寸适配","priority":"P1","deliverable":"yes","tech":"主体检测+Outpainting+批量导出","benchmark":"Adobe Express / 即时设计","desc":"一张主图->自动裁切/补全为App Banner/方图/微信封面/抖音竖版等多尺寸，运营批量生产场景"},
                ]
            },
        ]
    },
    {
        "id": "vid", "label": "视频/动效生成", "sub": "8个 Skill",
        "children": [
            {
                "label": "F. 代码型动效", "sub": "L1-L2 设计系统可用",
                "children": [
                    {"id":"VID-F1","label":"HTML+CSS 微动效（L1）","priority":"P0","deliverable":"yes","tech":"LLM + CSS Animations","benchmark":"Framer Motion示例","desc":"按钮涟漪/骨架屏/页面入场/背景动效/数字滚动，优先GPU加速属性"},
                    {"id":"VID-F2","label":"SVG 动效（SMIL/CSS）","priority":"P1","deliverable":"yes","tech":"LLM + SVG Animations","benchmark":"CSS Tricks","desc":"带动画的SVG文件，适合Logo动效/品牌Reveal/Loading图形，L1-L2"},
                ]
            },
            {
                "label": "G. Lottie型动效", "sub": "移动端/跨平台",
                "children": [
                    {"id":"VID-G1","label":"Lottie JSON 生成 (PoC)","priority":"PoC","deliverable":"no","tech":"OmniLottie（CVPR 2026，已开源）","benchmark":"OmniLottie arXiv:2603.02138","desc":"AI直接生成Lottie JSON，可在iOS/Android/Web原生渲染，约50KB"},
                    {"id":"VID-G2","label":"Figma->Lottie 一键导出","priority":"P1","deliverable":"yes","tech":"Magic Animator Beta（2025.07）","benchmark":"Magic Animator/Lottielab","desc":"Figma设计稿一键添加动效并导出Lottie JSON/MP4/GIF，工具已成熟直接封装"},
                ]
            },
            {
                "label": "H. 程序化视频（Remotion）", "sub": "数据·叙事·演示 P1",
                "children": [
                    {"id":"VID-H1","label":"数据可视化视频","priority":"P1","deliverable":"yes","tech":"LLM + React + Remotion","benchmark":"Remotion Showcase","desc":"输入数据(JSON/CSV)+叙事结构，生成可渲染为MP4的数据可视化视频"},
                    {"id":"VID-H2","label":"汇报/年报叙事视频","priority":"P1","deliverable":"yes","tech":"LLM + Remotion + 动态排版","benchmark":"Remotion Showcase","desc":"输入PPT内容/文字大纲，生成带镜头切换/文字入场/数字增长的汇报型叙事视频"},
                    {"id":"VID-H3","label":"UI原型演示视频","priority":"P1","deliverable":"warn","tech":"LLM + Remotion + UI模拟组件","benchmark":"Remotion Showcase","desc":"输入多张UI截图+交互流程描述，生成模拟用户操作的演示视频"},
                ]
            },
            {
                "label": "I. AI视频生成", "sub": "写实/营销型",
                "children": [
                    {"id":"VID-I1","label":"文生视频（营销素材）","priority":"P2","deliverable":"warn","tech":"Kling 3.0 / Veo 3.1 API","benchmark":"Kling 3.0","desc":"文本描述->5-20秒视频，营销场景，API接入成本待评估"},
                    {"id":"VID-I2","label":"图生视频（设计稿动起来）","priority":"P2","deliverable":"warn","tech":"Kling 3.0 / Veo 3.1 API","benchmark":"Kling 3.0","desc":"设计稿截图->加自然运动的展示视频，Kling 3.0支持4K@60fps最长20s"},
                ]
            },
        ]
    },
    {
        "id": "doc", "label": "文档生成", "sub": "9个 Skill",
        "children": [
            {
                "label": "J. PPT 演示文档", "sub": "高频设计场景",
                "children": [
                    {"id":"DOC-J1","label":"PPT 美化/视觉优化","priority":"P0","deliverable":"yes","tech":"LLM + PptxGenJS","benchmark":"Beautiful.ai / Gamma","desc":"输入已有PPT，在保留内容的前提下大幅提升视觉层次、字体规范、色彩体系，输出可编辑.pptx"},
                    {"id":"DOC-J2","label":"PPT 生成（信息架构型）","priority":"P1","deliverable":"yes","tech":"LLM + 结构化模板","benchmark":"Skywork Agent","desc":"输入主题/大纲，生成逻辑严谨、信息架构完备的PPT，符合金字塔原理/SCQA结构"},
                    {"id":"DOC-J3","label":"PPT 生成（美学表现型）","priority":"P1","deliverable":"warn","tech":"LLM + AI配图 + 模板","benchmark":"Gamma / 张月光系","desc":"输入主题，生成视觉冲击力强的高颜值PPT，每页配图>=30%，适合对外展示/品牌提案"},
                    {"id":"DOC-J4","label":"PPT图片化输出（不可编辑）","priority":"P1","deliverable":"yes","tech":"HTML/CSS + Puppeteer截图","benchmark":"无直接竞品","desc":"输入内容/大纲->HTML排版->Puppeteer逐页截图->PDF/PNG打包，适合直接分发/社媒分享"},
                ]
            },
            {
                "label": "K. UX研究报告类", "sub": "可用性/体验/满意度",
                "children": [
                    {"id":"DOC-K1","label":"竞品分析文档生成","priority":"P1","deliverable":"yes","tech":"搜索 + LLM 结构化分析","benchmark":"无直接竞品","desc":"输入竞品名称，自动调研生成功能矩阵+截图说明+差异洞察，输出PPT/Word/Markdown"},
                    {"id":"DOC-K2","label":"可用性分析报告","priority":"P1","deliverable":"yes","tech":"LLM + Nielsen启发式","benchmark":"无直接竞品","desc":"输入用户研究数据(访谈/测试日志/问卷)，生成含P0-P2问题分级+用户原话引用+改进建议的可用性报告"},
                    {"id":"DOC-K3","label":"用户体验地图（UX Map）","priority":"P1","deliverable":"yes","tech":"LLM + SVG可视化输出","benchmark":"无直接竞品","desc":"输入用户旅程描述/访谈数据，生成各触点情绪曲线+痛点+机会点的可视化UX Map，输出SVG/PPT"},
                    {"id":"DOC-K4","label":"满意度调研分析报告","priority":"P1","deliverable":"yes","tech":"数据分析+LLM洞察","benchmark":"无直接竞品","desc":"输入NPS/CSAT/满意度问卷原始数据，自动清洗分析，生成含核心指标/趋势对比/用户分群洞察的报告"},
                ]
            },
        ]
    },
    {
        "id": "eval", "label": "评测", "sub": "8个 Skill",
        "children": [
            {
                "label": "M. UI/界面评测", "sub": "可用性+规范+还原",
                "children": [
                    {"id":"EVAL-M1","label":"UI 可用性评测","priority":"P0","deliverable":"yes","tech":"GPT-4o Vision + 规则引擎","benchmark":"TRAIL模型 + Nielsen十原则","desc":"输入UI截图，评估信息层级/视觉引导/交互一致性/可读性，输出P0-P2问题清单+综合评分"},
                    {"id":"EVAL-M2","label":"视觉规范合规评测","priority":"P1","deliverable":"yes","tech":"颜色/字体/间距提取+Token比对","benchmark":"内部 Design Token 规范","desc":"检查UI是否符合Design Token规范（色彩/字号/间距），输出违规点清单+合规率百分比"},
                    {"id":"EVAL-M3","label":"UI 还原度评测","priority":"P1","deliverable":"warn","tech":"图像对齐比对+多模态差异识别","benchmark":"内部稿-码对比标准","desc":"Figma设计稿 vs 前端实现截图，自动识别颜色/间距/字体偏差，输出红线标注报告"},
                ]
            },
            {
                "label": "N. 视觉/图片评测", "sub": "AQE美学评测",
                "children": [
                    {"id":"EVAL-N1","label":"美学质量评测（AQE）","priority":"P0","deliverable":"yes","tech":"多模态视觉模型 + AQE矩阵","benchmark":"内部 AQE 框架","desc":"图片美学多维评分：视觉和谐度30%+构图平衡25%+风格一致20%+细节精致15%+品牌契合10%，>=7分合格"},
                    {"id":"EVAL-N2","label":"品牌合规评测","priority":"P1","deliverable":"warn","tech":"品牌规范库 + 视觉比对","benchmark":"内部品牌规范","desc":"检查设计稿/图片是否符合品牌色/Logo使用/字体规范，输出违规标注"},
                ]
            },
            {
                "label": "O/P. 文档+走查评测", "sub": "PPT结构+设计走查",
                "children": [
                    {"id":"EVAL-O1","label":"PPT 内容结构评测","priority":"P1","deliverable":"yes","tech":"python-pptx + LLM评判","benchmark":"金字塔原理标准","desc":"评估PPT信息架构/逻辑连贯性/信息密度/表达清晰度/视觉规范，输出结构优化建议"},
                    {"id":"EVAL-P1","label":"自动化设计走查","priority":"P1","deliverable":"warn","tech":"规则引擎 + 多模态视觉","benchmark":"内部走查规则集","desc":"输入设计稿+走查规则，自动执行视觉规范/可用性/无障碍/业务逻辑四类走查，支持People-in-Loop"},
                    {"id":"EVAL-Q1","label":"生成-评测自进化流水线","priority":"P2","deliverable":"no","tech":"生成Skill + 评测Skill 串联","benchmark":"infovis-autoevo模式","desc":"生成->评测->差异计算->重新生成的闭环，评分>=阈值才通过"},
                ]
            },
        ]
    },
]

# ── 构建 content.xml ─────────────────────────────────────────
root_el = Element("xmap-content", {
    "xmlns":        "urn:xmind:xmap:xmlns:content:2.0",
    "xmlns:fo":     "http://www.w3.org/1999/XSL/Format",
    "xmlns:svg":    "http://www.w3.org/2000/svg",
    "xmlns:xhtml":  "http://www.w3.org/1999/xhtml",
    "xmlns:xlink":  "http://www.w3.org/1999/xlink",
    "version":      "2.0",
    "timestamp":    ts_ms(),
})

sheet_el = SubElement(root_el, "sheet", {"id": uid(), "timestamp": ts_ms()})

# 根节点
root_topic_el = SubElement(sheet_el, "topic", {
    "id": uid(),
    "structure-class": "org.xmind.ui.map.unbalanced",
    "timestamp": ts_ms(),
})
root_title = SubElement(root_topic_el, "title")
root_title.text = "设计 Skill 体系"

root_children_el = SubElement(root_topic_el, "children")
root_topics_el = SubElement(root_children_el, "topics", {"type": "attached"})

for d in ALL_DATA:
    make_direction_topic(root_topics_el, d)

sheet_title = SubElement(sheet_el, "title")
sheet_title.text = "设计 Skill 体系"

# ── META-INF/container.xml ──────────────────────────────────
container_xml = """<?xml version="1.0" encoding="UTF-8" standalone="no"?>
<container version="1.0" xmlns="urn:xmind:xmap:xmlns:container:1.0">
  <rootfile full-path="content.xml" media-type="application/xmind+xml"/>
</container>"""

# ── meta.xml ────────────────────────────────────────────────
meta_xml = f"""<?xml version="1.0" encoding="UTF-8" standalone="no"?>
<meta xmlns="urn:xmind:xmap:xmlns:meta:2.0" version="2.0">
  <Create-Time>{ts_ms()}</Create-Time>
  <Modify-Time>{ts_ms()}</Modify-Time>
  <Creator-Name>CodeFlicker</Creator-Name>
  <Creator-Version>1.0</Creator-Version>
</meta>"""

# ── 打包 ZIP ────────────────────────────────────────────────
output_path = "设计Skill体系.xmind"
content_xml_str = pretty_xml(root_el)

with zipfile.ZipFile(output_path, "w", zipfile.ZIP_DEFLATED) as zf:
    zf.writestr("content.xml", content_xml_str)
    zf.writestr("META-INF/container.xml", container_xml)
    zf.writestr("meta.xml", meta_xml)

size = os.path.getsize(output_path)
print(f"✅ 已生成: {os.path.abspath(output_path)}")
print(f"   格式:     XMind 8 XML (content.xml)")
print(f"   文件大小: {size:,} bytes")

# 验证 ZIP 结构
with zipfile.ZipFile(output_path, "r") as zf:
    names = zf.namelist()
    print(f"   ZIP内容: {names}")
