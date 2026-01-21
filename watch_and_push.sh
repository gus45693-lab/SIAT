#!/usr/bin/env bash
set -euo pipefail

REPO="/Users/yuchanghyeon/Desktop/workspace/html"
cd "$REPO"

# LaunchAgent에서도 fswatch를 찾게 PATH 보강 (Intel/Apple Silicon 둘 다)
export PATH="/usr/local/bin:/opt/homebrew/bin:$PATH"

if ! command -v fswatch >/dev/null 2>&1; then
  echo "fswatch not found. Install: brew install fswatch" >&2
  exit 1
fi

# 변경 이벤트를 조금 묶어서(3초) 너무 잦은 커밋 방지
fswatch -o -l 3 \
  --exclude '\.git/' \
  --exclude 'node_modules/' \
  --exclude '\.DS_Store' \
  --exclude '\.autogitpush\.(log|err\.log)$' \
  . | while read -r _; do
    "$REPO/auto_push.sh" || true
  done
