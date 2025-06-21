#!/bin/bash

hyprctl monitors -j | jq '.[] | select(.focused) | .activeWorkspace.id'

socat -u UNIX-CONNECT:"$XDG_RUNTIME_DIR/hypr/$HYPRLAND_INSTANCE_SIGNATURE/.socket2.sock" - |
  stdbuf -o0 awk -F '>>|,' '
    /^workspace>>/ { print $2; fflush() }
    /^focusedmon>>/ { print $3; fflush() }
  '
