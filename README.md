# Agnes Flash 系列全能力套件

> **灵活使用方式：** 本套件既可整体安装，也可单独提取任意子目录作为独立 Skill 使用。

## 安装方式

### 方式一：整体安装（推荐）

克隆整个仓库，Agent 可调用所有四种模型能力：

```
请安装 Agnes AI Skill：https://github.com/Lusensec/agnes-flash-suite-skills
```

### 方式二：单独安装（按需选择）

每个子目录都是**自包含的独立 Skill**，只保留需要的功能。从 GitHub 下载对应子目录，放入 Agent 的 skills 目录即可。

| 子 Skill | 目录名 | 触发词 | 说明 |
|----------|--------|--------|------|
| agnes-3.0-flash | `agnes-3.0-flash/` | agent、工具调用、3.0、thinking | Agent 编程/工具编排 |
| agnes-2.5-flash | `agnes-2.5-flash/` | 对话、聊天、图像理解、tool calling | 通用对话/推理/Vision |
| agnes-2.5-image-flash | `agnes-2.5-image-flash/` | 生图、图像生成、文生图、图生图 | 图像创作 |
| agnes-2.5-video-flash | `agnes-2.5-video-flash/` | 视频生成、文生视频、首尾帧 | 视频制作 |

**示例：单独使用图像生成 Skill**

```bash
# 从 GitHub 下载单个子目录
git clone https://github.com/Lusensec/agnes-flash-suite-skills.git
cp -r agnes-flash-suite-skills/agnes-2.5-image-flash ~/your-skills/

# 在该目录下配置 .env
cp agnes-2.5-image-flash/.env.example agnes-2.5-image-flash/.env
# 编辑 .env 填入 API Key，然后直接使用
python agnes-2.5-image-flash/examples/text-to-image.py
```

## 配置 API Key

复制 `.env.example` 为 `.env` 并填入你的 API Key：

```bash
cp .env.example .env
```

编辑 `.env` 文件，设置环境变量：
```bash
export AGNESAI_API_KEY=sk-你的实际API Key
```

> 获取 API Key：https://platform.agnes-ai.cn

## 模型介绍

### agnes-3.0-flash（Agent 编程模型）

全新一代升级文本模型，面向 Agent 编程与工具驱动任务，强化 Agnes Code 任务执行、工具编排与可信交付能力，重点提升复杂任务的端到端执行质量。

| 特性 | 说明 |
|------|------|
| **上下文窗口** | 512K |
| **最大输出** | 65.5K |
| **核心方向** | Agnes Code 任务执行、工具调用与编排、指令与上下文遵循、可信交付 |
| **支持功能** | 聊天补全、图像理解、工具调用、Thinking 模式、流式输出 |
| **API 端点** | `POST /v1/chat/completions`、`POST /v1/responses`、`POST /v1/messages` |

**使用场景：** 复杂 Agent 任务、代码智能体、长任务多轮执行、工具编排、可信交付

---

### agnes-2.5-flash（对话模型）

基于 Agnes 2.0 Flash 升级的全量可用语言模型，全面优化编码、智能体工作流、工具调用和多模态理解体验。

| 特性 | 说明 |
|------|------|
| **上下文窗口** | 512K |
| **最大输出** | 65.5K |
| **支持功能** | 聊天补全、图像理解、工具调用、Thinking 模式、流式输出 |
| **API 端点** | `POST /v1/chat/completions` |

**使用场景：** AI 助手、自主智能体、代码生成、图像理解、客服机器人

---

### agnes-image-2.5-flash（图像生成）

最新一代图像模型，整体能力全面超过 Image 2.1 Flash，特别适合高信息密度图像、复杂视觉细节和语义对齐。

| 特性 | 说明 |
|------|------|
| **支持模式** | 文生图、图生图、多图合成 |
| **尺寸档位** | 1K / 2K / 3K / 4K |
| **宽高比** | 1:1, 3:4, 4:3, 16:9, 9:16, 2:3, 3:2, 21:9 |
| **API 端点** | `POST /v1/images/generations` |

**使用场景：** 创意设计、营销内容、高密度视觉、图像转换、产品可视化

---

### agnes-video-2.5-flash（视频生成）

