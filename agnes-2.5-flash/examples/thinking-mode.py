#!/usr/bin/env python3
"""
Thinking 模式示例 - 使用 agnes-2.5-flash 进行深度推理
用法：python thinking-mode.py [问题]
"""

import json
import os
import sys
import urllib.request

import load_env
load_env.load_env()

API_KEY = os.environ.get("AGNESAI_API_KEY", "your-api-key-here")
BASE_URL = "https://api.agnes-ai.cn/v1"

USER_MESSAGE = sys.argv[1] if len(sys.argv) > 1 else "Help me write a Python script to process a CSV file and generate a summary report."

print("发送 Thinking 模式请求...")
print(f"  用户: {USER_MESSAGE}")

payload = {
    "model": "agnes-2.5-flash",
    "messages": [
        {"role": "user", "content": USER_MESSAGE}
    ],
    "chat_template_kwargs": {"enable_thinking": True},
    "max_tokens": 2048
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

print("响应：")
print(json.dumps(result, indent=2, ensure_ascii=False))

content = result["choices"][0]["message"]["content"]
print("\n模型思考过程 + 回复：")
print(content)
