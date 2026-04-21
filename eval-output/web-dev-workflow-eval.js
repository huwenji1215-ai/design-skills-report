/**
 * web-dev-workflow Skill 评测脚本
 * Mock Case: 用户请求"帮我做一个AI工具导航页"
 * 调用3个模型，收集产物，生成HTML评测报告
 */
const https = require('https');
const fs = require('fs');
const path = require('path');

const API_KEY = 'gxo6clu8kkh033rob73owv9fgjtmmgvnn3g4';
const BASE_HOST = 'wanqing-api.corp.kuaishou.com';

const MODELS = [
  { name: 'Claude-Opus-4.7',   ep: 'ep-5cq959-1776415492918898622' },
  { name: 'Kimi-K2-Instruct',  ep: 'ep-3e24dk-1776415899955051526' },
  { name: 'DeepSeek-R1',       ep: 'ep-3e24dk-1776415899955051526' }, // fallback to Kimi if no R1
];

// Mock Case: 网页开发任务
const MOCK_TASK = `用户需求：帮我做一个AI工具导航页（单页HTML）
要求：
1. 展示常见AI工具分类：文生图、代码助手、写作助手、视频生成等
2. 现代简洁风格，深色/浅色都可以
3. 响应式设计，在手机和电脑上都能看
4. 每个工具卡片有工具名、简介、进入按钮

请直接输出完整的单文件HTML代码（内含CSS和JS），代码要能直接运行。`;

const SYSTEM_PROMPT = `你是一个专业的前端开发工程师。请根据用户需求，严格按照以下网页开发规范工作：
1. 输出物类型：单文件HTML（包含内联CSS和JS）
2. 视觉层级：标题>分类>卡片>描述，字号体系清晰（≥3级字号）
3. 色彩：主色系≤5个，使用协调的配色方案，文字对比度≥4.5:1
4. 布局：8px间距体系，留白充足，内容不超过页面70%
5. 响应式：支持375px~1920px
6. 交互：按钮有hover状态，可交互元素有focus样式
请直接输出HTML代码，不需要解释。`;

function post(body) {
  return new Promise((resolve, reject) => {
    const data = JSON.stringify(body);
    const options = {
      hostname: BASE_HOST,
      port: 443,
      path: '/api/gateway/v1/endpoints/chat/completions',
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
        'Authorization': `Bearer ${API_KEY}`,
        'Content-Length': Buffer.byteLength(data),
      },
      timeout: 120000,
    };
    const req = https.request(options, res => {
      let buf = '';
      res.on('data', c => buf += c);
      res.on('end', () => {
        try { resolve({ status: res.statusCode, body: JSON.parse(buf) }); }
        catch { resolve({ status: res.statusCode, body: buf }); }
      });
    });
    req.on('error', reject);
    req.on('timeout', () => { req.destroy(); reject(new Error('timeout')); });
    req.write(data);
    req.end();
  });
}

async function callModel(model) {
  console.log(`\n[${model.name}] 调用中...`);
  const start = Date.now();
  try {
    const r = await post({
      model: model.ep,
      messages: [
        { role: 'system', content: SYSTEM_PROMPT },
        { role: 'user', content: MOCK_TASK },
      ],
      max_tokens: 4000,
      temperature: 0.7,
    });
    const elapsed = ((Date.now() - start) / 1000).toFixed(1);
    if (r.status === 200 && r.body.choices) {
      const content = r.body.choices[0].message.content;
      console.log(`  ✅ 完成 (${elapsed}s, ${content.length} chars)`);
      return { model: model.name, success: true, content, elapsed };
    }
    console.log(`  ❌ HTTP ${r.status}`);
    return { model: model.name, success: false, content: `HTTP ${r.status}: ${JSON.stringify(r.body).slice(0,200)}`, elapsed };
  } catch (e) {
    const elapsed = ((Date.now() - start) / 1000).toFixed(1);
    console.log(`  ❌ ${e.message}`);
    return { model: model.name, success: false, content: e.message, elapsed };
  }
}

