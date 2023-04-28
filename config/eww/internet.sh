#!/bin/bash

i=$(nmcli connection show --active | grep wifi)

if [[ $? != 0 ]]; then
    echo 
else
    echo 
fi
