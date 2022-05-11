#!/bin/sh

# Usage:
# tabc.sh <command>
# Commands:
#    add <direction-of-tabbed> <window-id> - Add window to tabbed
#    remove <window-id> - Remove window from tabbed
#    list <tabbed-id> - List all clients of tabbed
tabbedname="discordtabbed"


wid=$(xdotool search --classname crx_magkoliahgffibhgfkmoealggombgknl)
if [ "$wid" = "" ]
then
	discord &
	while [ "$wid" = "" ]
	do
		sleep 0.1
		wid=$(xdotool search --classname crx_magkoliahgffibhgfkmoealggombgknl)
	done
fi
# Get wid of root window

tabbedid=$(xdotool search --classname $tabbedname | tail -n1)
if [ -z $tabbedid ]; then
    	tabbed -c -n $tabbedname &
	while [ -z $tabbedid ]
	do
	sleep 0.1
	tabbedid=$(xdotool search --classname $tabbedname | tail -n1)
	done
fi

xdotool windowreparent $wid $tabbedid
