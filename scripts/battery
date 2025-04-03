#!/bin/sh

BAT_CAP_FILE=/sys/class/power_supply/BAT0/capacity
if [ -e $BAT_CAP_FILE ]; then
    capacity=$(cat $BAT_CAP_FILE)
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
