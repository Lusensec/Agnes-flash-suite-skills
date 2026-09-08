#!/usr/bin/env python3
"""
工具调用示例 - 使用 agnes-3.0-flash 进行 Function Calling
"""

import json
import sys
import urllib.request
import os

# 加载 .env 文件（优先读当前目录）
sys.path.insert(0, os.path.join(os.path.dirname(__file__), "..", "..", "utils"))
try:
    import load_env as env_loader
    env_loader.load_env_file()
except Exception:
    pass

API_KEY = os.environ.get("AGNESAI_API_KEY", "your-api-key-here")
BASE_URL = "https://api.agnes-ai.cn/v1"

print("🔧 发送工具调用请求...")

payload = {
    "model": "agnes-3.0-flash",
    "messages": [
        {"role": "user", "content": "What is the weather like in Singapore today?"}
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
}

req = urllib.request.Request(
    f"{BASE_URL}/chat/completions",
    data=json.dumps(payload).encode("utf-8"),
    headers={
        "Authorization": f"Bearer {API_KEY}",
        "Content-Type": "application/json"
    },
    method="POST"
)

with urllib.request.urlopen(req) as resp:
    result = json.loads(resp.read().decode("utf-8"))

print("📥 响应：")
print(json.dumps(result, indent=2, ensure_ascii=False))

message = result["choices"][0]["message"]
tool_calls = message.get("tool_calls")

print("\n🔧 工具调用：")
if tool_calls:
    print(json.dumps(tool_calls, indent=2, ensure_ascii=False))
    print("\n⚠️ 请实现工具执行逻辑，并将结果发送回模型")
else:
    print("无工具调用")
