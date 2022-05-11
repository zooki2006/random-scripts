#!/bin/sh

# Usage:
# tabc.sh <command>
# Commands:
# tabccreate.sh $tabbedclassname $subprogramclass $programexec
# Functions
#
sleep 1
wid=$(wmctrl -lx | grep "$1." | awk '{ print $1 }' | tail -n1 )
if [ "windowpd" = "" ]
then
	wid=$(wmctrl -lx | grep ".$1" | awk '{ print $1 }' | tail -n1 )
fi
tabbedname="$2"

tabbedid=$(xdotool search --classname $tabbedname | tail -n1)
if [ "$tabbedid" = "" ] 
then
tabbed -c -n "$tabbedname" &
sleep 0.2
fi
tabbedid=$(xdotool search --classname $tabbedname | tail -n1)
xdotool windowreparent $wid $tabbedid
