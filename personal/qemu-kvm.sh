#!/usr/bin/env bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR"/../icandy/colors.sh

PMAG Installing Utilities......
$SPS qemu virt-manager virt-viewer dnsmasq vde2 bridge-utils openbsd-netcat dmidecode eptables \
	iptables qemu-full
PDONE

## virt-manager setup
PGREEN Setting up virt-manager
sudo systemctl enable libvirtd.service --now
sleep 1
systemctl status libvirtd.service
sudo usermod -a -G libvirt $(whoami)
sudo usermod -a -G kvm $(whoami)
sudo systemctl restart libvirtd.service
PDONE

