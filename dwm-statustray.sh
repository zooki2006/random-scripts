#!/bin/sh
dwmstat="on"
while [ "$dwmstat" = on ]; do
	tray=""
	while read trayitems
	do
	       	program=$(echo $trayitems | awk '{print $1}')	
	       	trayname=$(echo $trayitems | awk '{print $2}')
		if pgrep -x "$program" > /dev/null
		then
			temptray="[$trayname]"
			tray="$tray $temptray"
		fi

	done < ~/tray.conf
	xsetroot -name "$tray $(date)"

	sleep 0.9 
	if ! pgrep -x "dwm" > /dev/null && ! pgrep -x "dwm-stat" > /dev/null
	then
		dwmstat="off"
	fi

done
