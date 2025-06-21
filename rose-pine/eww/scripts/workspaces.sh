#!/bin/bash

icons=("一" "二" "三" "四" "五" "六" "七" "八" "九" "十")

send_workspaces() {
  hyprctl -j workspaces | jq -c --argjson icons "$(printf '%s\n' "${icons[@]}" | jq -R . | jq -sc '.')" '
    map({
      id: (.id | tonumber),
      icon: ($icons[(.id | tonumber) - 1] // "？")
    }) | sort_by(.id)
  '
}

# Initial emit
send_workspaces

# Subscribe to events
socat -u UNIX-CONNECT:"$XDG_RUNTIME_DIR/hypr/$HYPRLAND_INSTANCE_SIGNATURE/.socket2.sock" - | \
while read -r line; do
  if [[ "$line" == *"workspace>>"* ]]; then
    send_workspaces
  fi
done

