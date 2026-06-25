# references/tailwind-bridge.md — Token → Tailwind 转换表

> 本文件将 `design/themes/` 的 CSS Token 映射为 Tailwind CSS `theme.extend` 配置。  
> 使用 Tailwind CSS + Headless UI 技术栈时，在 Phase 2 同步生成此配置。

---

## 使用方式

将对应主题的配置复制到项目 `tailwind.config.js`：

```javascript
/** @type {import('tailwindcss').Config} */
module.exports = {
  content: ['./src/**/*.{vue,ts,tsx}'],
  theme: {
    extend: {
      // 粘贴下方对应主题的 extend 内容
    },
  },
};
```

---

## 主题 A — 企业亮色（数平蓝，默认主题）

```javascript
colors: {
  primary:   { DEFAULT: '#2563F4', dark: '#1E54D4', light: '#EBF1FE',
               50: '#F4F7FE', 100: '#EBF1FE', 300: '#93B4FB', 400: '#6090F8',
               500: '#2563F4', 600: '#1E54D4', 700: '#1844AA' },
  'bg-page':  '#F7F8FA',
  'bg-card':  '#FFFFFF',
  'bg-hover': '#F0F2F5',
  'text-primary':   '#1A1D2E',
  'text-secondary': '#4B4D63',
  'text-muted':     '#9A9CB0',
  'text-inverse':   '#FFFFFF',
  positive: '#18A058',
  negative: '#F04848',
  warning:  '#F0800A',
  border:        '#DFE0E8',
  'border-focus': '#2563F4',
},
borderRadius: { card: '8px', btn: '6px', tag: '4px', input: '6px' },
boxShadow: {
  sm: '0 1px 4px rgba(37,99,244,0.06)',
  md: '0 4px 12px rgba(37,99,244,0.10)',
  lg: '0 8px 24px rgba(37,99,244,0.14)',
},
fontSize: { xl: '24px', lg: '18px', base: '14px', sm: '12px', xs: '11px' },
```

---

## 主题 B — 深色专业

```javascript
colors: {
  primary:   { DEFAULT: '#4B8EF5', dark: '#2563F4', light: 'rgba(75,142,245,0.15)' },
  'bg-page':  '#111827',
  'bg-card':  '#1F2937',
  'bg-hover': '#374151',
  'text-primary':   '#F9FAFB',
  'text-secondary': '#D1D5DB',
  'text-muted':     '#6B7280',
  'text-inverse':   '#111827',
  positive: '#34D399',
  negative: '#F87171',
  warning:  '#FBBF24',
  border:        '#374151',
  'border-focus': '#4B8EF5',
},
borderRadius: { card: '8px', btn: '6px', tag: '4px', input: '6px' },
boxShadow: {
  sm: '0 1px 4px rgba(0,0,0,0.3)',
  md: '0 4px 12px rgba(0,0,0,0.4)',
  lg: '0 8px 24px rgba(0,0,0,0.5)',
},
```

---

## 主题 C — 编辑排版

```javascript
colors: {
  primary:   { DEFAULT: '#1A1A1A', dark: '#000000', light: '#F5F5F5' },
  'bg-page':  '#FAFAF8',
  'bg-card':  '#FFFFFF',
  'bg-hover': '#F5F5F0',
  'text-primary':   '#1A1A1A',
  'text-secondary': '#555555',
  'text-muted':     '#999999',
  positive: '#2D7A3E',
  negative: '#CC3333',
  warning:  '#B45309',
  border:        '#E5E5E0',
  accent:        '#C8956C',
},
borderRadius: { card: '2px', btn: '2px', tag: '2px', input: '2px' },
boxShadow: {
  sm: '0 1px 3px rgba(0,0,0,0.08)',
  md: '0 2px 8px rgba(0,0,0,0.10)',
},
fontFamily: {
  serif: ['Georgia', 'Noto Serif SC', 'serif'],
  sans:  ['-apple-system', 'PingFang SC', 'sans-serif'],
},
```

---

## 主题 D — 极简轻量

