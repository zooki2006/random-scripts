#!/bin/sh
syntax="espeak -s 125"
if ! [ -z "$(pgrep "espeak")" ]
then
pkill "espeak"
fi
clipboard="$(xclip -o)"
if ! [ -z "$clipboard" ]
then
	$syntax "$(xclip -o)"
else
	$syntax "no items in clipboard"
fi
