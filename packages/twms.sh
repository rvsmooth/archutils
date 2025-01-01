#!/usr/bin/env bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

source "$SCRIPT_DIR"/../icandy/colors.sh

if [[ "$QTILE" == 1 ]]; then
PYELL Installing QTile and its dependencies...
$SPS qtile qtile-extras python-psutil python-dbus-next python-iwlib
PDONE
else 
	echo
fi

if [[ "$HYPR" == 1 ]]; then
PYELL Installing Hyprland and its dependencies....
$SPS hyprland waybar hyprcursors hyprutils hyprland-scanner hypridle hyprpaper hyprlock xdg-desktop-portal-hyprland xdg-desktop-portal-wlr \
	xdg-desktop-portal-gtk grim slurp hyprpicker hyprpaper wl-clipboard qt5-wayland qt6-wayland libdrm pixman libxkbcommon libxml2 llvm \
	libpng gegl mtdev xorg-xwayland 
PDONE
else 
	echo
fi

if [[ "$SWAY" == 1 ]]; then
PYELL Installing Sway and its dependencies....
$SPS sway wayland xdg-desktop-portal-gtk xdg-desktop-portal-wlr grim slurp wl-clipboard qt5-wayland qt6-wayland xorg-xwayland swaybg swaylock autotiling
PDONE
else 
	echo
fi
