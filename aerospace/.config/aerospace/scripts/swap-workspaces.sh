#!/bin/zsh
set -euo pipefail

if [ "$#" -ne 2 ]; then
  echo "Usage: swap-workspaces.sh <workspace-a> <workspace-b>" >&2
  exit 2
fi

A="$1"
B="$2"

if [ "$A" = "$B" ]; then
  exit 0
fi

TMP="__swap_${A}_${B}_$(date +%s)"

get_ids() {
  aerospace list-windows --workspace "$1" --format '%{window-id}' 2>/dev/null | sed '/^$/d'
}

move_ids() {
  local dst="$1"
  shift

  for id in "$@"; do
    [ -n "$id" ] || continue
    aerospace move-node-to-workspace --window-id "$id" "$dst" >/dev/null 2>&1 || true
  done
}

A_IDS=("${(@f)$(get_ids "$A")}")
B_IDS=("${(@f)$(get_ids "$B")}")

move_ids "$TMP" "${A_IDS[@]}"
move_ids "$A" "${B_IDS[@]}"
move_ids "$B" "${A_IDS[@]}"

aerospace workspace "$A" >/dev/null 2>&1 || true
