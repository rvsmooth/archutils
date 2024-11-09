#!/usr/bin/env bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SDDM_CLONE_DIR='/tmp/sddm-astronaut-theme'
SDDM_THEME_DIR='/usr/share/sddm/themes/sddm-astronaut-theme/'
FONT_DIR='/usr/share/fonts'

source $SCRIPT_DIR/colors.sh

if [[ -d "$SDDM_THEME_DIR" ]]; then

  eyellow sddm-astronaut-theme is already installed

else

  emagenta Installing SDDM...
  $SPS sddm qt5-graphicaleffects qt6-5compat qt6-shadertools qt6-declarative qt6-svg
  donemsg
  sleep 1
  eblue Configuring SDDM...
  sudo git clone https://github.com/keyitdev/sddm-astronaut-theme.git "$SDDM_CLONE_DIR"
  sudo cp "$SDDM_CLONE_DIR"/Fonts/* "$FONT_DIR"
  sudo rm -f "$SDDM_CLONE_DIR"/background.png
  sudo cp "$SCRIPT_DIR"/assets/gruvbox_background.png "$SDDM_CLONE_DIR"/background.png
  sudo mv "$SDDM_CLONE_DIR" "$SDDM_THEME_DIR"

  echo "[Theme]
Current=sddm-astronaut-theme" | sudo tee /etc/sddm.conf

  donemsg
fi

emagenta Enabling SDDM
sudo systemctl enable sddm
donemsg

