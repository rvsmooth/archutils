#!/usr/bin/env bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

source "$SCRIPT_DIR"/../icandy/colors.sh

## packages
PKGS_COMMON=(
  "grim"
  "qt5-wayland"
  "qt6-wayland"
  "slurp"
  "waybar"
  "wl-clipboard"
  "wlsunset"
  "xdg-desktop-portal"
  "xdg-desktop-portal-gtk"
  "xorg-xwayland"
)

PKGS_QTILE=(
  "feh"
  "flameshot"
  "picom"
  "python-dbus-next"
  "python-iwlib"
  "python-psutil"
  "qtile"
  "redshift"
  "xclip"
)

PKGS_SWAY=(
  "autotiling"
  "sway"
  "swaybg"
  "swaylock"
  "swayidle"
  "xdg-desktop-portal-wlr"
)

PKGS_HYPR=(
  "gegl"
  "hyprcursor"
  "hypridle"
  "hyprland"
  "hyprlock"
  "hyprpaper"
  "hyprutils"
  "libdrm"
  "libpng"
  "libxkbcommon"
  "libxml2"
  "llvm"
  "mtdev"
  "pixman"
)

PKGS_STAGED=()

if [[ "$QTILE" == 1 ]]; then
  PYELL Installing QTile and its dependencies...
  $SPS "${PKGS_QTILE[@]}"
  PDONE
else
  echo
fi

if [[ "$HYPR" == 1 ]]; then
  PYELL Installing Hyprland and its dependencies....
  PKGS_STAGED+=("${PKGS_COMMON[@]}" "${PKGS_HYPR[@]}")
  $SPS "${PKGS_STAGED[@]}"
  PDONE
else
  echo
fi

if [[ "$SWAY" == 1 ]]; then
  PYELL Installing Sway and its dependencies....
  PKGS_STAGED+=("${PKGS_COMMON[@]}" "${PKGS_SWAY[@]}")
  $SPS "${PKGS_STAGED[@]}"
  PDONE
else
  echo
fi
