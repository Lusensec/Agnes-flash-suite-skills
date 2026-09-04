---
name: agnes-2.5-flash
description: |
  Agnes 2.5 Flash 对话模型 Skill。
  支持聊天补全、图像理解、工具调用、Thinking 模式和流式输出。
  官方文档：https://agnes-ai.cn/zh-Hans/docs/agnes-25-flash
  触发词：对话、聊天、问答、image understanding、tool calling、thinking
---

# Agnes 2.5 Flash 对话模型 Skill

## 概述

X 2.5 Flash 是 Agnes AI 的最新一代语言模型，基于 Agnes 2.0 Flash 升级的全量可用模型。它在编码任务、智能体工作流、工具调用、多轮对话、推理和图像理解体验上进行了全面优化。

**核心能力：**
- 512K 超长上下文窗口
- 65.5K 最大输出
- 图像理解（Vision）
- 工具调用（Function Calling）
- Thinking 模式
- 流式输出
- 代码专项任务优化

## API 信息

| API | 端点 |
|-----|------|
| **Chat Completions** | `POST https://api.agnes-ai.cn/v1/chat/completions` |
| **Responses** | `POST https://api.agnes-ai.cn/v1/responses` |
| **Messages** | `POST https://api.agnes-ai.cn/v1/messages` |

**模型 ID**: `agnes-2.5-flash`

## 支持的参数

### Chat Completions 参数

| 参数 | 类型 | 必填 | 说明 |
|------|------|------|------|
| `model` | string | ✅ | 模型名称，使用 `agnes-2.5-flash` |
| `messages` | array | ✅ | 对话消息数组 |
| `temperature` | number | ❌ | 控制输出随机性 |
| `top_p` | number | ❌ | 控制核采样 |
| `max_tokens` | number | ❌ | 最大输出 token 数 |
| `stream` | boolean | ❌ | 是否启用流式输出 |
| `tools` | array | ❌ | 工具调用定义 |
| `tool_choice` | string/object | ❌ | 工具选择控制 |
| `chat_template_kwargs` | object | ❌ | 启用 Thinking 等扩展能力 |

### 图像输入格式

```json
{
  "role": "user",
  "content": [
    {
      "type": "text",
      "text": "请描述这张图片"
    },
    {
      "type": "image_url",
      "image_url": {
        "url": "https://example.com/image.jpg"
      }
    }
  ]
}
```

## 核心功能

### 1. 基础聊天

```bash
curl -X POST "https://api.agnes-ai.cn/v1/chat/completions" \
  -H "Authorization: Bearer YOUR_API_KEY" \
  -H "Content-Type: application/json" \
  -d '{
    "model": "agnes-2.5-flash",
    "messages": [
      {
        "role": "system",
        "content": "You are a helpful AI assistant."
      },
      {
        "role": "user",
        "content": "你好，请介绍一下你自己"
      }
    ]
  }'
```

### 2. 图像理解

```bash
curl -X POST "https://api.agnes-ai.cn/v1/chat/completions" \
  -H "Authorization: Bearer YOUR_API_KEY" \
  -H "Content-Type: application/json" \
  -d '{
    "model": "agnes-2.5-flash",
    "messages": [
      {
        "role": "user",
        "content": [
          {
            "type": "text",
            "text": "这张图片里有什么？"
          },
          {
            "type": "image_url",
            "image_url": {
              "url": "https://example.com/image.jpg"
            }
          }
        ]
      }
    ]
  }'
```

### 3. 工具调用

```bash
curl -X POST "https://api.agnes-ai.cn/v1/chat/completions" \
  -H "Authorization: Bearer YOUR_API_KEY" \
  -H "Content-Type: application/json" \
  -d '{
    "model": "agnes-2.5-flash",
    "messages": [
      {
        "role": "user",
        "content": "What is the weather like in Singapore today?"
      }
    ],
    "tools": [
      {
        "type": "function",
        "function": {
          "name": "get_weather",
          "description": "Get the current weather for a location",
          "parameters": {
            "type": "object",
            "properties": {
              "location": {
                "type": "string",
                "description": "The city and country"
              }
            },
            "required": ["location"]
          }
        }
      }
    ]
  }'
```

