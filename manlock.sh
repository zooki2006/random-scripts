#!/bin/sh
export PRIMARY_DISPLAY="$(xrandr | awk '/ primary/{print $1}')"
dimscreen=10
pkill xidlehook
xrandr --output "$PRIMARY_DISPLAY" --brightness 0
slock 
xrandr --output "$PRIMARY_DISPLAY" --brightness 1
#lock.sh  
