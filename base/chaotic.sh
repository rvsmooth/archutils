#!/usr/bin/env bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SPAKU='sudo pacman -U --noconfirm'
SPAKK='sudo pacman-key'

source "$SCRIPT_DIR"/../icandy/colors.sh

PREP_PKGS=(
	"curl"
	"git"
	"paru"
	"wget"
	"unzip"
	"yay"
	"zip"
	)
function install_chaotic(){

  $SPAKK --recv-key 3056513887B78AEB --keyserver keyserver.ubuntu.com
  $SPAKK --lsign-key 3056513887B78AEB
  $SPAKU 'https://cdn-mirror.chaotic.cx/chaotic-aur/chaotic-keyring.pkg.tar.zst'
  $SPAKU 'https://cdn-mirror.chaotic.cx/chaotic-aur/chaotic-mirrorlist.pkg.tar.zst'
  
  echo '[chaotic-aur]
Include = /etc/pacman.d/chaotic-mirrorlist' | sudo tee -a /etc/pacman.conf

}

if [[ -f /etc/pacman.d/chaotic-mirrorlist ]]; then
	PYELL Chaotic-aur is already installed.
	PYELL Installing preparatory packages and paru ..
	sudo pacman -S --noconfirm --needed "${PREP_PKGS[@]}" 
	PDONE
else
	install_chaotic
	PGREEN chaotic-aur is installed successfully
	PYELL updating repos
	sudo pacman -Syy
	PYELL Installing preparatory packages and paru ..
	sudo pacman -S --noconfirm --needed "${PREP_PKGS[@]}" 
	PDONE
fi

