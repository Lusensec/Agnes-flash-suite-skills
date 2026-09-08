#!/bin/bash
# 图生图示例 - URL 输出
# 使用 agnes-image-2.5-flash 进行图像编辑/风格迁移

API_KEY="your-api-key-here"
BASE_URL="https://api.agnes-ai.cn/v1"

# 输入图片 URL（可替换为实际图片地址）
INPUT_IMAGE="${1:-https://example.com/input-image.png}"

echo "🎨 提交图生图请求（URL 输出）..."
echo "📷 输入图片：$INPUT_IMAGE"

RESPONSE=$(curl -sS -X POST "${BASE_URL}/images/generations" \
  -H "Authorization: Bearer ${API_KEY}" \
  -H "Content-Type: application/json" \
  -d "{
    \"model\": \"agnes-image-2.5-flash\",
    \"prompt\": \"Transform the scene into a rain-soaked cyberpunk night with neon reflections while preserving the original composition\",
    \"size\": \"2K\",
    \"ratio\": \"16:9\",
    \"extra_body\": {
      \"image\": [\"${INPUT_IMAGE}\"],
      \"response_format\": \"url\"
    }
  }")

echo "📥 响应："
echo "$RESPONSE" | jq .

IMAGE_URL=$(echo "$RESPONSE" | jq -r '.data[0].url')
if [ -z "$IMAGE_URL" ] || [ "$IMAGE_URL" = "null" ]; then
  echo "❌ 获取图片 URL 失败"
  exit 1
fi

echo "✅ 图片生成完成！"
echo "🖼️ 图片地址：$IMAGE_URL"