### 4. Thinking 模式

```bash
curl -X POST "https://api.agnes-ai.cn/v1/chat/completions" \
  -H "Authorization: Bearer YOUR_API_KEY" \
  -H "Content-Type: application/json" \
  -d '{
    "model": "agnes-2.5-flash",
    "messages": [
      {
        "role": "user",
        "content": "Help me write a Python script to process a CSV file."
      }
    ],
    "chat_template_kwargs": {
      "enable_thinking": true
    },
    "max_tokens": 2048
  }'
```

### 5. 流式输出

```bash
curl -X POST "https://api.agnes-ai.cn/v1/chat/completions" \
  -H "Authorization: Bearer YOUR_API_KEY" \
  -H "Content-Type: application/json" \
  -d '{
    "model": "agnes-2.5-flash",
    "messages": [
      {
        "role": "user",
        "content": "Write a short poem about AI."
      }
    ],
    "stream": true
  }'
```

## 响应格式

### Chat Completions 响应

```json
{
  "id": "chatcmpl_xxx",
  "object": "chat.completion",
  "created": 1774432125,
  "model": "agnes-2.5-flash",
  "choices": [
    {
      "index": 0,
      "message": {
        "role": "assistant",
        "content": "Autonomous agents use tools by understanding the user's goal..."
      },
      "finish_reason": "stop"
    }
  ],
  "usage": {
    "prompt_tokens": 35,
    "completion_tokens": 58,
    "total_tokens": 93
  }
}
```

### 工具调用响应

```json
{
  "id": "chatcmpl_xxx",
  "choices": [
    {
      "message": {
        "role": "assistant",
        "tool_calls": [
          {
            "id": "call_xxx",
            "type": "function",
            "function": {
              "name": "get_weather",
              "arguments": "{\"location\":\"Singapore\"}"
            }
          }
        ]
      }
    }
  ]
}
```

## 最佳实践

### 提示词结构

```
[角色] + [任务] + [上下文] + [要求] + [输出格式]
```

### 图像理解任务

```
请分析这张截图。识别主要 UI 元素，解释可能存在的问题，并提供改善用户体验的建议。
```

### 编码任务

```
帮我调试这个 React 组件。问题是按钮点击后状态不更新。解释原因并提供修正后的代码。
```

### 智能体工作流

```
你是一个自主研究代理。搜索相关信息，总结关键发现，并以结构化格式返回结果（包含来源链接）。
```

## 限制与价格

| 项目 | 数值 |
|------|------|
| 上下文窗口 | 512K |
| 最大输出 | 65.5K |

| 类型 | 原价 | 现价 |
|------|------|------|
| 输入 Token | ¥0.20 / 百万 Token | **¥0** |
| 输出 Token | ¥1.00 / 百万 Token | **¥0** |

**当前优惠：所有 Token 免费！**

## 接入检查清单

- [ ] 使用 `agnes-2.5-flash` 作为模型名称
- [ ] 使用 `https://api.agnes-ai.cn/v1/chat/completions` 作为端点
- [ ] 请求包含 `model` 和 `messages`
- [ ] 图像输入使用公开可访问的 `image_url`
- [ ] 流式响应设置 `stream: true`
- [ ] 启用 Thinking 模式使用 `chat_template_kwargs.enable_thinking: true`

## 相关文档

- [X 2.5 Flash 官方文档](https://agnes-ai.cn/zh-Hans/docs/agnes-25-flash)
- [完整文档索引](https://wiki.agnes-ai.cn/llms.txt)
- [Agnes AI 平台](https://platform.agnes-ai.cn)
