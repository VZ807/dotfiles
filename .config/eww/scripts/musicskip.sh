echo $1

if [ "$1" = "up" ]; then 
    playerctl next
elif [ "$1" = "down" ]; then 
    playerctl previous
fi

