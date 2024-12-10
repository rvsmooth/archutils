#!/usr/bin/env bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
THEME_LIST=$(sudo find /usr/share/themes -type f -name "index.theme")
GTK3_DIR="${HOME}/.config/gtk-3.0"
source "$SCRIPT_DIR"/../icandy/colors.sh

PMAG Installing themeing packages and utils
$SPS nwg-look bibata-cursor-theme-bin gruvbox-material-gtk-theme-git gruvbox-material-icon-theme-git \
  ttf-jetbrains-mono-nerd ttf-ubuntu-font-family font-manager papirus-icon-theme ttf-roboto wget \
  curl unzip zip 

## get themes
wget -O /tmp/Dracula.tar.xz https://github.com/dracula/gtk/releases/latest/download/Dracula.tar.xz &&
	mkdir /tmp/Dracula &&
	tar -xf /tmp/Dracula.tar.xz -C /tmp/Dracula &&
	sudo cp -r /tmp/Dracula/* /usr/share/themes 
wget -O /tmp/Catppuccin.zip https://github.com/catppuccin/gtk/releases/download/v1.0.3/catppuccin-mocha-pink-standard+default.zip &&
	mkdir /tmp/Catppuccin &&
	unzip /tmp/Catppuccin.zip -d /tmp/Catppuccin &&
	sudo cp -r /tmp/Catppuccin/* /usr/share/themes
PDONE

PBLUE Setting up gtk theme, cursor theme and font...
mkdir "$GTK3_DIR"
cp "$SCRIPT_DIR"/../assets/settings.ini "$GTK3_DIR"/settings.ini

### A loop to change cursor theme in all existing themes
for THEMES in $THEME_LIST; do
	echo "$THEMES"
sudo sed -i -e '/^CursorTheme=/d' \
           -e '/^\[X-GNOME-Metatheme\]/a CursorTheme=Bibata-Modern-Ice' \
	   "$THEMES"
cat "$THEMES"
echo
done

#change def cursor theme in root
sudo sed -i 's/Adwaita/Bibata-Modern-Ice/g' /usr/share/icons/default/index.theme
PDONE

PBLUE setting up wallpapers
mkdir -p ~/Pictures/wallpapers
git clone https://github.com/rvsmooth/wallpapers ~/Pictures/wallpapers
PDONE

PBLUE I really really love candy, do you not?
sudo sed -i '/\[options\]/a ILoveCandy' /etc/pacman.conf
PDONE
