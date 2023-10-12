#!/bin/bash

./workspaces HDMI1
bspc subscribe desktop node_transfer | while read -r _ ; do
    ./workspaces HDMI1
done

