# references/component-protocol.md — 组件沉淀协议

> 对应会议纪要第 3 点：「项目代码里面那些提前预制好的前端组件」。  
> 定义官方组件库 / 用户上传组件 / Agent 可搜索调用的三层协议。  
> **@信红林 负责：组件生成指导 Skill + 组件渲染引擎 + 组件沉淀 creator skill**

---

## 三层组件体系

```
Layer 1：官方组件库（Official Library）
  → 由设计+前端联合维护，通过质量评审
  → Agent 优先搜索调用，直接可用
  → 需要制定搜索协议（见下方）

Layer 2：用户上传组件（User Contributed）
  → 用户在项目中沉淀的可复用组件
  → 经过 creator skill 标准化后可供 Agent 搜索
  → 需要用户授权才可被其他项目调用

Layer 3：Agent 临时生成（On-demand Generated）
  → 满足当前需求但未沉淀
  → 使用 component-protocol 规范格式，方便未来沉淀
```

---

## 组件元数据格式（协议草案）

每个可被 Agent 搜索的组件需附带以下元数据：

```typescript
interface ComponentMeta {
  // 基础信息
  id: string;           // 唯一标识，如 'kpi-card-v2'
  name: string;         // 展示名，如 'KPI 数据卡片'
  description: string;  // 用途描述（Agent 搜索匹配用）
  tags: string[];       // 标签，如 ['数据', '卡片', 'KPI', 'dashboard']
  scene: string[];      // 适用场景：['data-report', 'dashboard']
  theme: string[];      // 兼容主题：['A', 'B', 'F']

  // 技术信息
  props: PropDefinition[];    // 入参列表
  slots?: SlotDefinition[];   // 插槽
  emits?: string[];           // 事件

  // 来源
  source: 'official' | 'user';
  author?: string;
  version: string;
  updatedAt: string;
}
```

---

## Agent 搜索组件的调用流程（待实现）

```
用户说"帮我做一个 KPI 卡片"
  ↓
Agent 调用组件搜索接口
  参数：{ keywords: ['KPI', '卡片'], scene: 'dashboard', theme: 'A' }
  ↓
返回匹配组件列表（按相关度排序）
  ↓
Agent 选择最匹配组件，按其 props 规范注入数据
  ↓
若无匹配组件，按 design/data-components/kpi-card.md 规范生成
  生成后可触发 creator skill 将其沉淀为 Layer 2 用户组件
```

---

## 当前可用的官方数据组件

以下组件已有规范文件，可直接按规范实现：

| 组件 | 规范文件 | 适用场景 |
|------|---------|---------|
| KPI 数据卡片 | `design/data-components/kpi-card.md` | data-report / dashboard |
| ECharts 图表 | `design/data-components/echarts-config.md` | data-report / dashboard |
| 数据表格 | `design/data-components/table-spec.md` | data-report / tool-app |
| 语义色标签 | `design/data-components/semantic-colors.md` | 所有场景 |
| 站点框架组件 | `design/data-components/site-chrome.md` | 所有场景 |

---

## 组件渲染引擎（待补充）

> **@信红林** 负责设计渲染引擎方案，将协议化的组件 JSON 渲染为可视化预览。  
> 预期能力：
> - 在对话界面中实时预览组件效果
> - 支持 props 参数的可视化调试
> - 输出可直接用于项目的 Vue SFC 代码

---

## 组件沉淀 Creator Skill（待补充）

> **@信红林** 负责设计 creator skill，流程：
> 1. 用户标记"沉淀这个组件"
> 2. Agent 自动提取组件代码 + 分析 props/slots/events
> 3. 生成标准 ComponentMeta
> 4. 写入组件库，供后续搜索调用
