---
name: agnes-3.0-flash
description: |
  Agnes 3.0 Flash Agent 编程模型 Skill（模型 ID: agnes-3.0-flash）。
  全新一代文本模型，强化 Agnes Code 任务执行、工具编排与可信交付能力。
  官方文档：https://agnes-ai.cn/zh-Hans/docs/agnes-30-flash
  触发词：对话、聊天、问答、agent、image understanding、tool calling、thinking、3.0
---

# Agnes 3.0 Flash Agent 编程模型 Skill

## 概述

Agnes 3.0 Flash 是 Agnes AI 全新一代升级文本模型，面向 Agent 编程与工具驱动任务，重点提升复杂任务的端到端执行质量。在 Agnes 2.5 Flash 基础上，进一步强化了：

- **Agnes Code 任务执行** - 更适配代码智能体工作流
- **工具调用与编排** - 更稳定的多步骤工具调用
- **指令与上下文遵循** - 长任务中持续遵循目标
- **可信交付** - 减少无依据结论与错误完成确认

**核心能力：**
- 512K 超长上下文窗口
- 65.5K 最大输出
- 图像理解（Vision）
- 工具调用（Function Calling）
- Thinking 模式
- 流式输出
- 更可靠的端到端任务交付
- 更稳定的工具编排

## API 信息

| API | 端点 |
|-----|------|
| **Chat Completions** | `POST https://api.agnes-ai.cn/v1/chat/completions` |
| **Responses** | `POST https://api.agnes-ai.cn/v1/responses` |
| **Messages** | `POST https://api.agnes-ai.cn/v1/messages` |

**模型 ID**: `agnes-3.0-flash`

## 支持的参数

### Chat Completions 参数

| 参数 | 类型 | 必填 | 说明 |
|------|------|------|------|
| `model` | string | ✅ | 模型名称，使用 `agnes-3.0-flash` |
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

```python
# 运行 python examples/basic-chat.py [用户问题]
import json, urllib.request, os
API_KEY = os.environ.get("AGNESAI_API_KEY")
resp = urllib.request.urlopen(urllib.request.Request(
    "https://api.agnes-ai.cn/v1/chat/completions",
    data=json.dumps({
        "model": "agnes-3.0-flash",
        "messages": [
            {"role": "system", "content": "You are a helpful AI assistant."},
            {"role": "user", "content": "你好，请介绍一下你自己"}
        ]
    }).encode(),
    headers={"Authorization": f"Bearer {API_KEY}", "Content-Type": "application/json"},
    method="POST"
)).read()
print(json.loads(resp)["choices"][0]["message"]["content"])
```

### 2. 图像理解

```python
# 运行 python examples/image-understanding.py [图片URL]
import json, urllib.request, os
API_KEY = os.environ.get("AGNESAI_API_KEY")
resp = urllib.request.urlopen(urllib.request.Request(
    "https://api.agnes-ai.cn/v1/chat/completions",
    data=json.dumps({
        "model": "agnes-3.0-flash",
        "messages": [{
            "role": "user",
            "content": [
                {"type": "text", "text": "这张图片里有什么？"},
                {"type": "image_url", "image_url": {"url": "https://example.com/image.jpg"}}
            ]
        }]
    }).encode(),
    headers={"Authorization": f"Bearer {API_KEY}", "Content-Type": "application/json"},
    method="POST"
)).read()
print(json.loads(resp)["choices"][0]["message"]["content"])
```

### 3. 工具调用

```python
# 运行 python examples/tool-calling.py [用户问题]
import json, urllib.request, os
API_KEY = os.environ.get("AGNESAI_API_KEY")
resp = urllib.request.urlopen(urllib.request.Request(
    "https://api.agnes-ai.cn/v1/chat/completions",
    data=json.dumps({
        "model": "agnes-3.0-flash",
        "messages": [{"role": "user", "content": "What is the weather like in Singapore today?"}],
        "tools": [{
            "type": "function",
            "function": {
                "name": "get_weather",
                "description": "Get the current weather for a location",
                "parameters": {
                    "type": "object",
                    "properties": {"location": {"type": "string", "description": "The city and country"}},
                    "required": ["location"]
                }
            }
        }]
    }).encode(),
    headers={"Authorization": f"Bearer {API_KEY}", "Content-Type": "application/json"},
    method="POST"
)).read()
result = json.loads(resp)
print(json.dumps(result["choices"][0]["message"].get("tool_calls"), indent=2, ensure_ascii=False))
```

