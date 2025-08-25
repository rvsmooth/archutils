#!/usr/bin/env bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SPAKU='sudo pacman -U --noconfirm'
SPAKK='sudo pacman-key'
setup_chaotic="1"

source "$SCRIPT_DIR"/../icandy/colors.sh

PREP_PKGS=(
  "curl"
  "fakeroot"
  "git"
  "paru"
  "wget"
  "unzip"
  "yay"
  "zip"
)

chaotic_cleanup() {
  match_first="chaotic-aur"
  match_second="chaotic-mirrorlist"

  if [[ -n $(grep chaotic /etc/pacman.conf) ]]; then
    set -x
    target="/etc/pacman.conf"

    lines=()

    for line in $(grep -n "$match_second" $target | awk -F ':' '{print $1}'); do
      lines+=("$line")
    done

    for line in $(grep -n "$match_first" $target | awk -F ':' '{print $1}'); do
      lines+=("$line")
    done

    delete_cmd=$(printf "%sd;" "${lines[@]}")
    delete_cmd=${delete_cmd%?}

    sudo sed -i "${delete_cmd}" $target
  fi
}

install_chaotic() {

  $SPAKK --recv-key 3056513887B78AEB --keyserver keyserver.ubuntu.com
  $SPAKK --lsign-key 3056513887B78AEB
  $SPAKU 'https://cdn-mirror.chaotic.cx/chaotic-aur/chaotic-keyring.pkg.tar.zst'
  $SPAKU 'https://cdn-mirror.chaotic.cx/chaotic-aur/chaotic-mirrorlist.pkg.tar.zst'

  is_chaotic_installed=$(awk '/chaotic-aur/ {print $1}' /etc/pacman.conf)

  if [[ ! -n "$is_chaotic_installed" ]]; then
    echo '[chaotic-aur]
Include = /etc/pacman.d/chaotic-mirrorlist' | sudo tee -a /etc/pacman.conf
  fi

}

check_chaotic() {
  if pacman -Sl chaotic-aur &>/dev/null; then
    echo "Chaotic AUR is installed and working."
    setup_chaotic="1"

  else
    echo "Chaotic AUR is missing or broken."
    setup_chaotic="0"
  fi
}

check_chaotic

if [[ "$setup_chaotic" == "0" ]]; then
  chaotic_cleanup
  install_chaotic
fi

sudo pacman -Syy
PYELL Installing preparatory packages and paru ..
sudo pacman -S --noconfirm --needed "${PREP_PKGS[@]}"
PDONE
