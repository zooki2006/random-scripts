#!/usr/bin/env bash
all_args=("$@")
arg1=$1
arg2=$2
arg3="${all_args[@]:2}"
case $arg1 in
		"title")
				id=$(xdo id -n $arg2)
				;;
		"class")
				id=$(xdo id -N $arg2)
				;;
		*)
				echo "Wrong Option!"
				;;
esac

echo $id
echo $arg3

if [ "$id" == "" ]
 then
		 sleep 0.3 && uptray.sh &
		 $arg3
		 uptray.sh
else
		if [ "$(printf '%s' "$GDMSESSION" | grep bspwm | wc -l)" == "1" ]
		then
				bspc node $(printf $id) -g hidden -d focused -f
		else
				state=$(xprop -id "$id" WM_STATE | grep 'window state' | awk '{print $3}')
				if [ "$state" == "Withdrawn" ] && ! [ "$state" == "normal" ]
				then
						if [ "$arg1" == "class" ]
						then
							xdo show -a $arg2
						else
							xdo show -N $arg2
						fi
				else
						if [ "$arg1" == "class" ]
						then
							xdo hide -a $arg2
						else
							xdo hide -N $arg2
						fi
				fi
		fi
fi
