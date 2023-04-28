#!/bin/bash
# img=$(mktemp /tmp/XXXXXXXXXXXXX.png)
# import -silent -window root $img
# convert $img -scale 10% -scale 1000% $img
# convert $img -blur 1,5 $img
i3lock -i ~/Wallpapers/wallpaper21_1080.png -k \
    --indicator \
    --ind-pos="x+41:y+h-41" \
    --radius=25 \
    --ring-width=5 \
    --line-uses-inside \
    --time-pos="ix+41:iy+14" \
    --time-align 1 \
    --verif-pos="ix+35:iy-34" \
    --verif-align 2 \
    --verif-text="Verifying..." \
    --wrong-pos="ix+24:iy-34" \
    --wrong-align 2 \
    --wrong-text="Failure!" \
    --inside-color="00000000" \
    --ring-color="1d1d1d" \
    --separator-color="00000000" \
    --insidever-color="00000000" \
    --insidewrong-color="d23c3dff" \
    --ringver-color="ffffffff" \
    --ringwrong-color="ffffffff" \
    --keyhl-color="d23c3dff" \
    --bshl-color="d23c3dff" \
    --time-color="1d1d1d" \
    --verif-color="1d1d1d" \
    --wrong-color="d23c3dff" \
    --wrong-font="sans-serif" \
    --verif-font="sans-serif" \
    --time-font="sans-serif" \
    --date-str "" \
    --time-size="32" \
    --verif-size="12" \
    --wrong-size="12"
# rm $img
