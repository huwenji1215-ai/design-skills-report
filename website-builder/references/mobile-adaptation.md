# 移动端适配规范

> **当用户要求移动端支持时,以下规则全部强制执行。**

---

## 5-1 HTML 模板注入

在 `public/index.html` 的 `<head>` 开头添加(位于 `__APP_BASE__` 脚本之前):

```html
<script>
  window.adaptMobile = true;
</script>
<meta name="viewport" content="width=device-width, initial-scale=1.0">
```

注意:**不设置** `maximum-scale=1.0, user-scalable=no`。

## 5-2 App.vue 全局 CSS 基础

在 App.vue 的全局 `<style>`(不加 scoped)中添加:

```css
* {
    box-sizing: border-box;
}
body {
    margin: 0;
    padding: 0;
    font-size: 15px;
    line-height: 1.6;
    -webkit-text-size-adjust: 100%;
}
```

## 5-3 页面组件响应式规则

每个 `<style scoped>` 中必须包含移动端断点覆盖:

```css
/* PC 默认 */
.page-container {
    max-width: 1200px;
    margin: 0 auto;
    padding: 24px 32px;
}

/* 移动端(≤ 768px) */
@media (max-width: 768px) {
    .page-container {
        padding: 16px;
    }
    /* 字号缩小 */
    h1 { font-size: 24px; }
    h2 { font-size: 18px; }
}
```

## 5-4 多列布局适配

```css
/* PC:Grid 多列 */
.grid {
    display: grid;
    grid-template-columns: repeat(3, 1fr);
    gap: 24px;
}

/* 移动端:单列 */
@media (max-width: 768px) {
    .grid {
        grid-template-columns: 1fr;
        gap: 12px;
    }
}
```

## 5-5 表格响应式

```css
.table-wrapper {
    width: 100%;
    overflow-x: auto;
    -webkit-overflow-scrolling: touch;
}

table {
    min-width: 600px;
    width: 100%;
    border-collapse: collapse;
}
```

## 5-6 ECharts 图表容器(如有图表)

```css
.chart-container {
    width: 100%;
    height: 480px;
}

@media (max-width: 768px) {
    .chart-container {
        height: 300px;
    }
}
```

```javascript
// 监听窗口变化重绘
window.addEventListener('resize', () => {
    chart && chart.resize();
});
```
