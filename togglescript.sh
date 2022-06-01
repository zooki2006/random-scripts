#!/bin/sh
arg1="$1"
arg2="${all_args[@]:1}"
if pgrep -x "$arg1" > /dev/null
then
	killall $arg1
else
	$arg2
fi

