xrandr --output eDP1 --off
xrandr --output HDMI1 --mode 1920x1080 --primary
xrandr --output eDP1 --mode 1366x768 --left-of HDMI1
wal -R
change-background.sh
