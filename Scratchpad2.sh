#!/bin/sh
arg1="$1"
arg2="$2"
arg3="$3"
class1="$arg1"
class2="$arg2"
id=$(wmctrl -lx | awk '{ print $1 " " $3 " " }' | grep " $class1.$class2 " | awk '{ print $1 }' | sed 's, ,,g')
echo "$id"
read testing
file=~/.scratchpad/$arg1
filecon=$(cat $file)
echo "t"
cat "$file"
echo "t"

echo "$id"
if [ -z "$id" ]  && ! [ -z "$filecon" ] 
then
	id=$filecon
fi
echo "$id"

if [ "$id" = "" ] 
then

	echo "exec $arg3"

else
	state=$(xprop -id "$id" WM_STATE | grep 'window state' | awk '{print $3}')
	if [ "$state" = "Withdrawn" ]
	then
		xdo show $id
		echo "" > $file
	else
		xdo hide $id
		echo "$id" > $file
	fi
fi
