#!/usr/bin/env bash

FISH_CONFIG_DIR="${HOME}/.config/fish"
SCRIPTS_COMMON_DIR="${HOME}/.config/scripts-common"
FONTS_CLONE_DIR="/tmp/fonts"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR"/../icandy/colors.sh

REMOVE_LIST="
io.podman_desktop.PodmanDesktop
org.fedoraproject.MediaWriter
org.gnome.Connections
org.gnome.Contacts
org.gnome.DejaDup
org.gnome.Logs
org.gnome.Papers
org.gnome.World.PikaBackup
org.mozilla.Thunderbird
org.mozilla.firefox
org.gnome.Maps
"
INSTALL_LIST="
com.brave.Browser
com.calibre_ebook.calibre 
org.localsend.localsend_app
com.notesnook.Notesnook
eu.betterbird.Betterbird
one.ablaze.floorp
org.onlyoffice.desktopeditors
com.github.neithern.g4music
org.qbittorrent.qBittorrent
"

# shells
PYELL Setting up bash and fish shell...
mkdir -p "$SCRIPTS_COMMON_DIR"
curl https://gitlab.com/RVSmooth/dotfiles/-/raw/main/.config/scripts-common/aliases.sh?ref_type=heads > "$SCRIPTS_COMMON_DIR"/aliases.sh 
# bash
curl https://gitlab.com/RVSmooth/dotfiles/-/raw/main/.bashrc?ref_type=heads > "$HOME"/.bashrc 
# fish
mkdir -p "$FISH_CONFIG_DIR"
curl https://gitlab.com/RVSmooth/dotfiles/-/raw/main/.config/fish/config.fish?ref_type=heads > "$FISH_CONFIG_DIR"/config.fish  
PYELL Setting up fish as the default shell
sudo usermod --shell /usr/bin/fish $(whoami)
PDONE

# fonts
PYELL Setting up fonts...
mkdir -p "$FONTS_CLONE_DIR"
wget -qO "$FONTS_CLONE_DIR"/fonts.zip https://github.com/rvsmooth/Wallpapers/releases/download/1/fonts-ebook.zip 
wget -qO "$FONTS_CLONE_DIR"/jetbrains.zip https://github.com/ryanoasis/nerd-fonts/releases/download/v3.3.0/JetBrainsMono.zip 
unzip -qo "$FONTS_CLONE_DIR"/fonts.zip -d "$FONTS_CLONE_DIR" 
unzip -qo "$FONTS_CLONE_DIR"/jetbrains.zip -d "$FONTS_CLONE_DIR" 
# make fonts dir
mkdir -p "$HOME"/.local/share/fonts 
cp -rf "$FONTS_CLONE_DIR"/*.ttf "$HOME"/.local/share/fonts 
PDONE

# ADB
PYELL Setting up platform-tools....
if command -v adb &> /dev/null; then
	PYELL platform-tools are installed already...
else
	PYELL platform-tools are not installed...
	PYELL Beginning installation
	mkdir -p "$HOME"/.local/bin
	mkdir -p /tmp/adb
	wget -qO /tmp/adb.zip https://dl.google.com/android/repository/platform-tools-latest-linux.zip
	unzip -qo /tmp/adb.zip -d /tmp/adb
	cp -rf /tmp/adb/platform-tools/* "$HOME"/.local/bin
fi
PDONE

# Flatpaks
PYELL Setting up flatpaks...
for flat in $INSTALL_LIST; do
	FLTR=$(echo $flat | awk -F ' ' '{print $NF}')
	echo "Installing  $FLTR"
	flatpak -y --system install $flat
done

for flatr in $REMOVE_LIST; do
	FLTR=$(echo $flat | awk -F ' ' '{print $NF}')
	echo "Removing  $FLTR"
	flatpak -y --system remove $flatr
done
PYELL Installing GIMP RC 3.0
flatpak install -y --user https://flathub.org/beta-repo/appstream/org.gimp.GIMP.flatpakref
PDONE
