xrandr --output HDMI1 --off
xrandr --output eDP1 --mode 1366x768 --primary
xrandr --output HDMI1 --mode 1920x1080 --right-of eDP1
wal -R
change-background.sh