### 4. Thinking 模式

```python
# 运行 python examples/thinking-mode.py [问题]
import json, urllib.request, os
API_KEY = os.environ.get("AGNESAI_API_KEY")
resp = urllib.request.urlopen(urllib.request.Request(
    "https://api.agnes-ai.cn/v1/chat/completions",
    data=json.dumps({
        "model": "agnes-3.0-flash",
        "messages": [{"role": "user", "content": "帮我规划这个仓库任务的实现步骤"}],
        "chat_template_kwargs": {"enable_thinking": True},
        "max_tokens": 2048
    }).encode(),
    headers={"Authorization": f"Bearer {API_KEY}", "Content-Type": "application/json"},
    method="POST"
)).read()
print(json.loads(resp)["choices"][0]["message"]["content"])
```

### 5. 流式输出

```python
import json, urllib.request, os
API_KEY = os.environ.get("AGNESAI_API_KEY")
req = urllib.request.Request(
    "https://api.agnes-ai.cn/v1/chat/completions",
    data=json.dumps({
        "model": "agnes-3.0-flash",
        "messages": [{"role": "user", "content": "Write a short poem about AI."}],
        "stream": True
    }).encode(),
    headers={"Authorization": f"Bearer {API_KEY}", "Content-Type": "application/json"},
    method="POST"
)
with urllib.request.urlopen(req) as resp:
    for line in resp:
        if line:
            print(line.decode("utf-8"), end="")
```

## 响应格式

### Chat Completions 响应

```json
{
  "id": "chatcmpl_xxx",
  "object": "chat.completion",
  "created": 1774432125,
  "model": "agnes-3.0-flash",
  "choices": [
    {
      "index": 0,
      "message": {
        "role": "assistant",
        "content": "智能体应根据任务和工具声明的能力选择工具..."
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

### Agnes Code 与智能体任务

明确任务目标、仓库或运行环境上下文、限制条件、预期输出和工具权限。执行完工具后，应将工具结果返回对话，再请求模型给出下一步动作。

### 工具调用

工具描述与 JSON Schema 应保持精确、聚焦。在应用侧执行会产生副作用的操作前，应先校验工具参数。

### 长任务执行

将复杂任务拆分为可验证的阶段，并在每轮执行中保留目标、限制条件和关键工具结果。

## 限制与价格

| 项目 | 数值 |
|------|------|
| 上下文窗口 | 512K |
| 最大输出 | 65.5K |

| 计费项 | 刊例价（原价） | 现价（优惠价） |
|--------|--------------|---------------|
| 输入缓存命中 | ¥0.035 / 百万 Token | **¥0** |
| 输入 Token | ¥0.35 / 百万 Token | **¥0** |
| 输出 Token | ¥1.00 / 百万 Token | **¥0** |

**当前优惠：所有 Token 免费！**

## 接入检查清单

- [ ] 使用 `agnes-3.0-flash` 作为模型名称
- [ ] 使用 `https://api.agnes-ai.cn/v1/chat/completions` 作为端点
- [ ] 请求包含 `model` 和 `messages`
- [ ] 图像输入使用公开可访问的 `image_url`
- [ ] 流式响应设置 `stream: true`
- [ ] 启用 Thinking 模式使用 `chat_template_kwargs.enable_thinking: true`
- [ ] 或 Anthropic 格式使用 `thinking.type: "enabled"`

## 相关文档

- [Agnes 3.0 Flash 官方文档](https://agnes-ai.cn/zh-Hans/docs/agnes-30-flash)
- [完整文档索引](https://wiki.agnes-ai.cn/llms.txt)
- [Agnes AI 平台](https://platform.agnes-ai.cn)
