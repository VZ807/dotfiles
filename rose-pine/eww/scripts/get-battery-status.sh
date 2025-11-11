LEVEL=$(cat /sys/class/power_supply/BAT0/capacity)
STATUS=$(cat /sys/class/power_supply/BAT0/status)


if [ "$LEVEL" -lt 15 ] && [ "$STATUS" = "Discharging" ]; then 
    echo "critical"
elif [ "$STATUS" = "Charging" ]; then 
    echo "charging"
elif [ "$STATUS" = "Discharging" ] || [ "$STATUS" = "Not charging" ]; then
    echo "discharge"
elif [ "$STATUS" = "Full" ]; then
    echo "full"
fi
