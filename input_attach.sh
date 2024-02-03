#!/bin/sh

virsh attach-device win10 $XDG_CONFIG_HOME/VFIOinput/input_mouse.xml
virsh attach-device win10 $XDG_CONFIG_HOME/VFIOinput/input_keyboard.xml
virsh attach-device win10-clone $XDG_CONFIG_HOME/VFIOinput/input_mouse.xml
virsh attach-device win10-clone $XDG_CONFIG_HOME/VFIOinput/input_keyboard.xml
virsh attach-device win10-clone1 $XDG_CONFIG_HOME/VFIOinput/input_mouse.xml
virsh attach-device win10-clone1 $XDG_CONFIG_HOME/VFIOinput/input_keyboard.xml
