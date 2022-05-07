check () {
	checkvar=$1
	program=$2
	if ! pgrep -x "$checkvar" > /dev/null
	then	
		$program &
	fi
}
while pgrep -x "Xorg" > /dev/null
do
check pipewire /usr/bin/pipewire 
check pipewire-media- /usr/bin/pipewire-pulse 
sleep 0.3 
check pipewire-pulse /usr/bin/pipewire-media-session
sleep 10
done
pkill pipewire
pkill pipewire-media-
pkill pipewire-pulse
