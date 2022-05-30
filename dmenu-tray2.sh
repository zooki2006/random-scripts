#!/bin/sh
main () {
psa=$(ps -A | awk '{print $4}')
while read trayitems
do
       	program=$(echo $trayitems | awk '{print $1}')	
	psas=$(echo "$psa" | grep -i ^"$program"$)
	if ! [ "$psas" = "" ]
	then
		echo "pkill $program"
		options="pkill $dmenuname \n$options"
	fi
done < ~/tray.conf
echo "exit"

}
command=$(main | dmenu -p "tray") 
$command
