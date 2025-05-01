#!/usr/bin/env bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

source "$SCRIPT_DIR"/../icandy/colors.sh

NATIVE_PKGS=(
  "btop"
  "brave-bin"
  "calibre"
  "flatpak"
  "gimp"
  "kiwix-desktop"
  "libreoffice-fresh"
  "mpv"
  "musikcube"
  "neovim"
  "obs-studio"
  "qbittorrent"
  "thunderbird"
)

PYELL Installing User Applications......
$SPS "${NATIVE_PKGS[@]}"
PDONE
