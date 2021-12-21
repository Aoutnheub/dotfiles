#!/usr/bin/bash

xinput set-prop "HUION PenTablet stylus" --type=float "Coordinate Transformation Matrix" 1.055 0 -0.04 0 1.12 -0.07 0 0 1
xinput set-prop "HUION PenTablet stylus" --type=float "libinput Tablet Tool Pressurecurve" 0 0 0 0 0.3 0.3 0.3 0.3
stylus=$(xsetwacom list dev | sed -r "s/([^\s])\s+/\1 /g" | cut -d " " -f 6 | tail -1)
xsetwacom set $stylus Button 2 3
xsetwacom set $stylus Button 3 2
