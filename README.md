# Agnes 2.5 Flash 系列全能力套件

## 安装 Skill

给 Agent 指令：

```
请安装 Agnes AI Skill：https://github.com/Lusensec/agnes-2.5-flash-suite
```

## 配置 API Key

复制 `.env.example` 为 `.env` 并填入你的 API Key：

```bash
cp .env.example .env
```

编辑 `.env` 文件：
```bash
AGNES_API_KEY=sk-你的实际 API Key
```

> 获取 API Key：https://platform.agnes-ai.cn

## 模型介绍

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

## 文件结构

```
agnes-2.5-flash-suite/
├── README.md                          # 本文件
├── SKILL.md                           # Skill 主文档
│
├── agnes-2.5-flash/                   # 对话模型
│   ├── SKILL.md / README.md
│   └── examples/
│       ├── basic-chat.sh
│       ├── image-understanding.sh
│       ├── tool-calling.sh
│       └── thinking-mode.sh
│
├── agnes-image-2.5-flash/             # 图像生成
│   ├── SKILL.md / README.md
│   └── examples/
│       ├── text-to-image.sh
│       ├── text-to-image-base64.sh
│       ├── image-to-image.sh
│       └── multi-image-combine.sh
│
└── agnes-video-2.5-flash/             # 视频生成
    ├── SKILL.md / README.md
    └── examples/
        ├── text-to-video.sh
        ├── keyframe-video.sh
        ├── image-reference.sh
        ├── audio-reference.sh
        └── query-video.sh
```

## 相关文档

- [Agnes 2.5 Flash 对话模型](https://agnes-ai.cn/zh-Hans/docs/agnes-25-flash)
- [Agnes Image 2.5 Flash](https://agnes-ai.cn/zh-Hans/docs/agnes-image-25-flash)
- [Agnes Video 2.5 Flash](https://agnes-ai.cn/zh-Hans/docs/agnes-video-25-flash)
- [Agnes AI 平台](https://platform.agnes-ai.cn)
