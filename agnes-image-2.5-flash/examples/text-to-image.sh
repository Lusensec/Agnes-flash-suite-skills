#!/bin/bash
# 文生图示例 - URL 输出
# 使用 agnes-image-2.5-flash 生成图像

API_KEY="your-api-key-here"
BASE_URL="https://api.agnes-ai.cn/v1"

echo "🎨 提交文生图请求（URL 输出）..."

RESPONSE=$(curl -sS -X POST "${BASE_URL}/images/generations" \
  -H "Authorization: Bearer ${API_KEY}" \
  -H "Content-Type: application/json" \
  -d '{
    "model": "agnes-image-2.5-flash",
    "prompt": "A luminous floating city above a misty canyon at sunrise, cinematic realism, wide angle, rich architectural details, soft golden light, high visual density",
    "size": "2K",
    "ratio": "16:9",
    "extra_body": {
      "response_format": "url"
    }
  }')

echo "📥 响应："
echo "$RESPONSE" | jq .

IMAGE_URL=$(echo "$RESPONSE" | jq -r '.data[0].url')
if [ -z "$IMAGE_URL" ] || [ "$IMAGE_URL" = "null" ]; then
  echo "❌ 获取图片 URL 失败"
  exit 1
fi

echo "✅ 图片生成完成！"
echo "🖼️ 图片地址：$IMAGE_URL"
