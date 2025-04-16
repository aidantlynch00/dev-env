#!/bin/sh

capacity_file=$(
    find -L /sys/class/power_supply/ -maxdepth 2 -type f -path "*/BAT[0-9]/*" -iname "capacity" 2> /dev/null |
    sort |
    head -n1
)

if [ -n "$capacity_file" ]; then
    capacity=$(cat "$capacity_file")
    red=$(tput setaf 1)
    green=$(tput setaf 2)
    yellow=$(tput setaf 3)
    if   [ $capacity -le   5 ]; then printf "󰂎 $red";
    elif [ $capacity -le  15 ]; then printf "󰁺 $red";
    elif [ $capacity -le  25 ]; then printf "󰁻 $red";
    elif [ $capacity -le  35 ]; then printf "󰁼 $yellow";
    elif [ $capacity -le  45 ]; then printf "󰁽 $yellow";
    elif [ $capacity -le  55 ]; then printf "󰁾 $yellow";
    elif [ $capacity -le  65 ]; then printf "󰁿 ";
    elif [ $capacity -le  75 ]; then printf "󰂀 ";
    elif [ $capacity -le  85 ]; then printf "󰂁 ";
    elif [ $capacity -le  95 ]; then printf "󰂂 ";
    elif [ $capacity -le 100 ]; then printf "󰁹 ";
    fi

    reset=$(tput sgr0)
    printf "$capacity%%$reset"
else
    printf "󰚥"
fi
