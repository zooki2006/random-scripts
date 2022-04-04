#!/bin/sh
dwmstat="on"
while [ "$dwmstat" = on ]; do
	xsetroot -name "$(date)"
	sleep 1 
  if ! pgrep -x "dwm" > /dev/null
    then
      dwmstat="off"
    fi
done
