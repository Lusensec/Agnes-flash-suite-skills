#!/usr/bin/env python3
"""
基础聊天示例 - 使用 agnes-3.0-flash 进行对话
"""

import json
import urllib.request
import urllib.error
import os

API_KEY = os.environ.get("AGNESAI_API_KEY", "your-api-key-here")
BASE_URL = "https://api.agnes-ai.cn/v1"

print("💬 发送聊天请求...")

payload = {
    "model": "agnes-3.0-flash",
    "messages": [
        {"role": "system", "content": "You are a helpful AI assistant."},
        {"role": "user", "content": "Explain how autonomous agents use tools to complete tasks."}
    ],
    "temperature": 0.7,
    "max_tokens": 1024
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

content = result["choices"][0]["message"]["content"]
print("\n💭 模型回复：")
print(content)
