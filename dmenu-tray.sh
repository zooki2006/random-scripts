#!/bin/sh
options="exit"
psa=$(ps a | grep -v "tty*" | awk '{print $5  $6}')
while read trayitems
do
	program=$(echo $trayitems | awk '{print $1}')
	#trayname=$(echo $trayitems | awk '{print $2}')
	#psas=$(echo "$psa" | grep -i ^"$program"$)
	#if ! [ "$psas" = "" ]
	if pgrep -x "$program" > /dev/null
	then
                    	trayname=$(echo $trayitems | awk '{print $2}')
			options="kill $program / $trayname \n$options"
	fi

done < ~/tray.conf

while read trayextras
do 
	program=$(echo $trayextras | awk '{$1=""; $2=""; $3=""; print $0}')
	dmenuname=$(echo $trayextras | awk '{print $1}')
	progmamcon=$(echo $trayextras | awk '{print $2}')
	reprogmamcon=$(echo $trayextras | awk '{print $3}')
	psas=$(echo "$psa" | grep $program)
	if ! [ "$psas" = "" ]
	#if pgrep -x "$progmamcon" > /dev/null && ! pgrep -x "$reprogmamcon" > /dev/null
	then 
		options="spawn $dmenuname \n$options"
	fi
	echo $progmamcon
done < ~/trayextras.conf

choice=$(echo "$options" | dmenu -p "tray")

mode=$(echo $choice | awk '{print $1}')

#	"overlay") script='io.github.trigg.discover_overlay -c' ;;
trimchoice=$(echo $choice | awk '{print $2}')

echo $trimchoice
echo $choice

if  [ "$mode" = "kill" ]
then
killall $trimchoice
elif [ "$mode" = "spawn" ]
then

#$trimchoice
while read trayextras
do 
	program=$(echo $trayextras | awk '{$1=""; $2=""; $3=""; print $0}')
	dmenuname=$(echo $trayextras | awk '{print $1}')
	if [ "$trimchoice" = "$dmenuname" ] 
	then
		$program
	fi
done < ~/trayextras.conf


elif [ "$mode" = "exit" ];
then
	exit 0
	#notify-send "dmenu-tray.sh" "crash"
fi
$script
