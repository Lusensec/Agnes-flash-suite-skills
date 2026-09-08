#!/usr/bin/env python3
"""
加载 .env 文件中的环境变量
自动定位 skill 根目录，支持整体使用和单独提取两种场景。
"""

import os
import re


def _find_skill_root():
    """
    从当前脚本位置向上查找 skill 根目录。
    
    策略（按优先级）：
    1. 找包含 .env.example 的目录（整体使用场景）
    2. 找包含 .env 文件的目录（单独提取场景）
    3. 回退到当前工作目录
    
    最多向上查找 5 级目录。
    """
    current = os.path.dirname(os.path.abspath(__file__))
    
    for _ in range(5):
        # 优先找 .env.example（整体使用）
        if os.path.exists(os.path.join(current, ".env.example")):
            return current
        # 其次找 .env（单独提取时使用）
        if os.path.exists(os.path.join(current, ".env")):
            return current
        parent = os.path.dirname(current)
        if parent == current:
            break
        current = parent
    
    return os.getcwd()


def load_env():
    """
    加载 .env 文件到环境变量。
    
    Returns:
        bool: 是否成功加载
    """
    root = _find_skill_root()
    env_path = os.path.join(root, ".env")
    
    if not os.path.exists(env_path):
        return False
    
    with open(env_path, "r", encoding="utf-8") as f:
        for line in f:
            line = line.strip()
            if not line or line.startswith("#"):
                continue
            match = re.match(r"^([A-Za-z_][A-Za-z0-9_]*)=(.*)$", line)
            if match:
                key, value = match.groups()
                value = value.strip().strip('"').strip("'")
                if key not in os.environ:
                    os.environ[key] = value
    return True


if __name__ == "__main__":
    loaded = load_env()
    key = os.environ.get("AGNESAI_API_KEY", "(未设置)")
    print(f"AGNESAI_API_KEY: {key[:20] if key != '(未设置)' else key}...")
    print(f"加载状态: {'成功' if loaded else '未找到 .env 文件'}")
    print(f"定位目录: {_find_skill_root()}")
