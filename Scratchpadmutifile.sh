#!/usr/bin/env bash
all_args=("$@")
arg1=$1
arg2=$2
arg3="${all_args[@]:2}"
file=~/.scratchpad/$arg2
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
		 exec $arg3;
		 echo "1" > $file
else
		if [ "$(printf '%s' "$GDMSESSION" | grep bspwm | wc -l)" == "1" ]
		then
				bspc node $(printf $id) -g hidden -d focused -f
		else
				#state=$(xprop -id "$id" WM_STATE | grep 'window state' | awk '{print $3}')
				touch $file
				state=$(cat $file)
				if [ "$state" == "0" ]
				then
						if [ "$arg1" == "class" ]
						then
							xdo show -a $arg2
						else
							xdo show -N $arg2
						fi
						echo "1" > $file
				else
						if [ "$arg1" == "class" ]
						then
							xdo hide -a $arg2
						else
							xdo hide -N $arg2
						fi
						echo "0" > $file
				fi
		fi
fi
