#!/bin/sh
export PRIMARY_DISPLAY="$(xrandr | awk '/ primary/{print $1}')"
dimscreen=10
killall xidlehook
if [ ! $dimscreen = 0 ]
then
	sleep $dimscreen && xrandr --output "$PRIMARY_DISPLAY" --brightness .1 &
fi
slock
xrandr --output "$PRIMARY_DISPLAY" --brightness 1
lock.sh  
