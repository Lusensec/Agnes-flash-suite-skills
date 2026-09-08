#!/bin/bash
# 多图合成示例
# 使用 agnes-image-2.5-flash 将多张参考图组合生成新图像

API_KEY="your-api-key-here"
BASE_URL="https://api.agnes-ai.cn/v1"

# 参考图片 URL（可替换为实际图片地址）
IMAGE1="${1:-https://example.com/character-1.png}"
IMAGE2="${2:-https://example.com/character-2.png}"

echo "🎨 提交多图合成请求..."
echo "📷 参考图片 1：$IMAGE1"
echo "📷 参考图片 2：$IMAGE2"

RESPONSE=$(curl -sS -X POST "${BASE_URL}/images/generations" \
  -H "Authorization: Bearer ${API_KEY}" \
  -H "Content-Type: application/json" \
  -d "{
    \"model\": \"agnes-image-2.5-flash\",
    \"prompt\": \"Combine the two characters into an intense fantasy battle scene, dynamic lighting, detailed background, cinematic composition\",
    \"size\": \"2K\",
    \"ratio\": \"1:1\",
    \"extra_body\": {
      \"image\": [
        \"${IMAGE1}\",
        \"${IMAGE2}\"
      ],
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
