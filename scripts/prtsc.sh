SCREENSHOT=$HOME/Screenshots/$(date -Iseconds | tr : _ | tr + -).png
touch $SCREENSHOT
import -silent -window root $SCREENSHOT
notify-send $SCREENSHOT
