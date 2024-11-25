#!/usr/bin/env bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

source $SCRIPT_DIR/colors.sh

PMAG Installing User Applications......
$SPS firefox neovim freetube-bin gimp thunderbird obs-studio \
  mpv onlyoffice-bin localsend-bin qbittorrent btop calibre qemu virt-manager \
  virt-viewer dnsmasq vde2 bridge-utils openbsd-netcat dmidecode eptables \
  iptables kiwix-desktop musikcube newsboat

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
