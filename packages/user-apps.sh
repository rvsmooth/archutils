#!/usr/bin/env bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

source "$SCRIPT_DIR"/../icandy/colors.sh

PMAG Installing User Applications......
$SPS brave-bin floorp-bin neovim npm gimp thunderbird obs-studio \
  mpv onlyoffice-bin localsend-bin qbittorrent btop calibre \
  kiwix-desktop musikcube newsboat 

PDONE

sleep 2