```javascript
colors: {
  primary:   { DEFAULT: '#18181B', dark: '#09090B', light: '#F4F4F5' },
  'bg-page':  '#FFFFFF',
  'bg-card':  '#FAFAFA',
  'bg-hover': '#F4F4F5',
  'text-primary':   '#18181B',
  'text-secondary': '#71717A',
  'text-muted':     '#A1A1AA',
  positive: '#16A34A',
  negative: '#DC2626',
  warning:  '#D97706',
  border:        '#E4E4E7',
  'border-focus': '#18181B',
},
borderRadius: { card: '6px', btn: '6px', tag: '4px', input: '6px' },
boxShadow: {
  sm: '0 1px 2px rgba(0,0,0,0.05)',
  md: '0 1px 4px rgba(0,0,0,0.08)',
  lg: '0 2px 8px rgba(0,0,0,0.10)',
},
```

---

## 主题 E — 卡片网格（Bold & Bento）

```javascript
colors: {
  primary:   { DEFAULT: '#0066FF', dark: '#0052CC', light: '#EBF0FF' },
  'bg-page':  '#F0F0F0',
  'bg-card':  '#FFFFFF',
  'bg-hover': '#E8E8E8',
  'text-primary':   '#0A0A0A',
  'text-secondary': '#404040',
  'text-muted':     '#808080',
  positive: '#00C851',
  negative: '#FF4444',
  warning:  '#FF8800',
  border:        '#D0D0D0',
  accent:        '#FF3366',
  'accent-2':    '#FFCC00',
},
borderRadius: { card: '12px', btn: '8px', tag: '6px', input: '8px' },
boxShadow: {
  sm: '2px 2px 0px #0A0A0A',
  md: '4px 4px 0px #0A0A0A',
  lg: '6px 6px 0px #0A0A0A',
},
```

---

## 主题 F — 深色霓虹（DataAgent 风格）

```javascript
colors: {
  primary:   { DEFAULT: '#00C8FF', dark: '#00A0CC', light: 'rgba(0,200,255,0.12)' },
  'bg-page':  '#050F1A',
  'bg-card':  '#0A1929',
  'bg-hover': '#0F2540',
  'text-primary':   '#E8F4FF',
  'text-secondary': '#8BAFC8',
  'text-muted':     '#4A6B85',
  positive: '#00E5A0',
  negative: '#FF5555',
  warning:  '#FFB800',
  border:        '#1A3A5C',
  'border-focus': '#00C8FF',
  neon:      '#00C8FF',
  'neon-2':  '#8B5CF6',
},
borderRadius: { card: '8px', btn: '6px', tag: '4px', input: '6px' },
boxShadow: {
  sm: '0 1px 4px rgba(0,200,255,0.10)',
  md: '0 0 12px rgba(0,200,255,0.15)',
  lg: '0 0 24px rgba(0,200,255,0.20)',
  neon: '0 0 8px rgba(0,200,255,0.4), 0 0 20px rgba(0,200,255,0.2)',
},
```

---

## Headless UI 组件使用示例

以下展示 Tailwind Token + Headless UI 的标准写法：

```vue
<!-- 使用 Headless UI Tab 组件，注入主题 class -->
<template>
  <TabGroup>
    <TabList class="flex gap-1 border-b border-border">
      <Tab
        v-for="tab in tabs"
        :key="tab"
        v-slot="{ selected }"
        class="outline-none"
      >
        <button
          :class="[
            'px-4 py-2 text-sm font-medium transition-colors',
            selected
              ? 'text-primary border-b-2 border-primary'
              : 'text-text-secondary hover:text-text-primary'
          ]"
        >
          {{ tab }}
        </button>
      </Tab>
    </TabList>

    <TabPanels class="mt-4">
      <TabPanel v-for="tab in tabs" :key="tab">
        <!-- 面板内容 -->
      </TabPanel>
    </TabPanels>
  </TabGroup>
</template>
```

> 切换主题只需更新 `tailwind.config.js`，所有 class 语义（`text-primary` / `border-border`）自动跟随变化。
