# openbox-rules —— Open-Box 目标分流规则集（成人 + 赌博）

只保留两类：**成人**、**赌博**。两种内核各一份，按你跑的内核选，别混用。

## 目录

```
rulesets/singbox/    sing-box 内核：.srs（编译好）+ .json（源码）
rulesets/mihomo/     mihomo 内核：*-classical.yaml / *-domain.yaml
build.sh             从 json 重新编译 srs
```

| 类别 | sing-box | mihomo classical | 条数 |
|---|---|---|---|
| 成人 | `adult.srs` 507 KB | `adult-classical.yaml` 3.1 MB | 87,988 |
| 赌博 | `gambling.srs` 343 KB | `gambling-classical.yaml` 1.9 MB | 52,542 |

## 在 Open-Box 里怎么加

目标分流 → 编辑站点集 → **「+ 规则集链接」**，填 raw 直链：

```
# GitHub
https://raw.githubusercontent.com/<用户名>/<仓库>/main/rulesets/singbox/adult.srs

# jsDelivr（国内更快）
https://cdn.jsdelivr.net/gh/<用户名>/<仓库>@main/rulesets/singbox/adult.srs

# Gitee
https://gitee.com/<用户名>/<仓库>/raw/main/rulesets/singbox/adult.srs
```

站点集**出口必须是「拒绝」**，并且排在「国内」「漏网之鱼」上面。

mihomo 内核就把路径换成 `rulesets/mihomo/adult-classical.yaml`；provider 报解析失败再换 `-domain.yaml`。

## 建议：两类分两个站点集

```
前置自定义分流
网站屏蔽-成人   ← 拒绝
网站屏蔽-赌博   ← 拒绝
国外
国内
漏网之鱼
```

分开放的好处：以后想单独关掉某一类，直接点卡片上的电源，不用改规则。

## 两个内核来回切怎么办

**规则集链接是绑内核的**：`*.srs` 只给 sing-box，`*.yaml` 只给 mihomo。切内核后原来的链接要么加载失败，要么被忽略。三条路：

**A. 切内核时改链接（最直接）**

两个站点集各改一次地址，共 4 处：

| 内核 | 成人 | 赌博 |
|---|---|---|
| sing-box | `.../rulesets/singbox/adult.srs` | `.../rulesets/singbox/gambling.srs` |
| mihomo | `.../rulesets/mihomo/adult-classical.yaml` | `.../rulesets/mihomo/gambling-classical.yaml` |

**B. 只用 DNS 域名过滤（推荐，内核无关）**

DNS 设置 → 域名过滤，挂 adblock 名单：

```
成人: https://cdn.jsdelivr.net/gh/hagezi/dns-blocklists@main/adblock/nsfw.txt
赌博: https://cdn.jsdelivr.net/gh/hagezi/dns-blocklists@main/adblock/gambling.mini.txt
```

DNS 过滤由面板统一注入，两个内核都支持，而且名单自动更新。目标分流那边就只留少量关键词规则（比如 `baidu`），切内核完全不用改。

缺点：设备自带 DoH / 私人 DNS 时拦不住，需要连接层兜底。

**C. 两边都留，按当前内核启用**

建 4 个站点集（成人-singbox、成人-mihomo、赌博-singbox、赌博-mihomo），只启用当前内核对应的两个。切内核时点两下电源图标即可，不用改 URL。

## 更新流程

```sh
vi rulesets/singbox/adult.json        # 只改 json / yaml，别手改 srs
SINGBOX=/path/to/sing-box ./build.sh  # 重新编译
git add -A && git commit -m update && git push
```

推完在面板点规则集的「立即更新」，或等 24 小时自动拉。

## 注意事项

- **仓库必须公开**：面板拉规则集不带认证
- **用 raw 直链**，不要用带 `?raw=true` 的页面
- **jsDelivr 有缓存**：推送后可能延迟几小时
- **别手改 `.srs`**：二进制，改 json 再编译
- 名单快照 2026-11-21，来自 hagezi/dns-blocklists（nsfw、gambling.mini），之后不会自动更新

## 自检

```sh
SINGBOX=/path/to/sing-box ./build.sh   # 无报错即格式正确
```
