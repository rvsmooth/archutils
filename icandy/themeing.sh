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
PKGS=(
	"font-manager"
	"nwg-look"
	"papirus-icon-theme"
	"ttf-jetbrains-mono-nerd"
	"ttf-roboto"
	"ttf-ubuntu-font-family"
)

ASSETS=("fonts" "themes" "icons")
URLS=(
	"https://github.com/rvsmooth/Wallpapers/releases/download/1/fonts-ebook.zip"
	"https://github.com/rvsmooth/Wallpapers/releases/download/1/themes.zip"
	"https://github.com/rvsmooth/Wallpapers/releases/download/1/icons.zip"
)

PYELL Installing themeing packages and utils
$SPS "${PKGS[@]}"

## get assets
mkdir -p "$FONTS_CLONE_DIR" "$ICONS_CLONE_DIR" "$THEMES_CLONE_DIR" "$FONTS_DIR" "$ICONS_DIR" "$THEMES_DIR" "$WALLS_DIR"

if [[ -f "$HOME/.themes/.installed" ]]; then
	echo "Themes and icons already installed"
else
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
fi

PYELL Setting up gtk theme, cursor theme and font...
mkdir "$GTK3_DIR"
cp "$SCRIPT_DIR"/../assets/settings.ini "$GTK3_DIR"/settings.ini

PYELL setting up wallpapers
git clone https://github.com/rvsmooth/wallpapers "$WALLS_DIR"
PDONE

if command -v pacman &> /dev/null
then
	PYELL I really really love candy, do you not?
	PYELL "Distro is Arch..."
	sudo sed -i '/\[options\]/a ILoveCandy' /etc/pacman.conf
else
	echo
fi

PDONE

