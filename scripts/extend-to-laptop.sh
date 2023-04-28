xrandr --output eDP1 --off
xrandr --output HDMI1 --mode 1920x1080 --primary
xrandr --output eDP1 --mode 1920x1080 --left-of HDMI1
bspc monitor eDP1 -d I II III IV V VI VII VIII IX X
killall polybar
MONITOR=eDP1 polybar main & disown %1
wal -R
change-background.sh
