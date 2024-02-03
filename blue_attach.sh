#!/bin/sh

virsh attach-device win10 $XDG_CONFIG_HOME/VFIOinput/bluetooth.xml
virsh attach-device win10-clone $XDG_CONFIG_HOME/VFIOinput/bluetooth.xml
