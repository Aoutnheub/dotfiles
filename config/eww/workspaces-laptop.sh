#!/bin/bash

./workspaces eDP1
bspc subscribe desktop node_transfer | while read -r _ ; do
    ./workspaces eDP1
done

