#!/usr/bin/env bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
GTK3_DIR="${HOME}/.config/gtk-3.0"
source $SCRIPT_DIR/colors.sh

emagenta Installing themeing packages and utils
$SPS nwg-look bibata-cursor-theme-bin gruvbox-material-gtk-theme-git gruvbox-material-icon-theme-git \
  ttf-jetbrains-mono-nerd ttf-ubuntu-font-family font-manager papirus-icon-theme ttf-roboto

wget -O /tmp/Dracula.tar.xz https://github.com/dracula/gtk/releases/latest/download/Dracula.tar.xz &&
	mkdir /tmp/Dracula &&
	tar -xf /tmp/Dracula.tar.xz -C /tmp/Dracula &&
	sudo cp -r /tmp/Dracula/* /usr/share/themes 

donemsg

eblue Setting up gtk theme, cursor theme and font...
mkdir "$GTK3_DIR"
cp "$SCRIPT_DIR"/assets/settings.ini "$GTK3_DIR"/settings.ini
sudo sed -i 's/IconTheme=Adwaita/IconTheme=Gruvbox-Material-Dark/g' /usr/share/themes/Gruvbox-Material-Dark/index.theme
sudo sed -i 's/CursorTheme=Adwaita/CursorTheme=Bibata-Modern-Classic/g' /usr/share/themes/Gruvbox-Material-Dark/index.theme
sudo sed -i 's/Adwaita/Bibata-Modern-Classic/g' /usr/share/icons/default/index.theme
donemsg

eblue setting up wallpapers
mkdir -p ~/Pictures/wallpapers
git clone https://github.com/rvsmooth/wallpapers ~/Pictures/wallpapers
donemsg
