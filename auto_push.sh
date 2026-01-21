#!/usr/bin/env bash
set -euo pipefail

REPO="/Users/yuchanghyeon/Desktop/workspace/html"
cd "$REPO"

# 동시에 여러 번 실행되는 걸 방지
LOCKDIR="/tmp/autogitpush_html.lock"
if ! mkdir "$LOCKDIR" 2>/dev/null; then
  exit 0
fi
trap 'rmdir "$LOCKDIR"' EXIT

git add -A

# 스테이징된 변경 없으면 종료
if git diff --cached --quiet; then
  exit 0
fi

git commit -m "Auto update: $(date '+%Y-%m-%d %H:%M:%S')" || exit 0
git push
