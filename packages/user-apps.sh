#!/usr/bin/env bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

source "$SCRIPT_DIR"/../icandy/colors.sh

PMAG Installing User Applications......
$SPS brave-bin floor-bin neovim gimp thunderbird obs-studio \
  mpv onlyoffice-bin localsend-bin qbittorrent btop calibre kiwix-desktop musikcube newsboat

PDONE

sleep 2

## virt-manager setup
PBLUE Setting up virt-manager
sudo systemctl enable libvirtd.service --now
sleep 1
systemctl status libvirtd.service
sudo usermod -a -G libvirt $(whoami)
sudo usermod -a -G kvm $(whoami)
sudo systemctl restart libvirtd.service
PDONE
