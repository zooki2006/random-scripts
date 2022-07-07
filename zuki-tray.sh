#!/bin/sh
tray=""
arg1="$1"


if [ "$BLOCK_BUTTON" = 1 ]
then
	dmenu-tray2.sh
fi

psa=$(ps -A | awk '{print $4}')
while read trayitems
do
       	program=$(echo "$trayitems" | awk '{print $1}')	
	#if pgrep -x "$program" > /dev/null
	psas=$(echo "$psa" | grep -i ^"$program"$)
	#if $psas = ""  > /dev/null
	#echo "$psas"
	if ! [ "$psas" = "" ]
	then
       		trayname=$(echo "$trayitems" | awk '{print $2}')
		#temptray="[$trayname]"
		#tray="$temptray $tray"
		if [ "$arg1" = 1 ]
		then
			echo "pkill $program"
		else

			#tray="[$trayname] $tray"
			tray="$trayname $tray"
		fi
	fi
done < ~/tray.conf


if [ "$arg1" = 1 ]
then
	echo "exit"
else
	echo "$tray"
fi
#case $BLOCK_BUTTON in
#	1)dmenu-tray2.sh ;;
#	2) pamixer -t ;;
#	4) pamixer --allow-boost -i 1 ;;
#	4) notify-send "test" ;;
##	5) pamixer --allow-boost -d 1 ;;
#	3) notify-send "📢 Volume module" "\- Shows volume 🔊, 🔇 if muted.
#- Middle click to mute.
#- Scroll to change." ;;
#esac

#if ! [ -z $BLOCK_BUTTON ]
#then 

#fi
