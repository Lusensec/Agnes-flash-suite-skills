#!/usr/bin/env python3
"""
加载 .env 文件中的环境变量
优先读当前目录的 .env，其次读环境变量
"""

import os
import re

def load_env_file(env_path=".env"):
    """从 .env 文件加载键值对到环境变量"""
    if os.path.exists(env_path):
        with open(env_path, "r", encoding="utf-8") as f:
            for line in f:
                line = line.strip()
                # 跳过空行和注释
                if not line or line.startswith("#"):
                    continue
                # 匹配 KEY=VALUE 格式
                match = re.match(r"^([A-Za-z_][A-Za-z0-9_]*)=(.*)$", line)
                if match:
                    key, value = match.groups()
                    # 去掉首尾引号（如果有）
                    value = value.strip().strip('"').strip("'")
                    # 仅在环境变量未设置时才写入
                    if key not in os.environ:
                        os.environ[key] = value

if __name__ == "__main__":
    load_env_file()
    print(f"AGNESAI_API_KEY: {os.environ.get('AGNESAI_API_KEY', '(未设置)')[:20]}...")
