#!/bin/bash
IMG=/tmp/screen.png
scrot $IMG
convert $IMG -scale 10% -scale 1000% $IMG
[[ -f $1 ]] && convert $IMG $1 -gravity center -composite -matte $IMG
# dbus-send --print-reply --dest=org.mpris.MediaPlayer2.spotify /org.mpris/MediaPlayer2 org.mpris.MediaPlayer2.Player.Stop
i3lock -f -i /tmp/screen.png
rm /tmp/screen.png

