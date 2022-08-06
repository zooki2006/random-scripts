#!/bin/sh
aurpkg="$(pacman -Qm | sed 's/ .*//')"
aur sync "$aurpkg"
