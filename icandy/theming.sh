#!/usr/bin/env bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
WORK_DIR="/tmp/work"
SRC_URL="https://github.com/rvsmooth/wallpapers/releases/latest/download"
ICONS_DIR="$HOME/.icons"
THEMES_DIR="$HOME/.themes"
WALLS_REPO="https://github.com/rvsmooth/wallpapers"
WALL_DIR="$HOME/Pictures/wallpapers"

source "$SCRIPT_DIR"/../icandy/colors.sh
PKGS=(
  "font-manager"
  "nwg-look"
)

DIRS=(
  "/usr/share/themes"
  "$HOME/.local/share/themes"
  "$HOME/.themes"
  "/usr/share/icons"
  "$HOME/.local/share/icons"
  "$HOME/.icons"
)

PYELL Installing themeing packages and utils
$SPS "${PKGS[@]}"

# declare dictionaries
declare -A cursors
declare -A icons
declare -A themes

# cursors
cursors["Bibata-Modern-Ice.tar.xz"]="Bibata-Modern-Ice"
cursors["Bibata-Modern-Classic.tar.xz"]="Bibata-Modern-Classic"

# icons
icons["kora-1-7-1.tar.xz"]="kora kora-light kora-light-panel"
icons["papirus-icon-theme-20250201.tar.gz"]="Papirus Papirus-Dark Papirus-Light ePapirus ePapirus-Dark"

# themes
themes["Gruvbox-Dark-BL-MB.zip"]="Gruvbox-Dark  Gruvbox-Dark-hdpi  Gruvbox-Dark-xhdpi"
themes["Tokyonight-Dark-BL-MB.zip"]="Tokyonight-Dark Tokyonight-Dark-hdpi Tokyonight-Dark-xhdpi"
themes["Catppuccin-Dark-BL-LB.zip"]="Catppuccin-Dark Catppuccin-Dark-hdpi Catppuccin-Dark-xhdpi"
themes["Dracula.tar.xz"]="Dracula"
themes["Dracula-pink-accent.tar.xz"]="Dracula-pink-accent"
themes["Dracula-slim.tar.xz"]="Dracula-slim Dracula-slim-standard-buttons"
themes["Nordic.tar.xz"]="Nordic Nordic-v40"
themes["Nordic-darker.tar.xz"]="Nordic-darker Nordic-darker-v40"
themes["Everforest-Dark-BL-MB.zip"]="Everforest-Dark Everforest-Dark-xhdpi Everforest-Dark-hdpi"
themes["Everforest-Dark-Soft-BL-MB.zip"]="Everforest-Dark-Soft Everforest-Dark-Soft-xhdpi Everforest-Dark-Soft-hdpi"

function download_asset() {
  if [ -e $WORK_DIR/$package ]; then
    PYELL $package is already downloaded
  else
    __gh_download rvsmooth wallpapers "$package"
    if [ $? -ne 0 ]; then
      echo "$SRC_URL/$package"
      echo "Failed to download $package"
      continue
    fi

  fi

}

function setup_asset() {
  array="$1"
  declare -n array_final="$array"
  for package in ${!array_final[@]}; do
    if [[ "$array" = "cursors" || "$array" == "icons" ]]; then
      for value in ${array_final[$package]}; do
        if [[ -d "${DIRS[3]}/$value" || -d "${DIRS[4]}/$value" || -d "${DIRS[5]}/$value" ]]; then
          echo "$value exists"
        else
          echo "$value does not exist"
          download_asset
          export MOVE_ICONS=1

        fi
      done
      __ex $package
      if [[ "$MOVE_ICONS" == "1" ]]; then
        mv */ $ICONS_DIR
      else
        echo
      fi
    elif
      [[ "$array" == "themes" ]]
    then
      for value in ${array_final[$package]}; do
        if [[ -d "${DIRS[0]}/$value" || -d "${DIRS[1]}/$value" || -d "${DIRS[2]}/$value" ]]; then
          echo "$value exists"
        else
          echo "$value does not exist"
          download_asset
          export MOVE_THEMES=1

        fi
      done
      __ex $package
      if [[ "$MOVE_THEMES" == "1" ]]; then
        mv */ $THEMES_DIR
      else
        echo
      fi
    else
      echo "Undefined"
    fi

  done
}

# create directories if they do not exist

[[ ! -d "$THEMES_DIR" || ! -d "$ICONS_DIR" ]] && mkdir -p $THEMES_DIR $ICONS_DIR

[ ! -d "$WORK_DIR" ] && mkdir -p "$WORK_DIR"

# switch to work dir
cd "$WORK_DIR"
setup_asset cursors
setup_asset icons
setup_asset themes
cd -

# clone wallpapers
[ ! -d "$WALL_DIR" ] && git clone "$WALLS_REPO" "$WALL_DIR"
