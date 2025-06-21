#!/bin/bash

# Get default sink name
default_sink=$(pactl info | awk -F': ' '/Default Sink/ {print $2}')

# Function to get volume or muted
get_volume_state() {
    mute=$(pactl get-sink-mute "$default_sink" | awk '{print $2}')
    if [[ "$mute" == "yes" ]]; then
        echo "muted"
    else
        volume=$(pactl get-sink-volume "$default_sink" | grep -o '[0-9]\+%' | head -1 | tr -d "%") 
        echo "$volume"
    fi
}

# Print current state initially
prev_state=$(get_volume_state)
echo "$prev_state"
if [ $prev_state == "muted" ]; then
    eww update "sound-sym="
elif [ $prev_state -lt 15 ]; then
    eww update "sound-sym="
elif [ $prev_state -lt 50 ]; then
    eww update "sound-sym="
elif [ $prev_state -lt 101 ]; then
    eww update "sound-sym="
fi

# Subscribe and listen for changes
pactl subscribe | while read -r line; do
    # Only react to sink events
    if [[ "$line" == *"sink"* ]]; then
        new_state=$(get_volume_state)
        if [[ "$new_state" != "$prev_state" ]]; then
            echo "$new_state"
            prev_state="$new_state"
            if [ $new_state == "muted" ]; then
                eww update "sound-sym="
            elif [ $new_state -lt 15 ]; then
                 eww update "sound-sym="
            elif [ $new_state -lt 50 ]; then
                 eww update "sound-sym="
            elif [ $new_state -lt 101 ]; then
                 eww update "sound-sym="
            fi
        fi
    fi
done
