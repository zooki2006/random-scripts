#!/bin/sh
mkdir "$HOME/aur"
cd "$HOME/aur"
git clone https://aur.archlinux.org/aurutils.git
cd aurutils-git
makepkg -si
aurrepo="custom"
aurcustom="[options]
CacheDir = /var/cache/pacman/pkg
CacheDir = /var/cache/pacman/$aurrepo
CleanMethod = KeepCurrent

[$aurrepo]
SigLevel = Optional TrustAll
Server = file:///var/cache/pacman/$aurrepo"
pacmandir="/etc/pacman.d"
pacmanconf="/etc/pacman.conf"
sudo touch "$pacmandir/$aurrepo"
sudo echo "$aurcustom" > "$pacmandir/$aurrepo"
sudo echo "Include = $pacmandir/$aurrepo" >> /etc/pacman.conf
sudo install -d "/var/cache/pacman/$aurrepo" -o $USER
repo-add "/var/cache/pacman/$aurrepo/$aurrepo.db.tar"
cd "/var/cache/pacman/$aurrepo"
aurpkg="$(pacman -Qm | sed 's/ .*//')"
aur sync "$aurpkg"
sudo pacman -Syu
aur sync -u
