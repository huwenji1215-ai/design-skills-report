/**
 * 万擎 API 本地代理（解决 CORS 问题）
 * 启动：node wq-proxy.js
 * 代理地址：http://localhost:3001/v1/chat/completions
 */
const http = require('http');
const https = require('https');

const PROXY_PORT = 3001;
const WQ_HOST = 'wanqing-api.corp.kuaishou.com';

const server = http.createServer((req, res) => {
  // CORS headers
  res.setHeader('Access-Control-Allow-Origin', '*');
  res.setHeader('Access-Control-Allow-Methods', 'GET, POST, OPTIONS');
  res.setHeader('Access-Control-Allow-Headers', 'Content-Type, Authorization');

  if (req.method === 'OPTIONS') {
    res.writeHead(204);
    res.end();
    return;
  }

  let body = '';
  req.on('data', chunk => body += chunk);
  req.on('end', () => {
    const options = {
      hostname: WQ_HOST,
      port: 443,
      path: req.url,
      method: req.method,
      headers: {
        ...req.headers,
        host: WQ_HOST,
      }
    };
    delete options.headers['origin'];
    delete options.headers['referer'];

    const proxyReq = https.request(options, proxyRes => {
      res.writeHead(proxyRes.statusCode, {
        'Content-Type': proxyRes.headers['content-type'] || 'application/json',
        'Access-Control-Allow-Origin': '*',
      });
      proxyRes.pipe(res);
    });

    proxyReq.on('error', err => {
      console.error('代理请求失败:', err.message);
      res.writeHead(502);
      res.end(JSON.stringify({ error: err.message }));
    });

    if (body) proxyReq.write(body);
    proxyReq.end();
  });
});

server.listen(PROXY_PORT, () => {
  console.log(`✅ 万擎代理已启动：http://localhost:${PROXY_PORT}`);
  console.log(`   将请求转发至：https://${WQ_HOST}`);
  console.log(`   在平台 Settings 页把 Base URL 改为：http://localhost:${PROXY_PORT}`);
});
