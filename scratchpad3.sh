#!/bin/dash
scriptname="scratchpad 3 script"
scriptdisc="script for scratch pads on xorg"
scripthowto="arg1 arg2 arg3"
scriptreq="script requres xdo and xprop and sed(coreutils) and grep(coreutils)"
source zconf

export N=1
stripn () {
  STRING="$@"
  set -f -- $STRING                                                                               
  shift $((N-1))                                                                               
  echo "$1"                                                                                      
}

arg1="$1"
arg2="$2"

x="$@"
x="${x#* }"
arg3="${x#* }"

if [ "$arg1" != "NULL" ]
then
	class1=$(xdo id -n "$arg1" | sed 's#x0#x#' | sed 's#x0#x#')
fi
if [ "$arg2" != "NULL" ]
then
	class2=$(xdo id -N "$arg2" | sed 's#x0#x#' | sed 's#x0#x#')
fi
preid=$(xprop -root _NET_CLIENT_LIST | sed 's!,!\n!g' | sed 's!#!\n!' | grep -v "_NET" | sed 's, ,,')
if [ -n "$class1" ] 
then
	preid=$(echo "$preid" | grep -io "$class1")
	idchanged=1
fi
if [ -n "$class2" ] 
then
	preid=$(echo "$preid" | grep -io "$class2")
	idchanged=1
fi
if [ -n "$idchanged" ] 
then
id="$preid"
echo "yay"
fi

if [ -z "$1" ]
then 
	echo "no args"
	exit 0
fi


if [ -z "$XDG_CACHE_HOME" ] 
then
scratchpaddir="$HOME/.cache"
else
scratchpaddir="$XDG_CACHE_HOME"
fi
file="$scratchpaddir/scrachpad/$arg1"
mkdir -p "$scratchpaddir/scrachpad"
touch "$file"
filecon=$(cat "$file")
echo "id $id id"
if [ -z "$id" ] && [ -n "$filecon" ] 
then
	id="$filecon"
fi
echo "id $id id"

if [ "$id" = "" ] 
then
	echo "launching"
	$arg3
	echo "" > "$file"

else
	export N=3
	state="$(stripn $(xprop -id "$id" WM_STATE | grep 'window state')  )"
	echo "$state"
	if [ "$state" = "Withdrawn" ]
	then
		xdo show "$id"
		echo "" > "$file"
	else
		xdo hide "$id"
		echo "$id" > "$file"
	fi
fi
