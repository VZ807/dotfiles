init=$(cat /sys/class/backlight/.../brightness)
echo $init
init=$((($init*100) / 62451))
if (($init > 90)); then 
    eww update bright-sym=
elif (($init > 80)); then 
    eww update bright-sym=
elif (($init > 70)); then 
    eww update bright-sym=
elif (($init > 60)); then 
    eww update bright-sym=
elif (($init > 50)); then 
    eww update bright-sym=
elif (($init > 40)); then 
    eww update bright-sym=
elif (($init > 30)); then 
    eww update bright-sym=
elif (($init > 20)); then 
    eww update bright-sym=
elif (($init > 10)); then 
    eww update bright-sym=
fi

b=$(readlink -f /sys/class/backlight/*/brightness)
l=""
inotifywait -mqe modify "$b" |while read -r _; do
    v=$(<"$b")
    if [[ "$v" != "$l" ]] then 
        echo "$v"
        l="$v"
        PERCENT=$((($v*100) / 62451))

if (($PERCENT > 90)); then 
    eww update bright-sym=
elif (($PERCENT > 80)); then 
    eww update bright-sym=
elif (($PERCENT > 70)); then 
    eww update bright-sym=
elif (($PERCENT > 60)); then 
    eww update bright-sym=
elif (($PERCENT > 50)); then 
    eww update bright-sym=
elif (($PERCENT > 40)); then 
    eww update bright-sym=
elif (($PERCENT > 30)); then 
    eww update bright-sym=
elif (($PERCENT > 20)); then 
    eww update bright-sym=
elif (($PERCENT > 10)); then 
    eww update bright-sym=
fi
    fi
done























