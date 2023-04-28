#!/bin/bash

muted=$(pactl list sinks | grep 'Mute:' | tail -n 1 | cut -d ' ' -f 2)

if [[ $muted == 'yes' ]]; then
    echo M
else
    vol=$(pactl list sinks | grep 'Volume: front-left' | tail -n 1 | cut -d ' ' -f 6 | cut -d '%' -f 1)
    echo $vol
fi
