#!/bin/sh
virsh detach-device win10 $XDG_CONFIG_HOME/VFIOinput/bluetooth.xml 
virsh detach-device win10-clone $XDG_CONFIG_HOME/VFIOinput/bluetooth.xml 
