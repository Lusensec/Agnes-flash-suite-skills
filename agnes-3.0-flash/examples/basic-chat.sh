#!/bin/bash
# 基础聊天示例
# 使用 agnes-3.0-flash 进行对话

API_KEY="your-api-key-here"
BASE_URL="https://api.agnes-ai.cn/v1"

echo "💬 发送聊天请求..."

RESPONSE=$(curl -sS -X POST "${BASE_URL}/chat/completions" \
  -H "Authorization: Bearer ${API_KEY}" \
  -H "Content-Type: application/json" \
  -d '{
    "model": "agnes-3.0-flash",
    "messages": [
      {
        "role": "system",
        "content": "You are a helpful AI assistant."
      },
      {
        "role": "user",
        "content": "Explain how autonomous agents use tools to complete tasks."
      }
    ],
    "temperature": 0.7,
    "max_tokens": 1024
  }')

echo "📥 响应："
echo "$RESPONSE" | jq .

CONTENT=$(echo "$RESPONSE" | jq -r '.choices[0].message.content')
echo ""
echo "💭 模型回复："
echo "$CONTENT"
