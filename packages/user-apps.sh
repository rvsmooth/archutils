#!/usr/bin/env bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

source "$SCRIPT_DIR"/../icandy/colors.sh

PMAG Installing User Applications......
$SPS neovim npm gimp obs-studio \
  mpv qbittorrent btop calibre \
  kiwix-desktop musikcube newsboat \
  flatpak
PDONE


PMAG Installing Flatpaks
flatpak install -y com.notesnook.Notesnook org.localsend.localsend_app \
	eu.betterbird.Betterbird one.ablaze.floorp com.brave.Browser \
	org.onlyoffice.desktopeditors
PDONE
sleep 2

PYELL Setting floorp as default Browser
xdg-settings set default-web-browser one.ablaze.floorp.desktop 
PDONE
