#!/bin/sh
syntax="espeak -s 125"
if ! [ -z "$(pgrep "espeak")" ]
then
pkill "espeak"
fi
if [ "$WAYLAND_DISPLAY" ]
then
clipboard="$(wl-paste)"
else
clipboard="$(xclip -o)"
fi
if [ -n "$clipboard" ]
then
	$syntax "$clipboard"
else
	$syntax "no items in clipboard"
fi
