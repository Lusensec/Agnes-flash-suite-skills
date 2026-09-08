#!/usr/bin/env python3
"""
图像理解示例 - 使用 agnes-2.5-flash 分析图片
用法：python image-understanding.py [图片URL]
"""

# 加载 .env 文件（自动定位 skill 根目录）
_current_dir = os.path.dirname(os.path.abspath(__file__))
_skill_root = None
for _ in range(5):
    if os.path.exists(os.path.join(_current_dir, ".env.example")):
        _skill_root = _current_dir
        break
    _parent = os.path.dirname(_current_dir)
    if _parent == _current_dir:
        break
    _current_dir = _parent
_env_path = os.path.join(_skill_root or os.getcwd(), ".env")
if os.path.exists(_env_path):
    with open(_env_path, "r", encoding="utf-8") as _f:
        for _line in _f:
            _line = _line.strip()
            if not _line or _line.startswith("#"):
                continue
            _m = re.match(r"^([A-Za-z_][A-Za-z0-9_]*)=(.*)$", _line)
            if _m:
                _k, _v = _m.groups()
                _v = _v.strip().strip('"').strip("'")
                if _k not in os.environ:
                    os.environ[_k] = _v

API_KEY = os.environ.get("AGNESAI_API_KEY", "your-api-key-here")
BASE_URL = "https://api.agnes-ai.cn/v1"

IMAGE_URL = sys.argv[1] if len(sys.argv) > 1 else "https://example.com/image.jpg"

print("👁️ 发送图像理解请求...")
print(f"📷 图片地址：{IMAGE_URL}")

payload = {
    "model": "agnes-2.5-flash",
    "messages": [
        {
            "role": "user",
            "content": [
                {"type": "text", "text": "请详细描述这张图片的内容"},
                {
                    "type": "image_url",
                    "image_url": {"url": IMAGE_URL}
                }
            ]
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

content = result["choices"][0]["message"]["content"]
print("\n💭 模型分析：")
print(content)
