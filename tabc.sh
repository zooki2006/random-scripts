#!/bin/sh

# Usage:
# tabc.sh <command>
# Commands:
#    add <direction-of-tabbed> <window-id> - Add window to tabbed
#    remove <window-id> - Remove window from tabbed
#    list <tabbed-id> - List all clients of tabbed
#tabbedname="awesometabbed"
#
# Functions
#

# Get wid of root window
get_root_wid () {
	xwininfo -root | awk '/Window id:/{print $4}'
}
# Get children of tabbed
get_clients () {
	id=$1
	xwininfo -id $id -children | sed -n '/[0-9]\+ \(child\|children\):/,$s/ \+\(0x[0-9a-z]\+\).*/\1/p'
}

# Get class of a wid
get_class () {
	id=$1
  if [ -z $id ]; then
    echo ""
  else
	  xprop -id $id | sed -n '/WM_CLASS/s/.*, "\(.*\)"/\1/p'
  fi
}

#
# Main Program
#


cmd=$1

if [ "$cmd" = "add" ] || [ "$cmd" = "remove" ]
then

	if [ "$3" = "-n" ]
	then
		tabbedname="$4"
	else
		tabbedname="awesometabbed"
	fi
else
	if [ "$2" = "-n" ] 
	then
		tabbedname="$3"
	else
		tabbedname="awesometabbed"
	fi
fi

if [ "$cmd" = "autoadd" ]
then

wid=$(xprop -root _NET_ACTIVE_WINDOW | sed "s,_NET_ACTIVE_WINDOW(WINDOW): window id # ,," | sed "s, ,,g")
fi

if [ "$cmd" = "add" ] || [ "$cmd" = "autoadd" ]
	then
  	#tabbedid=$(bspc query -N -n $2)
	#tabbedid=$(wmctrl -lx | grep "tabbed.tabbed" | awk '{ print $1 }')
    	tabbedid=$(xdotool search --classname $tabbedname | tail -n1)
  	if [ -z $tabbedid ]; then
    		tabbed -c -n $tabbedname &
    		sleep 0.2
    		tabbedid=$(xdotool search --classname $tabbedname | tail -n1)
    		#tabbedid=$(xdotool search --class tabbed | tail -n1)
  	fi
fi

case $cmd in
	add)
		wid=$2
		xdotool windowreparent $wid $tabbedid
		;;

	autoadd)
		xdotool windowreparent $wid $tabbedid
		;;
	autoremove)
		#tabbedid=$(wmctrl -lx | grep "$tabbedname.tabbed" | awk '{ print $1 }')
		tabbedid=$(xprop -root _NET_ACTIVE_WINDOW | sed "s,_NET_ACTIVE_WINDOW(WINDOW): window id # ,," | sed "s, ,,g")
		wid=$(xwininfo -id $tabbedid -children | sed -n '/[0-9]\+ \(child\|children\):/,$s/ \+\(0x[0-9a-z]\+\).*/\1/p' | awk 'NR == 1')
    		if [ -z $wid ]
		then
			exit
		fi
		tabbedcheck=$(xdotool getwindowclassname $tabbedid)
		#notify-send "$tabbedcheck"
		if ! [ "$tabbedcheck" = "tabbed" ]
		then
			exit
		fi
		#tabbedid=$(bspc query -N -n focused)
		xdotool windowreparent $wid $(get_root_wid)
		nextchild=$(xwininfo -id $tabbedid -children | sed -n '/[0-9]\+ \(child\|children\):/,$s/ \+\(0x[0-9a-z]\+\).*/\1/p' | awk 'NR == 1')
		;;

	remove)
		wid=$2
		tabbedid=$(wmctrl -lx | grep "$tabbedname.tabbed" | awk '{ print $1 }')
		#tabbedid=$(wmctrl -lx | grep "tabbed.tabbed" | awk '{ print $1 }')
    		#tabbedid=$(bspc query -N -n focused)
		xdotool windowreparent $wid $(get_root_wid)
		;;
	list)
		tabbedid=$2
		get_clients $tabbed
		;;
esac
