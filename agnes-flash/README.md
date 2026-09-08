# Agnes 2.5 Flash Skill

这是一个用于对话和推理的 AI 模型技能，基于 Agnes AI 的 2.5 Flash 语言模型。

## 功能特性

- ✅ 聊天补全
- ✅ 多轮对话（512K 上下文）
- ✅ 图像理解（Vision）
- ✅ 工具调用（Function Calling）
- ✅ Thinking 模式
- ✅ 流式输出
- ✅ 代码专项任务优化

## 快速开始

### 1. 设置 API Key

```bash
export AGNES_API_KEY="sk-..."
```

### 2. 基础聊天

```bash
curl -X POST "https://api.agnes-ai.cn/v1/chat/completions" \
  -H "Authorization: Bearer $AGNES_API_KEY" \
  -H "Content-Type: application/json" \
  -d '{
    "model": "agnes-2.5-flash",
    "messages": [
      {
        "role": "user",
        "content": "你好，请介绍一下你自己"
      }
    ]
  }'
```

### 3. 图像理解

```bash
curl -X POST "https://api.agnes-ai.cn/v1/chat/completions" \
  -H "Authorization: Bearer $AGNES_API_KEY" \
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

### 4. 开启 Thinking 模式

```bash
curl -X POST "https://api.agnes-ai.cn/v1/chat/completions" \
  -H "Authorization: Bearer $AGNES_API_KEY" \
  -H "Content-Type: application/json" \
  -d '{
    "model": "agnes-2.5-flash",
    "messages": [
      {
        "role": "user",
        "content": "帮我写一个 Python 脚本处理 CSV 文件"
      }
    ],
    "chat_template_kwargs": {
      "enable_thinking": true
    }
  }'
```

## 使用场景

| 场景 | 说明 |
|------|------|
| **AI 助手** | 通用问答、效率助手、个人助理 |
| **自主智能体** | 多步骤任务执行、规划、工具使用 |
| **编码助手** | 代码生成、Bug 排查、重构建议 |
| **图像理解** | 截图分析、图片描述、视觉问答 |
| **客户支持** | FAQ 自动回复、客服机器人 |

## 价格

- 当前限时免费
- 原价：输入 ¥0.20/百万 Token，输出 ¥1.00/百万 Token

## 文档

详见 [SKILL.md](./SKILL.md)
