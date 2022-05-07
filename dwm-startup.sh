#!/bin/sh
dwm="on"
csum=$(sha1sum $(which dwm-statustray.sh))
while ! pgrep -x "dwm" > /dev/null
do
	sleep 0.1
done

dwm-statustray.sh &
while [ "$dwm" = on  ]; do
	#xsetroot -name "$(date)"
	sleep 1 
	new_csum=$(sha1sum $(which dwm-statustray.sh))
	if [ "$csum" != "$new_csum" ]
	    then
	        csum=$new_csum
		pkill dwm-statustray
		sleep 0.1
        	dwm-statustray &
	fi
done

