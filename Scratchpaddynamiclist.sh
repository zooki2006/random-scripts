#!/bin/sh

file=~/.scratchpad/dynamic/dynamic
while read list
do
notify-send "$(xprop WM_CLASS -id $list | awk '{ print $3 }' | sed 's#,##' | sed 's#"##g' )" "$(xprop _NET_WM_NAME -id $list | sed 's,_NET_WM_NAME,,' | sed 's,(UTF8_STRING),,' | sed 's, = ,,')"

done < $file

#notify-send "$(xprop WM_CLASS -id $(cat $file | grep '0x' | awk 'NR==1') | awk '{ print $3 }' | sed 's#,##' | sed 's#"##g' )" "$(xprop _NET_WM_NAME -id $(cat $file | grep '0x' | awk 'NR==1') | sed 's,_NET_WM_NAME,,' | sed 's,(UTF8_STRING),,' | sed 's, = ,,')"


#notify-send "$(xprop _NET_WM_NAME -id $(cat ~/.scratchpad/dynamic/dynamic | grep '0x') | sed 's,_NET_WM_NAME,,' | sed 's,(UTF8_STRING),,' | sed 's, = ,,')"
