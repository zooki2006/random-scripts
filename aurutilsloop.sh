#!/bin/sh
scriptname="aurutils loop"
scriptdisc="script to install all aur pkg with aurtools"
source zconf
aurpkg="$(pacman -Qm | sed 's/ .*//')"
aur sync "$aurpkg"
