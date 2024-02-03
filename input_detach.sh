#!/bin/sh
if [ -z "$XDG_CONFIG_HOME" ]
then
	XDG_CONFIG_HOME="/home/$USER/.config"
	notify-send "t"
fi
virsh detach-device win10 $XDG_CONFIG_HOME/VFIOinput/input_mouse.xml
virsh detach-device win10 $XDG_CONFIG_HOME/VFIOinput/input_keyboard.xml
virsh detach-device win10-clone $XDG_CONFIG_HOME/VFIOinput/input_mouse.xml
virsh detach-device win10-clone $XDG_CONFIG_HOME/VFIOinput/input_keyboard.xml
virsh detach-device win10-clone1 $XDG_CONFIG_HOME/VFIOinput/input_mouse.xml
virsh detach-device win10-clone1 $XDG_CONFIG_HOME/VFIOinput/input_keyboard.xml
