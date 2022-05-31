#!/bin/sh
arg1="$1"
arg2="$2"
arg3="$3"
class1=$(xdo id -n "$arg1")
class2=$(xdo id -N "$arg2")
if ! [ "$class1" = "" ]
then
	id=$(xprop -root _NET_CLIENT_LIST | sed 's!,!\n!g' | sed 's!#!\n!' | grep -v "_NET" | sed 's, ,,' | tr 'a-z' 'A-Z' | sed 's#X#x0#' | grep "$class1" | grep "$class2")
fi
file=~/.scratchpad/$arg1
touch $file
filecon=$(cat $file)
echo "$id"
if [ -z "$id" ] && ! [ -z "$filecon" ] 
then
	id=$filecon
fi
echo "$id"

if [ "$id" = "" ] 
then

	$arg3
	echo "" > $file

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
