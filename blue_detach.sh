#!/bin/sh
virsh attach-device win10-clone $XDG_CONFIG_HOME/VFIOinput/input_mouse.xml

virsh detach-device win10 $XDG_CONFIG_HOME/VFIOinput/input_mouse.xml 
virsh detach-device win10-clone $XDG_CONFIG_HOME/VFIOinput/input_mouse.xml 
