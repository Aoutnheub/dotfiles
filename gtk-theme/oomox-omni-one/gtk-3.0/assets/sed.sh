#!/bin/sh
sed -i \
         -e 's/#1b1b1b/rgb(0%,0%,0%)/g' \
         -e 's/#eeffff/rgb(100%,100%,100%)/g' \
    -e 's/#1b1b1b/rgb(50%,0%,0%)/g' \
     -e 's/#d19a66/rgb(0%,50%,0%)/g' \
     -e 's/#1b1b1b/rgb(50%,0%,50%)/g' \
     -e 's/#eeffff/rgb(0%,0%,50%)/g' \
	"$@"
