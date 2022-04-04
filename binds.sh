#!/bin/sh

grep XK_ $HOME/src/dwm/config.h | grep MODKEY | awk {'print $2 " " $3 " --- " $4 " " $7'} | grep -v { | sed 's/,//g' | sed 's/XK_//g' | sed 's/&//g' | sed 's/|ShiftMask/ Shift +/g' | sed 's/MODKEY/MOD +/g' | sed 's/|ControlMask/ Ctrl +/g' | sed 's/}//g' | column


read
