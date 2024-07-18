#!/bin/bash
IMG=/tmp/screen.png
scrot $IMG
convert $IMG -scale 5% -scale 2000% $IMG
[[ -f $1 ]] && convert $IMG $1 -gravity center -composite -matte $IMG
i3lock -f -i /tmp/screen.png
rm /tmp/screen.png

