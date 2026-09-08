#!/bin/bash
# 工具调用示例
# 使用 agnes-3.0-flash 进行 Function Calling

API_KEY="your-api-key-here"
BASE_URL="https://api.agnes-ai.cn/v1"

echo "🔧 发送工具调用请求..."

RESPONSE=$(curl -sS -X POST "${BASE_URL}/chat/completions" \
  -H "Authorization: Bearer ${API_KEY}" \
  -H "Content-Type: application/json" \
  -d '{
    "model": "agnes-3.0-flash",
    "messages": [
      {
        "role": "user",
        "content": "What is the weather like in Singapore today?"
      }
    ],
    "tools": [
      {
        "type": "function",
        "function": {
          "name": "get_weather",
          "description": "Get the current weather for a location",
          "parameters": {
            "type": "object",
            "properties": {
              "location": {
                "type": "string",
                "description": "The city and country"
              }
            },
            "required": ["location"]
          }
        }
      }
    ]
  }')

echo "📥 响应："
echo "$RESPONSE" | jq .

# 提取工具调用
TOOL_CALLS=$(echo "$RESPONSE" | jq -r '.choices[0].message.tool_calls')
echo ""
echo "🔧 工具调用："
echo "$TOOL_CALLS"

# 如果有工具调用，可以继续执行工具并发送结果
if [ "$TOOL_CALLS" != "null" ] && [ -n "$TOOL_CALLS" ]; then
  echo ""
  echo "⚠️ 请实现工具执行逻辑，并将结果发送回模型"
fi
