#!/bin/zsh

ws="$(aerospace list-workspaces --focused 2>/dev/null)"
[ -z "$ws" ] && exit 0

current="$(aerospace list-windows --focused --format '%{window-id}' 2>/dev/null || true)"

ids="$(
  aerospace list-windows --workspace "$ws" \
    --format '%{window-id}|%{window-layout}' \
  | awk -F'|' '$2 != "floating" { print $1 }'
)"

[ -z "$ids" ] && exit 0

target="$(
  printf '%s\n' "$ids" | awk -v cur="$current" '
    NR == 1 { first = $1 }
    found && !printed { print $1; printed = 1; exit }
    $1 == cur { found = 1 }
    END { if (!printed && first != "") print first }
  '
)"

[ -n "$target" ] && aerospace focus --window-id "$target"
aerospace move-mouse window-lazy-center >/dev/null 2>&1 || true
