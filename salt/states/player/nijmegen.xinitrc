#!/bin/sh

setterm -blank 0 -powersave off -powerdown 0
xset s off
xset -dpms

i3 &

exec /home/nijmegen/repo/pynijmegen/src/launcher.py -v
