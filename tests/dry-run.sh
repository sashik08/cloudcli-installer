#!/usr/bin/env bash
# Прогон установщика без пакетов и записи в систему.
set -euo pipefail

ROOT="$(cd "$(dirname "$0")/.." && pwd)"
INSTALL="$ROOT/install.sh"
OUT="$(mktemp)"
trap 'rm -f "$OUT"' EXIT

if [ ! -f "$INSTALL" ]; then
  echo "FAIL: нет $INSTALL"
  exit 1
fi

set +e
DRY_RUN=1 AGENT=claude DOMAIN=ai.example.test EMAIL=dev@example.test \
  bash "$INSTALL" >"$OUT" 2>&1
code=$?
set -e

if [ "$code" -ne 0 ]; then
  echo "FAIL: установщик завершился с кодом $code"
  tail -40 "$OUT"
  exit 1
fi

fail() { echo "FAIL: $*"; tail -20 "$OUT"; exit 1; }

grep -q 'DRY-RUN' "$OUT" || fail "нет маркера DRY-RUN"
grep -q 'ai.example.test' "$OUT" || fail "в выводе нет домена"
grep -q 'Claude' "$OUT" || fail "в выводе нет агента Claude"

# Реальные установки не должны уходить в систему.
if grep -qE '^\+ (apt-get|npm|systemctl|ufw) ' "$OUT"; then
  fail "похож на реальную команду установки"
fi

echo "OK: dry-run прошёл"
