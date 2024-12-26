#!/usr/bin/env bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
GTK3_DIR="${HOME}/.config/gtk-3.0"
FONTS_CLONE_DIR="/tmp/fonts"
THEMES_CLONE_DIR="/tmp/themes"
ICONS_CLONE_DIR="/tmp/icons"
THEMES_DIR="${HOME}/.themes"
ICONS_DIR="${HOME}/.icons"
FONTS_DIR="${HOME}/.fonts"
WALLS_DIR="${HOME}/Pictures/wallpapers"

source "$SCRIPT_DIR"/../icandy/colors.sh

PMAG Installing themeing packages and utils
$SPS nwg-look ttf-jetbrains-mono-nerd ttf-ubuntu-font-family font-manager papirus-icon-theme ttf-roboto wget \
  curl unzip zip 

## get assets
mkdir -p "$FONTS_CLONE_DIR" "$ICONS_CLONE_DIR" "$THEMES_CLONE_DIR" "$FONTS_DIR" "$ICONS_DIR" "$THEMES_DIR" "$WALLS_DIR"

ASSETS=("fonts" "themes" "icons")
URLS=(
    "https://github.com/rvsmooth/Wallpapers/releases/download/1/fonts-ebook.zip"
    "https://github.com/rvsmooth/Wallpapers/releases/download/1/themes.zip"
    "https://github.com/rvsmooth/Wallpapers/releases/download/1/icons.zip"
)

for i in "${!ASSETS[@]}"; do
    ASSET=${ASSETS[$i]}
    URL=${URLS[$i]}
    CLONE_DIR="/tmp/${ASSET}"  
    DIR="${HOME}/.${ASSET}"
    
    PYELL "Downloading $ASSET..."
    wget -qO "$CLONE_DIR"/"$ASSET".zip "$URL"
    PDONE
    PYELL "Setting up $ASSET..."
    unzip -qo "$CLONE_DIR"/"$ASSET".zip -d "$CLONE_DIR"
    PDONE
    rm -f "$CLONE_DIR"/*.zip
    cp -rf "$CLONE_DIR"/* "$DIR"
    echo 
done

PBLUE Setting up gtk theme, cursor theme and font...
mkdir "$GTK3_DIR"
cp "$SCRIPT_DIR"/../assets/settings.ini "$GTK3_DIR"/settings.ini

PBLUE setting up wallpapers
git clone https://github.com/rvsmooth/wallpapers "$WALLS_DIR"
PDONE

if command -v pacman &> /dev/null
then
	PBLUE I really really love candy, do you not?
	PYELL "Distro is Arch..."
	sudo sed -i '/\[options\]/a ILoveCandy' /etc/pacman.conf
else
	echo
fi

PDONE

