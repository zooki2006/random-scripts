#!/bin/sh
#loopped=1
#while [ $loopped = 1 ]
while [ 1 = 1 ]
do
#clean after last loop
script='exit'

clipmenud_pid=$(pgrep -u "$(id -u)" -nf 'clipmenud$')
if [ -z "$clipmenud_pid" ]
then

choice=$(echo "start\nclear\nkill\nexit" | dmenu -p "clipmenud not running")
else
choice=$(echo "enable\ndisable\nkill\nclear\nexit" | dmenu)
#ls | grep "dmenu" | dmenu
#$choice


fi
case "$choice" in
	"start") script='clipmenud' ;;
	"enable") script='clipctl enable' ;;
	"disable") script='clipctl disable' ;;
	"kill") 
		kill $clipmenud_pid
		exit
		;;
	"clear") script='clipdel -d ".*"' ;;
	"exit") exit ;;
esac
#run script
$script
#if ! $script ; then
#	notify-send "fail"
#fi

done
