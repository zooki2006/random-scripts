#!/bin/sh
arg1="$1"
arg2="$2"
arg3="$3"
if ! [ "$arg1" = "NULL" ]
then
	class1=$(xdo id -n "$arg1" | sed 's#x0#x#' | sed 's#x0#x#')
else
	id=$(xprop -root _NET_CLIENT_LIST | sed 's!,!\n!g' | sed 's!#!\n!' | grep -v "_NET" | sed 's, ,,' | grep -io "$class2")
fi
if ! [ "$arg2" = "NULL" ]
then
	class2=$(xdo id -N "$arg2" | sed 's#x0#x#' | sed 's#x0#x#')
else
	id=$(xprop -root _NET_CLIENT_LIST | sed 's!,!\n!g' | sed 's!#!\n!' | grep -v "_NET" | sed 's, ,,' | grep -io "$class1")
fi
if ! [ "$class1" = "" ] && [ "$class1" = "" ]
then
	id=$(xprop -root _NET_CLIENT_LIST | sed 's!,!\n!g' | sed 's!#!\n!' | grep -v "_NET" | sed 's, ,,' | grep -io "$class1" | grep -io "$class2")
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
