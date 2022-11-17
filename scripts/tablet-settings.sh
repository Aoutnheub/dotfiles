#!/usr/bin/bash

xinput set-prop "HUION PenTablet stylus" --type=float "Coordinate Transformation Matrix" 1.055 0 -0.04 0 1.12 -0.07 0 0 1
xinput set-prop "HUION PenTablet stylus" --type=float "libinput Tablet Tool Pressurecurve" 0 0 0 0 0.3 0.3 0.3 0.3
stylus=$(xsetwacom list dev | sed -r "s/([^\s])\s+/\1 /g" | cut -d " " -f 6 | head -1)
xsetwacom set $stylus Button 2 3
xsetwacom set $stylus Button 3 2
pad=$(xsetwacom list dev | sed -r "s/([^\s])\s+/\1 /g" | cut -d " " -f 6 | tail -1)
# xsetwacom set $pad Button 1 "key +ctrl z -ctrl"
# xsetwacom set $pad Button 2 "key +shift +ctrl e -ctrl -shift"
# xsetwacom set $pad Button 3 "key +shift +ctrl p -ctrl -shift"
# xsetwacom set $pad Button 8 "key +ctrl +shift equal -shift -ctrl"
# xsetwacom set $pad Button 9 "key +ctrl minus -ctrl"
# xsetwacom set $pad Button 10 "key +ctrl 5 -ctrl"
# xsetwacom set $pad Button 11 "key +ctrl 6 -ctrl"
# xsetwacom set $pad Button 12 "key +shift +ctrl g -ctrl -shift"
