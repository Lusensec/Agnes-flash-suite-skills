#!/usr/bin/env python3
"""
查询视频任务结果
用法：python query-video.py <video_id> [api_key]
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

VIDEO_ID = sys.argv[1] if len(sys.argv) > 1 else None
API_KEY = sys.argv[2] if len(sys.argv) > 2 else os.environ.get("AGNESAI_API_KEY", "your-api-key-here")

if not VIDEO_ID:
    print("使用方法：python query-video.py <video_id> [api_key]")
    print("")
    print("示例：")
    print("  python query-video.py abc123 sk-xxx")
    sys.exit(1)

print("🔍 查询视频任务状态...")
print(f"📹 Video ID: {VIDEO_ID}")
print("")

POLL_URL = "https://api.agnes-ai.cn/agnesapi"
MAX_RETRIES = 120
RETRY_INTERVAL = 5

for i in range(1, MAX_RETRIES + 1):
    poll_req = urllib.request.Request(
        f"{POLL_URL}?video_id={VIDEO_ID}&model_name=agnes-video-2.5-flash",
        headers={"Authorization": f"Bearer {API_KEY}"}
    )
    with urllib.request.urlopen(poll_req) as resp:
        result = json.loads(resp.read().decode("utf-8"))

    status = result.get("status")
    progress = result.get("progress", 0)
    print(f"🔄 状态: {status}, 进度: {progress}%")

    if status == "completed":
        video_url = result.get("metadata", {}).get("url") or result.get("url") or result.get("video_url")
        print("")
        print("✅ 视频生成完成！")
        print(f"📹 视频地址：{video_url}")
        print("")
        print("完整响应：")
        print(json.dumps(result, indent=2, ensure_ascii=False))
        sys.exit(0)
    elif status == "failed":
        error_msg = (result.get("error") or {}).get("message") or result.get("error") or "未知错误"
        print("")
        print(f"❌ 视频生成失败：{error_msg}")
        print("")
        print("完整响应：")
        print(json.dumps(result, indent=2, ensure_ascii=False))
        sys.exit(1)

    if i % 10 == 0:
        print("⏳ 继续等待...")

print(f"⏱️ 超时：等待超过 {MAX_RETRIES}x{RETRY_INTERVAL} 秒")
sys.exit(1)
