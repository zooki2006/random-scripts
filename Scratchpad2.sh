#!/bin/sh
arg1="$1"
arg2="$2"
arg3="$3"
class1="$arg1"
class2="$arg2"
xpropalt () {
winid=$(xprop -root _NET_CLIENT_LIST | sed 's!,!\n!g' | sed 's!#!\n!' | grep -v "_NET")
wincid=$(echo "$winid" | wc -l)
#classid=$(xprop -id 0xe0002d WM_CLASS | sed 's!=!\n!' | grep -v "WM_CLASS" | sed 's!"!!g' | sed 's#,##')
for i in `seq $wincid`
do
	classid=$(xprop -id $(echo "$winid" | awk "NR==$i") WM_CLASS | sed 's!,!!g' | sed 's!=!\n!' | grep -v "WM_CLASS" | sed 's!"!!g')
	echo "$(echo "$winid" | awk "NR==$i") $classid "
done
}
id=$(wmctrl -lx | awk '{ print $1 " " $3 " " }' | grep " $class1.$class2 " | awk '{ print $1 }' | sed 's, ,,g')
#id=$(xpropalt | grep "  $class1 $class2 " | awk '{ print $1 }' | sed 's, ,,g')
echo "$id"
file=~/.scratchpad/$arg1
filecon=$(cat $file)
#echo "t"
#cat "$file"
#echo "t"

echo "$id"
if [ -z "$id" ]  && ! [ -z "$filecon" ] 
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
