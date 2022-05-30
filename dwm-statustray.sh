#!/bin/sh
dwmstat="on"
while [ "$dwmstat" = on ]; do
	tray=""
#	while read trayitems
#	do
#	       	program=$(echo $trayitems | awk '{print $1}')	
#	       	trayname=$(echo $trayitems | awk '{print $2}')
#		if pgrep -x "$program" > /dev/null
#		then
#			temptray="[$trayname]"
#			tray="$tray $temptray"
#		fi
#
#	done < ~/tray.conf
	tray=$(/opt/Ibin/scripts/zuki-tray.sh)
	total=$(cat ~/.scratchpad/dynamic/dynamicnum)
	if [ "$total" = 0 ]
	then
		xsetroot -name "$tray $(date)"
	else
		xsetroot -name "[$total] $tray $(date)"
	fi
	sleep 4.9 
	if ! pgrep -x "dwm" > /dev/null && ! pgrep -x "wm-stat" > /dev/null
	then
		dwmstat="off"
	fi

done
