SCREENSHOT=$HOME/Pictures/screenshots/$(date -Iseconds | tr : _ | tr + -).png
touch $SCREENSHOT
import -window root $SCREENSHOT
