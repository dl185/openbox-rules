# 规则集文件说明

只保留两类：成人（adult）、赌博（gambling）。

| 文件 | 内核 | 格式 |
|---|---|---|
| `singbox/adult.srs` | sing-box | 编译后二进制，体积小，优先用 |
| `singbox/adult.json` | sing-box | 源码，改内容用这个，改完 `./build.sh` 重编 |
| `mihomo/adult-classical.yaml` | mihomo | provider behavior: `classical` |
| `mihomo/adult-domain.yaml` | mihomo | provider behavior: `domain` |

赌博同理，把 `adult` 换成 `gambling`。

mihomo 先试 `-classical`，provider 解析失败再换 `-domain`。

名单来源：hagezi/dns-blocklists 的 `nsfw.txt`、`gambling.mini.txt`，快照 2026-11-21。
