#!/usr/bin/env bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
BARE_REPO_DIR="$HOME/.dotfiles"
source "$SCRIPT_DIR"/../icandy/colors.sh

PGREEN Installing personal packages
$SPS libva libva-intel-driver libva-utils emacs cmake
PDONE

PMAG Installing Flatpaks
flatpak install -y com.notesnook.Notesnook org.localsend.localsend_app
PDONE
