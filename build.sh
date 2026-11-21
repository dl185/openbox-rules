#!/bin/sh
# 从 rulesets/singbox/*.json 重新编译 *.srs
# 用法: SINGBOX=/path/to/sing-box ./build.sh
set -eu
cd "$(dirname "$0")"

SINGBOX=${SINGBOX:-sing-box}
command -v "$SINGBOX" >/dev/null 2>&1 || { echo "找不到 sing-box,用 SINGBOX=/path/to/sing-box 指定" >&2; exit 1; }

for f in rulesets/singbox/*.json; do
	[ -e "$f" ] || continue
	out=${f%.json}.srs
	echo "compile $f -> $out"
	"$SINGBOX" rule-set compile "$f" -o "$out"
done
echo "done"
