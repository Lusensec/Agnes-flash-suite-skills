#!/bin/bash
# 查询视频任务结果
# 使用方法：./query-video.sh <video_id>

VIDEO_ID="${1}"
API_KEY="${2:-your-api-key-here}"

if [ -z "$VIDEO_ID" ]; then
  echo "使用方法：$0 <video_id> [api_key]"
  echo ""
  echo "示例："
  echo "  $0 abc123 sk-xxx"
  exit 1
fi

echo "🔍 查询视频任务状态..."
echo "📹 Video ID: $VIDEO_ID"
echo ""

# 轮询查询
MAX_RETRIES=120
RETRY_INTERVAL=5

for i in $(seq 1 $MAX_RETRIES); do
  QUERY_RESPONSE=$(curl -sS "https://api.agnes-ai.cn/agnesapi?video_id=${VIDEO_ID}&model_name=agnes-video-2.5-flash" \
    -H "Authorization: Bearer ${API_KEY}")
  
  STATUS=$(echo "$QUERY_RESPONSE" | jq -r '.status')
  PROGRESS=$(echo "$QUERY_RESPONSE" | jq -r '.progress')
  
  echo "🔄 状态: $STATUS, 进度: ${PROGRESS}%"
  
  if [ "$STATUS" = "completed" ]; then
    VIDEO_URL=$(echo "$QUERY_RESPONSE" | jq -r '.metadata.url // .url // .video_url')
    echo ""
    echo "✅ 视频生成完成！"
    echo "📹 视频地址：$VIDEO_URL"
    echo ""
    echo "完整响应："
    echo "$QUERY_RESPONSE" | jq .
    exit 0
  elif [ "$STATUS" = "failed" ]; then
    ERROR_MSG=$(echo "$QUERY_RESPONSE" | jq -r '.error.message // .error // "未知错误"')
    echo ""
    echo "❌ 视频生成失败：$ERROR_MSG"
    echo ""
    echo "完整响应："
    echo "$QUERY_RESPONSE" | jq .
    exit 1
  fi
  
  # 每 10 次打印一次进度，避免刷屏
  if [ $((i % 10)) -eq 0 ]; then
    echo "⏳ 继续等待..."
  fi
done

echo "⏱️ 超时：等待超过 ${MAX_RETRIES}x${RETRY_INTERVAL} 秒"
exit 1