支持多种生成模式的视频模型，可创建 4-12 秒 720P 视频。

| 特性 | 说明 |
|------|------|
| **支持模式** | 文生视频、首尾帧控制、图片参考（≤5）、音频参考（≤3） |
| **分辨率** | 固定 720P |
| **时长** | 4-12 秒 |
| **API 端点** | `POST /v1/videos` |

**使用场景：** 创意视频、角色一致性动画、广告素材、短视频内容

---

## 快速开始

所有示例脚本均位于各子 Skill 的 `examples/` 目录，支持命令行参数传入用户内容：

```bash
# 文生图（可选传提示词、尺寸、比例）
python agnes-2.5-image-flash/examples/text-to-image.py "一只可爱的田园犬在稻田边" "2K" "16:9"

# 图生图（可选传输入图片URL、提示词）
python agnes-2.5-image-flash/examples/image-to-image.py https://example.com/input.png "转换为赛博朋克风格"

# 图像理解（可选传图片URL）
python agnes-2.5-flash/examples/image-understanding.py https://example.com/image.jpg

# 基础聊天（可选传用户问题）
python agnes-2.5-flash/examples/basic-chat.py "用 Python 写一个快速排序算法"

# 文生视频（可选传提示词）
python agnes-2.5-video-flash/examples/text-to-video.py "小猫在客厅里追逐激光笔"

# 首尾帧视频（可选传首帧URL、尾帧URL、提示词）
python agnes-2.5-video-flash/examples/keyframe-video.py https://example.com/first.png https://example.com/last.png "人物转身走向窗边"
```

> 不传参数时使用默认演示内容，方便快速体验。

## 文件结构

```
agnes-flash-suite/
├── README.md                          # 本文件
├── SKILL.md                           # Skill 主文档
├── .env.example                       # 环境变量示例
│
├── agnes-3.0-flash/                   # Agent 编程模型
│   ├── SKILL.md                       # Agent 编程模型详细说明
│   ├── README.md                      # Agent 编程模型简介
│   └── examples/
│       ├── basic-chat.py              # 基础聊天示例
│       ├── image-understanding.py     # 图像理解示例
│       ├── tool-calling.py            # 工具调用示例
│       └── thinking-mode.py           # Thinking 模式示例
│
├── agnes-2.5-flash/                   # 对话模型
│   ├── SKILL.md                       # 对话模型详细说明
│   ├── README.md                      # 对话模型简介
│   └── examples/
│       ├── basic-chat.py              # 基础聊天示例
│       ├── image-understanding.py     # 图像理解示例
│       ├── tool-calling.py            # 工具调用示例
│       └── thinking-mode.py           # Thinking 模式示例
│
├── agnes-2.5-image-flash/             # 图像生成（模型 ID: agnes-image-2.5-flash）
│   ├── SKILL.md                       # 图像生成详细说明
│   ├── README.md                      # 图像生成简介
│   └── examples/
│       ├── text-to-image.py           # 文生图（URL）示例
│       ├── text-to-image-base64.py    # 文生图（Base64）示例
│       ├── image-to-image.py          # 图生图示例
│       └── multi-image-combine.py     # 多图合成示例
│
└── agnes-2.5-video-flash/             # 视频生成（模型 ID: agnes-video-2.5-flash）
    ├── SKILL.md                       # 视频生成详细说明
    ├── README.md                      # 视频生成简介
    └── examples/
        ├── text-to-video.py           # 文生视频示例
        ├── keyframe-video.py          # 首尾帧控制示例
        ├── image-reference.py         # 图片参考示例
        ├── audio-reference.py         # 音频参考示例
        └── query-video.py             # 查询结果示例
```

## 相关文档

- [Agnes 3.0 Flash Agent 编程模型](https://agnes-ai.cn/zh-Hans/docs/agnes-30-flash)
- [Agnes 2.5 Flash 对话模型](https://agnes-ai.cn/zh-Hans/docs/agnes-25-flash)
- [Agnes Image 2.5 Flash](https://agnes-ai.cn/zh-Hans/docs/agnes-image-25-flash)
- [Agnes Video 2.5 Flash](https://agnes-ai.cn/zh-Hans/docs/agnes-video-25-flash)
- [Agnes AI 平台](https://platform.agnes-ai.cn)
