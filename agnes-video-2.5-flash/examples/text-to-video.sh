#!/bin/bash
# 文生视频示例
# 使用 agnes-video-2.5-flash 生成视频

API_KEY="your-api-key-here"
BASE_URL="https://api.agnes-ai.cn/v1"

echo "🎬 提交文生视频请求..."

RESPONSE=$(curl -sS -X POST "${BASE_URL}/videos" \
  -H "Authorization: Bearer ${API_KEY}" \
  -H "Content-Type: application/json" \
  -d '{
    "model": "agnes-video-2.5-flash",
    "prompt": "雨后的未来城市街道，霓虹灯倒映在地面，一辆银色跑车缓慢驶过，电影级运镜，自然环境声",
    "seconds": "5",
    "mode": "text",
    "size": "720P",
    "aspect_ratio": "16:9"
  }')

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
