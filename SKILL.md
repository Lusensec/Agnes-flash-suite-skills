---
name: agnes-flash-suite
description: |
  Agnes Flash 全能力套件 Skill。
  包含 3.0/2.5 对话模型、图像生成、视频生成四大核心能力。
  
  子 Skill 列表：
  - agnes-3.0-flash (Agent 编程/工具编排/可信交付)
  - agnes-2.5-flash (对话/推理/图像理解)
  - agnes-image-2.5-flash (文生图/图生图/多图合成)
  - agnes-video-2.5-flash (文生视频/首尾帧/图片参考)
  
  触发词：agnes、AI助手、聊天、生图、图像生成、视频生成、文生视频、图片理解、工具调用、thinking、agent、3.0
---

# Agnes Flash 全能力套件

## 概述

Agnes Flash 套件是一个多功能 AI 能力平台，整合了四种核心模型能力：

| 子 Skill | 模型 ID | 核心能力 | 触发场景 |
|----------|---------|----------|----------|
| **agnes-3.0-flash** | `agnes-3.0-flash` | Agent 编程、工具编排、可信交付 | 复杂任务、代码智能体、长任务 |
| **agnes-2.5-flash** | `agnes-2.5-flash` | 对话、推理、图像理解、工具调用 | 问答、代码、分析、Vision |
| **agnes-image-2.5-flash** | `agnes-image-2.5-flash` | 文生图、图生图、多图合成 | 图像创作、设计、编辑 |
| **agnes-video-2.5-flash** | `agnes-video-2.5-flash` | 文生视频、首尾帧、图片/音频参考 | 视频制作、动画、创意 |

## 快速开始

### 1. Agent 编程模型 (agnes-3.0-flash)

```bash
# 基础任务执行
curl -X POST "https://api.agnes-ai.cn/v1/chat/completions" \
  -H "Authorization: Bearer YOUR_API_KEY" \
  -d '{
    "model": "agnes-3.0-flash",
    "messages": [{"role": "user", "content": "请说明智能体应如何选择并调用工具"}],
    "max_tokens": 1024
  }'

# 工具调用
curl -X POST "https://api.agnes-ai.cn/v1/chat/completions" \
  -H "Authorization: Bearer YOUR_API_KEY" \
  -d '{
    "model": "agnes-3.0-flash",
    "messages": [{"role": "user", "content": "上海现在的天气怎么样？"}],
    "tools": [{
      "type": "function",
      "function": {
        "name": "get_weather",
        "description": "获取指定城市当前天气。",
        "parameters": {
          "type": "object",
          "properties": {"city": {"type": "string"}},
          "required": ["city"]
        }
      }
    }]
  }'

# Thinking 模式
curl -X POST "https://api.agnes-ai.cn/v1/chat/completions" \
  -H "Authorization: Bearer YOUR_API_KEY" \
  -d '{
    "model": "agnes-3.0-flash",
    "messages": [{"role": "user", "content": "请规划此仓库任务的实现步骤"}],
    "chat_template_kwargs": {"enable_thinking": true}
  }'
```

**文档**: [agnes-3.0-flash/SKILL.md](./agnes-3.0-flash/SKILL.md)

---

### 3. 对话模型 (agnes-2.5-flash)

```bash
# 基础聊天
curl -X POST "https://api.agnes-ai.cn/v1/chat/completions" \
  -H "Authorization: Bearer YOUR_API_KEY" \
  -H "Content-Type: application/json" \
  -d '{
    "model": "agnes-2.5-flash",
    "messages": [{"role": "user", "content": "你好，请介绍一下自己"}]
  }'

# 图像理解
curl -X POST "https://api.agnes-ai.cn/v1/chat/completions" \
  -H "Authorization: Bearer YOUR_API_KEY" \
  -d '{
    "model": "agnes-2.5-flash",
    "messages": [{
      "role": "user",
      "content": [
        {"type": "text", "text": "这张图片里有什么？"},
        {"type": "image_url", "image_url": {"url": "https://example.com/image.jpg"}}
      ]
    }]
  }'

# Thinking 模式
curl -X POST "https://api.agnes-ai.cn/v1/chat/completions" \
  -H "Authorization: Bearer YOUR_API_KEY" \
  -d '{
    "model": "agnes-2.5-flash",
    "messages": [{"role": "user", "content": "帮我写一个 Python 脚本"}],
    "chat_template_kwargs": {"enable_thinking": true}
  }'
```

**文档**: [agnes-flash/SKILL.md](./agnes-flash/SKILL.md)

