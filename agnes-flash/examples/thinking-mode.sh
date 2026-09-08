#!/bin/bash
# Thinking 模式示例
# 使用 agnes-2.5-flash 进行深度推理

API_KEY="your-api-key-here"
BASE_URL="https://api.agnes-ai.cn/v1"

echo "🧠 发送 Thinking 模式请求..."

RESPONSE=$(curl -sS -X POST "${BASE_URL}/chat/completions" \
  -H "Authorization: Bearer ${API_KEY}" \
  -H "Content-Type: application/json" \
  -d '{
    "model": "agnes-2.5-flash",
    "messages": [
      {
        "role": "user",
        "content": "Help me write a Python script to process a CSV file and generate a summary report."
      }
    ],
    "chat_template_kwargs": {
      "enable_thinking": true
    },
    "max_tokens": 2048
  }')

echo "📥 响应："
echo "$RESPONSE" | jq .

CONTENT=$(echo "$RESPONSE" | jq -r '.choices[0].message.content')
echo ""
echo "💭 模型思考过程 + 回复："
echo "$CONTENT"
