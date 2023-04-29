#!/bin/bash

b=$(upower -i $(upower -e | grep BAT) | grep percentage | cut -d ' ' -f 15 | cut -d '%' -f 1)

if [[ $b == "100" ]]; then
    echo "F"
else
    echo $b
fi