---

### 4. 图像生成 (agnes-image-2.5-flash)

```bash
# 文生图
curl -X POST "https://api.agnes-ai.cn/v1/images/generations" \
  -H "Authorization: Bearer YOUR_API_KEY" \
  -d '{
    "model": "agnes-image-2.5-flash",
    "prompt": "一只可爱的田园犬在稻田边",
    "size": "2K",
    "ratio": "16:9",
    "extra_body": {"response_format": "url"}
  }'

# 图生图
curl -X POST "https://api.agnes-ai.cn/v1/images/generations" \
  -H "Authorization: Bearer YOUR_API_KEY" \
  -d '{
    "model": "agnes-image-2.5-flash",
    "prompt": "转换为赛博朋克风格",
    "size": "2K",
    "extra_body": {
      "image": ["https://example.com/input.png"],
      "response_format": "url"
    }
  }'

# 多图合成
curl -X POST "https://api.agnes-ai.cn/v1/images/generations" \
  -H "Authorization: Bearer YOUR_API_KEY" \
  -d '{
    "model": "agnes-image-2.5-flash",
    "prompt": "将两张图合成",
    "size": "2K",
    "extra_body": {
      "image": ["https://example.com/img1.png", "https://example.com/img2.png"],
      "response_format": "url"
    }
  }'
```

**文档**: [agnes-image-flash/SKILL.md](./agnes-image-flash/SKILL.md)

---

### 5. 视频生成 (agnes-video-2.5-flash)

```bash
# 文生视频
curl -X POST "https://api.agnes-ai.cn/v1/videos" \
  -H "Authorization: Bearer YOUR_API_KEY" \
  -d '{
    "model": "agnes-video-2.5-flash",
    "prompt": "小猫在客厅跳舞",
    "seconds": "5",
    "mode": "text",
    "size": "720P",
    "aspect_ratio": "16:9"
  }'

# 首尾帧控制
curl -X POST "https://api.agnes-ai.cn/v1/videos" \
  -H "Authorization: Bearer YOUR_API_KEY" \
  -d '{
    "model": "agnes-video-2.5-flash",
    "prompt": "人物转身走向窗边",
    "seconds": "5",
    "mode": "keyframe",
    "first_frame": "https://example.com/first.png",
    "last_frame": "https://example.com/last.png"
  }'

# 图片参考
curl -X POST "https://api.agnes-ai.cn/v1/videos" \
  -H "Authorization: Bearer YOUR_API_KEY" \
  -d '{
    "model": "agnes-video-2.5-flash",
    "prompt": "以 <Picture 1> 中的角色为参考跳舞",
    "seconds": "5",
    "mode": "reference",
    "images": ["https://example.com/character.png"]
  }'
```

**查询任务**:
```bash
curl "https://api.agnes-ai.cn/agnesapi?video_id=VIDEO_ID&model_name=agnes-video-2.5-flash" \
  -H "Authorization: Bearer YOUR_API_KEY"
```

**文档**: [agnes-video-flash/SKILL.md](./agnes-video-flash/SKILL.md)

---

## 完整工作流示例

### 从文字到视频的完整创作流程

```bash
# 1. 用对话模型生成创意描述
# 2. 用图像模型生成关键帧
# 3. 用视频模型生成动态视频
```

**示例**: 创作一个"田园犬和狸花猫在大山背景下"的短视频

```bash
# Step 1: 生成田园犬图片
curl -X POST "https://api.agnes-ai.cn/v1/images/generations" \
  -H "Authorization: Bearer YOUR_API_KEY" \
  -d '{
    "model": "agnes-image-2.5-flash",
    "prompt": "一只可爱的田园犬在阳光明媚的乡村田园中",
    "size": "2K",
    "ratio": "16:9",
    "extra_body": {"response_format": "url"}
  }'

# Step 2: 生成狸花猫图片
curl -X POST "https://api.agnes-ai.cn/v1/images/generations" \
  -H "Authorization: Bearer YOUR_API_KEY" \
  -d '{
    "model": "agnes-image-2.5-flash",
    "prompt": "一只漂亮的狸花猫在阳光斑驳的老槐树下",
    "size": "2K",
    "ratio": "16:9",
    "extra_body": {"response_format": "url"}
  }'

# Step 3: 多图合成
curl -X POST "https://api.agnes-ai.cn/v1/images/generations" \
  -H "Authorization: Bearer YOUR_API_KEY" \
  -d '{
    "model": "agnes-image-2.5-flash",
    "prompt": "田园犬和狸花猫在大山背景下和谐共处",
    "size": "2K",
    "ratio": "16:9",
    "extra_body": {
      "image": ["URL_1", "URL_2"],
      "response_format": "url"
    }
  }'

# Step 4: 使用合成图生成视频
curl -X POST "https://api.agnes-ai.cn/v1/videos" \
  -H "Authorization: Bearer YOUR_API_KEY" \
  -d '{
    "model": "agnes-video-2.5-flash",
    "prompt": "田园犬和狸花猫在大山背景下快乐玩耍",
    "seconds": "5",
    "mode": "reference",
    "images": ["合成图URL"]
  }'
```

