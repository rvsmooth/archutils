#!/bin/bash
ICONS_DIR="$HOME/.icons"
THEMES_DIR="$HOME/.themes"
WORK_DIR="/tmp/work"
WEB="https://api.github.com/repos/rvsmooth/wallpapers/releases/tags/Continuous"
theme_url=$(curl -s $WEB | jq -r '.assets[] | .browser_download_url' | awk -F '/' '{print $NF}' | grep -Eiv 'papirus|bibata|kora')
icons_url=$(curl -s $WEB | jq -r '.assets[] | .browser_download_url' | awk -F '/' '{print $NF}' | grep -Ei 'papirus|bibata|kora')
theme=($theme_url)
icon=($icons_url)

__extract() {
  if [ -f $1 ]; then
    case $1 in
    *.tar.gz) tar xzf "$1" --overwrite ;;
    *.tar.xz) tar xf "$1" --overwrite ;;
    *.zip) unzip -o "$1" ;;
    *) echo "'$1' cannot be extracted via ex()" ;;
    esac
  else
    echo "'$1' is not a valid file"
  fi
}

__download_assets() {
  DL_URL="https://github.com/rvsmooth/wallpapers/releases/download/Continuous"
  URL="${DL_URL}/$1"
  wget -q --show-progress -nc --wait=2 --random-wait $URL
}

array_load() {
  OPTIONS=()
  local -n arr1=$1

  for i in "${arr1[@]}"; do
    OPTIONS+=("$i" "$i" OFF)
  done

  CHOICES=$(whiptail --separate-output --checklist "Select $1 to download:" 20 120 10 \
    "${OPTIONS[@]}" 3>&1 1>&2 2>&3)

  STATUS=$?

  if [[ $STATUS == "0" ]]; then
    if [ -z "$CHOICES" ]; then
      echo "No assets selected."
    else
      echo "Downloading"
      for asset in $CHOICES; do
        echo "Downloading $asset"
        __download_assets $asset
      done
    fi
  fi

}

[[ ! -d "$THEMES_DIR" || ! -d "$ICONS_DIR" ]] && mkdir -p $THEMES_DIR $ICONS_DIR

[ ! -d "$WORK_DIR" ] && mkdir -p "$WORK_DIR"

cd $WORK_DIR

# themes
mkdir themes
cd themes
array_load theme
if [[ "$STATUS" == "0" ]]; then
  for item in $(find /tmp/work/themes); do
    __extract $item
  done
  mv -f */ $THEMES_DIR
fi

mkdir /tmp/work/icons
cd /tmp/work/icons
array_load icon
if [[ $STATUS == "0" ]]; then
  for item in $(find /tmp/work/icons); do
    __extract $item
  done
  mv -f /tmp/work/icons/*/ $ICONS_DIR
fi
