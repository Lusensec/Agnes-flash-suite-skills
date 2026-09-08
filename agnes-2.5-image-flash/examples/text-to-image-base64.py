#!/usr/bin/env python3
"""
文生图示例 - Base64 输出
使用 agnes-image-2.5-flash 生成图像（返回 Base64）
"""

import json
import urllib.request
import os

API_KEY = os.environ.get("AGNESAI_API_KEY", "your-api-key-here")
BASE_URL = "https://api.agnes-ai.cn/v1"

print("🎨 提交文生图请求（Base64 输出）...")

payload = {
    "model": "agnes-image-2.5-flash",
    "prompt": "A clean product photo of a glass cube on a white studio background, soft shadows, high detail",
    "size": "1K",
    "ratio": "1:1",
    "return_base64": True
}

req = urllib.request.Request(
    f"{BASE_URL}/images/generations",
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

b64_data = result["data"][0]["b64_json"]
if not b64_data:
    print("❌ 获取 Base64 数据失败")
    exit(1)

print("✅ 图片生成完成！")
print(f"📊 Base64 长度：{len(b64_data)} 字符")
print("\nData URI 格式：")
print(f"data:image/png;base64,{b64_data[:100]}...")