---

## 技术规格对比

| 特性 | 对话模型 | 图像模型 | 视频模型 |
|------|----------|----------|----------|
| **模型 ID** | `agnes-3.0-flash` | `agnes-2.5-flash` | `agnes-image-2.5-flash` | `agnes-video-2.5-flash` |
| **API 端点** | `/v1/chat/completions` | `/v1/chat/completions` | `/v1/images/generations` | `/v1/videos` |
| **上下文** | 512K | 512K | - | - |
| **最大输出** | 65.5K | 65.5K | - | - |
| **超时** | 60s | 60s | 360s | 600s |
| **计费** | 免费 | 免费 | 免费 | 免费 |

---

## 使用场景矩阵

| 需求 | 推荐子 Skill | 说明 |
|------|-------------|------|
| Agent 编程/复杂任务 | agnes-3.0-flash | 强化工具编排与可信交付 |
| 长任务多轮执行 | agnes-3.0-flash | 指令与上下文遵循 |
| 问答/聊天 | agnes-2.5-flash | 通用对话、知识问答 |
| 代码生成/调试 | agnes-2.5-flash | 支持 Thinking 模式 |
| 图像理解 | agnes-2.5-flash | 支持 Vision 输入 |
| 工具调用 | agnes-2.5-flash | Function Calling |
| 文生图 | agnes-image-2.5-flash | 从文字描述生成图片 |
| 图生图 | agnes-image-2.5-flash | 图像编辑/风格迁移 |
| 多图合成 | agnes-image-2.5-flash | 组合多张参考图 |
| 文生视频 | agnes-video-2.5-flash | 纯文本生成视频 |
| 图片转视频 | agnes-video-2.5-flash | 使用图片作为参考 |
| 首尾帧控制 | agnes-video-2.5-flash | 指定开始和结束画面 |

---

## 文件结构

```
agnes-flash-suite/
├── SKILL.md                          # 本文件（主文档）
├── agnes-3.0-flash/                  # Agent 编程模型子 Skill
│   ├── SKILL.md
│   ├── README.md
│   └── examples/
│       ├── basic-chat.sh
│       ├── image-understanding.sh
│       ├── tool-calling.sh
│       └── thinking-mode.sh
├── agnes-flash/                      # 对话模型子 Skill
│   ├── SKILL.md
│   ├── README.md
│   └── examples/
│       ├── basic-chat.sh
│       ├── image-understanding.sh
│       ├── tool-calling.sh
│       └── thinking-mode.sh
├── agnes-image-flash/                # 图像生成子 Skill
│   ├── SKILL.md
│   ├── README.md
│   └── examples/
│       ├── text-to-image.sh
│       ├── text-to-image-base64.sh
│       ├── image-to-image.sh
│       └── multi-image-combine.sh
└── agnes-video-flash/                # 视频生成子 Skill
    ├── SKILL.md
    ├── README.md
    └── examples/
        ├── text-to-video.sh
        ├── keyframe-video.sh
        ├── image-reference.sh
        ├── audio-reference.sh
        └── query-video.sh
```

---

## 常见问题

### Q: 四个模型可以同时使用吗？
A: 是的，它们是完全独立的服务，可以任意组合使用。

### Q: API Key 是否通用？
A: 是的，使用同一个 API Key 即可访问所有模型。

### Q: 定价如何计算？
A: 当前所有模型均处于免费推广期，未来定价请参考官方文档。

### Q: 如何选择使用哪个模型？
A: 根据需求选择：
- 需要对话/理解/推理 → 使用对话模型
- 需要生成图片 → 使用图像模型
- 需要生成视频 → 使用视频模型

---

## 相关文档

- [Agnes AI 官方文档](https://agnes-ai.cn/zh-Hans/docs)
- [Agnes AI 平台](https://platform.agnes-ai.cn)
- [完整文档索引](https://wiki.agnes-ai.cn/llms.txt)
