#!/bin/bash
# 文生图示例 - Base64 输出
# 使用 agnes-image-2.5-flash 生成图像（返回 Base64）

API_KEY="your-api-key-here"
BASE_URL="https://api.agnes-ai.cn/v1"

echo "🎨 提交文生图请求（Base64 输出）..."

RESPONSE=$(curl -sS -X POST "${BASE_URL}/images/generations" \
  -H "Authorization: Bearer ${API_KEY}" \
  -H "Content-Type: application/json" \
  -d '{
    "model": "agnes-image-2.5-flash",
    "prompt": "A clean product photo of a glass cube on a white studio background, soft shadows, high detail",
    "size": "1K",
    "ratio": "1:1",
    "return_base64": true
  }')

echo "📥 响应："
echo "$RESPONSE" | jq '.data[0].b64_json | length'

B64_DATA=$(echo "$RESPONSE" | jq -r '.data[0].b64_json')
if [ -z "$B64_DATA" ] || [ "$B64_DATA" = "null" ]; then
  echo "❌ 获取 Base64 数据失败"
  exit 1
fi

echo "✅ 图片生成完成！"
echo "📊 Base64 长度：${#B64_DATA} 字符"
echo ""
echo "Data URI 格式："
echo "data:image/png;base64,${B64_DATA:0:100}..."
