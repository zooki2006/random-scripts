#!/bin/sh
mkdir -p /etc/hosts.d
wget https://raw.githubusercontent.com/StevenBlack/hosts/master/hosts -O /etc/hosts.d/99blocklist.conf
#wget http://www.mvps.org/winhelp2002/hosts.txt -O /etc/hosts.d/99blocklist.conf
cp /etc/hosts /etc/hosts.bak
cat /etc/hosts.d/*.conf > /etc/hosts
