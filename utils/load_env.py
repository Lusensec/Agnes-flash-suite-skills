#!/usr/bin/env python3
"""
加载 .env 文件中的环境变量
优先级：环境变量 > .env 文件（自动定位 skill 根目录）
"""

import os
import re
import sys


def load_env(skill_root=None):
    """
    从 skill 根目录加载 .env 文件到环境变量。
    
    Args:
        skill_root: skill 根目录，默认为 None（自动从 __file__ 向上查找）
    """
    if skill_root is None:
        # 从当前脚本位置向上查找包含 .env.example 的目录
        current = os.path.dirname(os.path.abspath(__file__))
        for _ in range(5):  # 最多向上找 5 级
            if os.path.exists(os.path.join(current, ".env.example")):
                skill_root = current
                break
            parent = os.path.dirname(current)
            if parent == current:
                break
            current = parent
        if skill_root is None:
            skill_root = os.getcwd()
    
    env_path = os.path.join(skill_root, ".env")
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
