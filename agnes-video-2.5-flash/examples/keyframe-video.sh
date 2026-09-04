#!/bin/bash
# 首尾帧控制示例
# 使用 agnes-video-2.5-flash 生成视频（指定开始和结束画面）

API_KEY="your-api-key-here"
BASE_URL="https://api.agnes-ai.cn/v1"

# 首帧和尾帧 URL（可替换为实际图片地址）
FIRST_FRAME="${1:-https://example.com/first.png}"
LAST_FRAME="${2:-https://example.com/last.png}"

echo "🎬 提交首尾帧控制视频请求..."
echo "📷 首帧：$FIRST_FRAME"
echo "📷 尾帧：$LAST_FRAME"

RESPONSE=$(curl -sS -X POST "${BASE_URL}/videos" \
  -H "Authorization: Bearer ${API_KEY}" \
  -H "Content-Type: application/json" \
  -d "{
    \"model\": \"agnes-video-2.5-flash\",
    \"prompt\": \"人物从首帧姿态自然转身走向窗边，镜头缓慢推进并平滑过渡到尾帧\",
    \"seconds\": \"5\",
    \"mode\": \"keyframe\",
    \"size\": \"720P\",
    \"first_frame\": \"${FIRST_FRAME}\",
    \"last_frame\": \"${LAST_FRAME}\"
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
