#!/bin/sh
file=~/.scratchpad/dynamic/dynamic
arg1="$1"
if [ "$arg1" = "1" ]
then
activewin=$(xprop -root _NET_ACTIVE_WINDOW | sed 's,#,\n,' | tail -1)
xdo hide $activewin
echo "$activewin" >> $file 
else
	filecon=$(cat $file)
	filecon1=$(echo "$filecon" | grep -v "#" | tail -1)
	xdo show $filecon1
	echo "$filecon" | grep -v "$filecon1" > $file
fi
echo "$(cat $file | wc -l)" > ~/.scratchpad/dynamic/dynamicnum
pkill -RTMIN+26 dwmblocks
