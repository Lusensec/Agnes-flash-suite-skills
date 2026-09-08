#!/usr/bin/env python3
"""
Thinking 模式示例 - 使用 agnes-2.5-flash 进行深度推理
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

print("🧠 发送 Thinking 模式请求...")

payload = {
    "model": "agnes-2.5-flash",
    "messages": [
        {"role": "user", "content": "Help me write a Python script to process a CSV file and generate a summary report."}
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

print("📥 响应：")
print(json.dumps(result, indent=2, ensure_ascii=False))

content = result["choices"][0]["message"]["content"]
print("\n💭 模型思考过程 + 回复：")
print(content)
