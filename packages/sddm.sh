#!/usr/bin/env bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SDDM_CLONE_DIR='/tmp/simplicity'
SDDM_THEME_DIR='/usr/share/sddm/themes/simplicity/'

source "$SCRIPT_DIR"/../icandy/colors.sh

if [[ -d "$SDDM_THEME_DIR" ]]; then

  PYELL sddm-astronaut-theme is already installed

else

  PMAG Installing SDDM...
  $SPS sddm qt5-quickcontrols2
  PDONE
  sleep 1
  PBLUE Configuring SDDM...
  sudo git clone https://gitlab.com/dotsmooth/sddm-simplicity-theme "$SDDM_CLONE_DIR"
  sudo mv "$SDDM_CLONE_DIR"/simplicity "$SDDM_THEME_DIR"

  echo "[Theme]
Current=simplicity" | sudo tee /etc/sddm.conf

  PDONE
fi

PMAG Enabling SDDM
sudo systemctl enable sddm
PDONE

