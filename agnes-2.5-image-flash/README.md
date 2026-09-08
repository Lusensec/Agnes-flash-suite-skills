# Agnes Image 2.5 Flash Skill

这是一个用于生成图像的 AI 模型技能，基于 Agnes AI 的 Image 2.5 Flash 模型。

## 功能特性

- ✅ 文生图
- ✅ 图生图（图像编辑/风格迁移）
- ✅ 多图合成
- ✅ 多种尺寸档位（1K/2K/3K/4K）
- ✅ 多种宽高比（1:1/3:4/4:3/16:9/9:16/2:3/3:2/21:9）
- ✅ URL 或 Base64 输出

## 快速开始

### 1. 设置 API Key

```bash
export AGNES_API_KEY="sk-..."
```

### 2. 文生图

```bash
curl -X POST "https://api.agnes-ai.cn/v1/images/generations" \
  -H "Authorization: Bearer $AGNES_API_KEY" \
  -H "Content-Type: application/json" \
  -d '{
    "model": "agnes-image-2.5-flash",
    "prompt": "A luminous floating city above a misty canyon at sunrise",
    "size": "2K",
    "ratio": "16:9"
  }'
```

### 3. 图生图

```bash
curl -X POST "https://api.agnes-ai.cn/v1/images/generations" \
  -H "Authorization: Bearer $AGNES_API_KEY" \
  -H "Content-Type: application/json" \
  -d '{
    "model": "agnes-image-2.5-flash",
    "prompt": "Transform to cyberpunk style",
    "size": "2K",
    "ratio": "16:9",
    "extra_body": {
      "image": ["https://example.com/input.png"],
      "response_format": "url"
    }
  }'
```

## 使用场景

| 场景 | 推荐配置 |
|------|----------|
| 社交媒体封面 | 2K + 16:9 |
| 产品海报 | 2K + 3:4 或 4:3 |
| 手机壁纸 | 2K + 9:16 |
| 横版视频缩略图 | 2K + 16:9 |
| 方形头像 | 1K + 1:1 |

## 价格

- 当前限时免费
- 原价：¥0.07-0.16/张（按尺寸）

## 文档

详见 [SKILL.md](./SKILL.md)
