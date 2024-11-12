#!/usr/bin/env bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SDDM_CLONE_DIR='/tmp/simplicity'
SDDM_THEME_DIR='/usr/share/sddm/themes/simplicity/'

source $SCRIPT_DIR/colors.sh

if [[ -d "$SDDM_THEME_DIR" ]]; then

  eyellow sddm-astronaut-theme is already installed

else

  emagenta Installing SDDM...
  $SPS sddm qt5-quickcontrols2
  donemsg
  sleep 1
  eblue Configuring SDDM...
  sudo git clone https://gitlab.com/dotsmooth/sddm-simplicity-theme "$SDDM_CLONE_DIR"
  sudo mv "$SDDM_CLONE_DIR"/simplicity "$SDDM_THEME_DIR"

  echo "[Theme]
Current=simplicity" | sudo tee /etc/sddm.conf

  donemsg
fi

emagenta Enabling SDDM
sudo systemctl enable sddm
donemsg

