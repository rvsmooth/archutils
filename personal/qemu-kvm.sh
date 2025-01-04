#!/usr/bin/env bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR"/../icandy/colors.sh

PKGS=(
	"bridge-utils"
	"dmidecode"
	"dnsmasq"
	"eptables"
	"iptables"
	"openbsd-netcat"
	"qemu"
	"qemu-full"
	"vde2"
	"virt-manager"
	"virt-viewer"
)

PYELL Installing Utilities......
$SPS "${PKGS[@]}"
PDONE

## virt-manager setup
PYELL Setting up virt-manager
sudo systemctl enable libvirtd.service --now
sleep 1
systemctl status libvirtd.service
sudo usermod -a -G libvirt $(whoami)
sudo usermod -a -G kvm $(whoami)
sudo systemctl restart libvirtd.service
PDONE

