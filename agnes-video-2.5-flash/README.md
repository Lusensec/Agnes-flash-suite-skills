# Agnes Video 2.5 Flash Skill

这是一个用于生成视频的 AI 模型技能，基于 Agnes AI 的 Video 2.5 Flash 模型。

## 功能特性

- ✅ 文生视频
- ✅ 首尾帧控制
- ✅ 图片参考（最多 5 张）
- ✅ 音频参考（最多 3 段）
- ✅ 多种画幅比例

## 快速开始

### 1. 设置 API Key

```bash
export AGNES_API_KEY="sk-..."
```

### 2. 文生视频

```bash
curl -X POST "https://api.agnes-ai.cn/v1/videos" \
  -H "Authorization: Bearer $AGNES_API_KEY" \
  -H "Content-Type: application/json" \
  -d '{
    "model": "agnes-video-2.5-flash",
    "prompt": "雨后的未来城市街道，霓虹灯倒映在地面",
    "seconds": "5",
    "mode": "text",
    "size": "720P",
    "aspect_ratio": "16:9"
  }'
```

### 3. 查询结果

```bash
curl "https://api.agnes-ai.cn/agnesapi?video_id=VIDEO_ID&model_name=agnes-video-2.5-flash" \
  -H "Authorization: Bearer $AGNES_API_KEY"
```

## 使用场景

| 场景 | 推荐模式 |
|------|----------|
| 纯文本描述生成视频 | `text` |
| 指定开始和结束画面 | `keyframe` |
| 角色一致性视频 | `reference` + 图片 |
| 声音同步视频 | `reference` + 音频 |

## 价格

- 当前限时免费
- 原价：¥0.15/秒

## 文档

详见 [SKILL.md](./SKILL.md)
