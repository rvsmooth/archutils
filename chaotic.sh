#!/usr/bin/env bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SPAKU='sudo pacman -U --noconfirm'
SPAKK='sudo pacman-key'

source $SCRIPT_DIR/colors.sh


function install_chaotic(){

  $SPAKK --recv-key 3056513887B78AEB --keyserver keyserver.ubuntu.com
  $SPAKK --lsign-key 3056513887B78AEB
  $SPAKU 'https://cdn-mirror.chaotic.cx/chaotic-aur/chaotic-keyring.pkg.tar.zst'
  $SPAKU 'https://cdn-mirror.chaotic.cx/chaotic-aur/chaotic-mirrorlist.pkg.tar.zst'
  
  echo '[chaotic-aur]
Include = /etc/pacman.d/chaotic-mirrorlist' | sudo tee -a /etc/pacman.conf

}

if [[ -f /etc/pacman.d/chaotic-mirrorlist ]]; then
  eyellow Chaotic-aur is already installed.
else
  install_chaotic
  egreen chaotic-aur is installed successfully
  eblue updating repos
  sudo pacman -Syy
  donemsg
fi


