#!/usr/bin/env bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

source $SCRIPT_DIR/colors.sh

emagenta Installing QTile and its dependencies...
$SPS qtile qtile-extras python-psutil python-dbus-next
donemsg

emagenta Installing Hyprland and its dependencies....
$SPS hyprland waybar hyprcursors hyprutils hyprland-scanner xdg-desktop-portal-hyprland xdg-desktop-portal-wlr \
	grim slurp hyprpicker hyprpaper wl-clipboard qt5-wayland qt6-wayland libdrm pixman libxkbcommon libxml2 llvm \
	libpng gegl mtdev xorg-xwayland 
donemsg
