#!/bin/bash
# 图像理解示例
# 使用 agnes-2.5-flash 分析图片

API_KEY="your-api-key-here"
BASE_URL="https://api.agnes-ai.cn/v1"

# 图片 URL（可替换为实际图片地址）
IMAGE_URL="${1:-https://example.com/image.jpg}"

echo "👁️ 发送图像理解请求..."
echo "📷 图片地址：$IMAGE_URL"

RESPONSE=$(curl -sS -X POST "${BASE_URL}/chat/completions" \
  -H "Authorization: Bearer ${API_KEY}" \
  -H "Content-Type: application/json" \
  -d "{
    \"model\": \"agnes-2.5-flash\",
    \"messages\": [
      {
        \"role\": \"user\",
        \"content\": [
          {
            \"type\": \"text\",
            \"text\": \"请详细描述这张图片的内容\"
          },
          {
            \"type\": \"image_url\",
            \"image_url\": {
              \"url\": \"${IMAGE_URL}\"
            }
          }
        ]
      }
    ]
  }")

echo "📥 响应："
echo "$RESPONSE" | jq .

CONTENT=$(echo "$RESPONSE" | jq -r '.choices[0].message.content')
echo ""
echo "💭 模型分析："
echo "$CONTENT"
