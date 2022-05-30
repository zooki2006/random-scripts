#!/usr/bin/env bash
#mullvad-vpn &

id=$(xdo id -N "Mullvad VPN")


#id=$(xdo id -N $arg2)

if [ "$id" == "" ]
then
	 	 sleep 0.5 && uptray.sh &
		 mullvad-vpn 	 	 
else
		mullvad-vpn &	 	 
		if [ "$(printf '%s' "$GDMSESSION" | grep bspwm | wc -l)" == "1" ]
		then
				bspc node $(printf $id) -g hidden -d focused -f
		else
				state=$(xprop -id "$id" WM_STATE | grep 'window state' | awk '{print $3}')
				if [ "$state" == "Withdrawn" ]
				then
						xdo show $id
				else
						xdo hide $id
				fi
		fi
fi
