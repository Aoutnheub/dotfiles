xrandr --output HDMI1 --off
xrandr --output eDP1 --mode 1920x1080 --primary
xrandr --output HDMI1 --mode 1920x1080 --right-of eDP1
wal -R
change-background.sh
bspc monitor HDMI1 -d I II III IV V VI VII VIII IX X
eww open main-laptop
eww open main-monitor