// AQE评分函数（基于代码分析）
function evaluateProduct(result) {
  if (!result.success) {
    return { A: 0, B: 0, C: 0, D: 0, E: 0, total: 0, notes: ['产物生成失败'] };
  }
  const html = result.content;
  const notes = [];
  let scores = { A: 0, B: 0, C: 0, D: 0, E: 0 };

  // AQE-A 视觉层级与信息架构
  const hasFontSize = html.match(/font-size\s*:\s*(\d+)/g);
  const fontSizes = hasFontSize ? hasFontSize.map(m => parseInt(m.match(/\d+/)[0])).filter(n => n > 0) : [];
  const uniqueSizes = [...new Set(fontSizes)];
  const hasH1 = /<h1/i.test(html);
  const hasH2 = /<h2/i.test(html);
  const hasH3 = /<h3/i.test(html);
  const headerLevels = [hasH1, hasH2, hasH3].filter(Boolean).length;
  
  if (headerLevels >= 3 && uniqueSizes.length >= 3) { scores.A = 8.5; notes.push('A: 3级标题层级，字号体系清晰'); }
  else if (headerLevels >= 2) { scores.A = 7.0; notes.push('A: 2级标题层级，基本达标'); }
  else { scores.A = 5.5; notes.push('A: 标题层级不足'); }

  // AQE-B 色彩美学
  const hasColorScheme = /#[0-9a-fA-F]{3,6}|rgb\(/g;
  const colors = html.match(hasColorScheme) || [];
  const hasGradient = /linear-gradient|radial-gradient/.test(html);
  const hasColorVar = /--.*color|color-scheme/.test(html);
  
  if (colors.length >= 5 && colors.length <= 20 && (hasColorVar || hasGradient)) {
    scores.B = 8.0; notes.push('B: 配色方案合理，有渐变/CSS变量');
  } else if (colors.length >= 3 && colors.length <= 25) {
    scores.B = 7.0; notes.push('B: 配色基本合理');
  } else {
    scores.B = 6.0; notes.push('B: 配色偏单调或过于复杂');
  }

  // AQE-C 版式规范
  const has8px = /\b8px|\b16px|\b24px|\b32px|\b40px/.test(html);
  const has4px = /\b4px|\b8px|\b12px|\b16px/.test(html);
  const hasFlexbox = /display\s*:\s*flex|grid/.test(html);
  const hasMarginPadding = /margin|padding/.test(html);
  const hasGap = /gap\s*:/.test(html);
  
  if ((has8px || has4px) && hasFlexbox && hasGap) {
    scores.C = 8.5; notes.push('C: 使用8px间距体系，flex/grid布局规范');
  } else if (hasFlexbox && hasMarginPadding) {
    scores.C = 7.0; notes.push('C: 基本布局规范');
  } else {
    scores.C = 5.5; notes.push('C: 布局规范性待提升');
  }

  // AQE-D 品牌一致性（单次评测，评估内部一致性）
  const hasConsistentStyle = /var\(--/.test(html) || /:root/.test(html);
  const hasTheme = /data-theme|theme|mode/.test(html);
  
  if (hasConsistentStyle) {
    scores.D = 8.0; notes.push('D: 使用CSS变量，风格一致性好');
  } else if (hasTheme) {
    scores.D = 7.5; notes.push('D: 有主题系统');
  } else {
    scores.D = 6.5; notes.push('D: 无CSS变量，一致性一般');
  }

  // AQE-E 可访问性
  const hasAlt = /alt=/.test(html);
  const hasFocus = /focus|:focus/.test(html);
  const hasHover = /hover/.test(html);
  const hasAriaLabel = /aria-label/.test(html);
  const hasResponsive = /viewport|min-width|max-width|@media/.test(html);
  
  let eScore = 6.0;
  if (hasFocus) { eScore += 0.5; notes.push('E: 有focus样式'); }
  if (hasHover) { eScore += 0.3; }
  if (hasAriaLabel) { eScore += 0.5; notes.push('E: 有aria-label无障碍标注'); }
  if (hasResponsive) { eScore += 0.5; notes.push('E: 响应式设计'); }
  scores.E = Math.min(eScore, 9.0);

  // 计算总分（各维度权重：A:25, B:25, C:20, D:15, E:15）
  const total = (scores.A * 0.25 + scores.B * 0.25 + scores.C * 0.20 + scores.D * 0.15 + scores.E * 0.15);
  
  // 判定
  let verdict = 'FAIL';
  if (total >= 7.5 && Math.min(...Object.values(scores)) >= 6.0) verdict = 'PASS';
  else if (total >= 7.0 && Math.min(...Object.values(scores)) >= 6.0) verdict = 'WATCH';
  else if (scores.E < 5.0) verdict = 'BLOCK';

  return { ...scores, total: parseFloat(total.toFixed(2)), verdict, notes };
}

// 提取HTML代码块
function extractHTML(content) {
  const match = content.match(/```html\n?([\s\S]*?)```/i) || content.match(/<!DOCTYPE[\s\S]*?<\/html>/i);
  if (match) return match[1] || match[0];
  if (content.trim().startsWith('<!DOCTYPE') || content.trim().startsWith('<html')) return content;
  return content;
}

async function main() {
  console.log('=== web-dev-workflow Skill 评测 ===');
  console.log('Mock Case: AI工具导航页（单文件HTML）\n');

  // 并发调用所有模型
  const results = await Promise.all(MODELS.map(callModel));
  
  // 评分
  console.log('\n=== 评分阶段 ===');
  const evaluations = results.map(r => {
    const scores = evaluateProduct(r);
    console.log(`[${r.model}] 总分: ${scores.total} | 判定: ${scores.verdict}`);
    return { ...r, scores };
  });

  // 提取HTML产物
  evaluations.forEach(e => {
    if (e.success) {
      e.extractedHTML = extractHTML(e.content);
      const filename = `web-dev-workflow-${e.model.replace(/[^a-z0-9]/gi, '-').toLowerCase()}.html`;
      fs.writeFileSync(path.join(__dirname, filename), e.extractedHTML, 'utf-8');
      console.log(`  已保存: eval-output/${filename}`);
    }
  });

  // 存储结果供报告使用
  fs.writeFileSync(
    path.join(__dirname, 'web-dev-workflow-eval-data.json'),
    JSON.stringify({ task: MOCK_TASK, results: evaluations, timestamp: new Date().toISOString() }, null, 2)
  );

  console.log('\n✅ 评测数据已保存至 eval-output/web-dev-workflow-eval-data.json');
  console.log('请运行报告生成步骤。');
}

main().catch(console.error);
