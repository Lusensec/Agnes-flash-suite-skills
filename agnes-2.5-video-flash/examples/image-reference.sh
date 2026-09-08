#!/bin/bash
# 图片参考示例
# 使用 agnes-video-2.5-flash 生成视频（图片作为参考）

API_KEY="your-api-key-here"
BASE_URL="https://api.agnes-ai.cn/v1"

# 参考图片 URL（可替换为实际图片地址）
IMAGE_URL="${1:-https://example.com/character.png}"

echo "🎬 提交图片参考视频请求..."
echo "📷 参考图片：$IMAGE_URL"

RESPONSE=$(curl -sS -X POST "${BASE_URL}/videos" \
  -H "Authorization: Bearer ${API_KEY}" \
  -H "Content-Type: application/json" \
  -d "{
    \"model\": \"agnes-video-2.5-flash\",
    \"prompt\": \"以 <Picture 1> 中的角色和美术风格为参考，角色在花田中自然奔跑，保持外观一致\",
    \"seconds\": \"5\",
    \"mode\": \"reference\",
    \"size\": \"720P\",
    \"aspect_ratio\": \"16:9\",
    \"images\": [\"${IMAGE_URL}\"]
  }")

echo "📥 响应："
echo "$RESPONSE" | jq .

VIDEO_ID=$(echo "$RESPONSE" | jq -r '.video_id')
if [ -z "$VIDEO_ID" ] || [ "$VIDEO_ID" = "null" ]; then
  echo "❌ 获取 video_id 失败"
  exit 1
fi

echo "✅ 任务已提交，video_id: $VIDEO_ID"
echo "⏳ 开始轮询查询结果..."

# 轮询查询
MAX_RETRIES=120
RETRY_INTERVAL=5

for i in $(seq 1 $MAX_RETRIES); do
  sleep $RETRY_INTERVAL
  
  QUERY_RESPONSE=$(curl -sS "https://api.agnes-ai.cn/agnesapi?video_id=${VIDEO_ID}&model_name=agnes-video-2.5-flash" \
    -H "Authorization: Bearer ${API_KEY}")
  
  STATUS=$(echo "$QUERY_RESPONSE" | jq -r '.status')
  PROGRESS=$(echo "$QUERY_RESPONSE" | jq -r '.progress')
  
  echo "🔄 状态: $STATUS, 进度: ${PROGRESS}%"
  
  if [ "$STATUS" = "completed" ]; then
    VIDEO_URL=$(echo "$QUERY_RESPONSE" | jq -r '.metadata.url // .url // .video_url')
    echo "✅ 视频生成完成！"
    echo "📹 视频地址：$VIDEO_URL"
    exit 0
  elif [ "$STATUS" = "failed" ]; then
    ERROR_MSG=$(echo "$QUERY_RESPONSE" | jq -r '.error.message // .error // "未知错误"')
    echo "❌ 视频生成失败：$ERROR_MSG"
    exit 1
  fi
done

echo "⏱️ 超时：等待超过 ${MAX_RETRIES}x${RETRY_INTERVAL} 秒"
exit 1
