#!/bin/bash

readonly -a 'ws_names=("I" "II" "III" "IV" "V" "VI" "VII" "VIII" "IX" "X")'

workspaces() {
    ws_focused=$(bspc query -D -d .focused.local --names)
    ws_occupied=$(bspc query -D -d .occupied.local --names | tr '\n' ' ')

    declare -a ws_arr

    for (( i=0; i < 10; i++ )) do
        name=${ws_names[$i]}
        if [[ $ws_focused == $name ]]; then
            ws_arr[$i]="(button :onclick \"bspc desktop -f $name.local\" (label :class \"offset-icon active-ws\" :text \"\"))"
        elif [[ $(echo " $ws_occupied " | grep " $name ") != "" ]]; then
            ws_arr[$i]="(button :onclick \"bspc desktop -f $name.local\" (label :class \"offset-icon occupied-ws\" :text \"\"))"
        else
            ws_arr[$i]="(button :onclick \"bspc desktop -f $name.local\" (label :class \"offset-icon\" :text \"\"))"
        fi
    done

    echo "(box :class \"workspaces\" :orientation \"v\" :space-evenly true :halign \"center\" :valign \"center\" ${ws_arr[*]})"
}

workspaces
bspc subscribe desktop node_transfer | while read -r _ ; do
    workspaces
done

