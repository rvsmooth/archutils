#!/usr/bin/env bash

FLAMESHOT_DIR="${HOME}/.config/flameshot"
FLAMESHOT_INI_DIR="${FLAMESHOT_DIR}/flameshot.ini"
GTK3_DIR="${HOME}/.config/gtk-3.0"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

source "$SCRIPT_DIR"/../icandy/colors.sh

DIRS=(
  "Android"
  "Documents"
  "Downloads"
  "Media"
  "Music"
  "Pictures"
  "Projects"
)

PKGS=(
  "alsa-utils"
  "android-tools"
  "aria2"
  "bluez"
  "bluez-libs"
  "bluez-utils"
  "cliphist"
  "ddcutil"
  "dunst"
  "engrampa"
  "expac"
  "fastfetch"
  "fd"
  "ffmpegthumbnailer"
  "fish"
  "gcc"
  "gst-plugins-bad"
  "gst-plugins-base"
  "gst-plugins-good"
  "gvfs"
  "gvfs-mtp"
  "imagemagick"
  "kitty"
  "less"
  "libappindicator-gtk3"
  "libnotify"
  "mtpfs"
  "nwg-look"
  "pavucontrol"
  "plocate"
  "polkit-gnome"
  "reflector"
  "rofi"
  "rsync"
  "starship"
  "swww"
  "thunar"
  "thunar-archive-plugin"
  "thunar-volman"
  "timeshift"
  "tumbler"
  "unzip"
  "usbutils"
  "viewnior"
  "wireplumber"
  "yt-dlp"
  "zsh"
)

PYELL Installing Utilities......
$SPS "${PKGS[@]}"
PDONE

# setup flameshot
if [[ "$QTILE" == 1 ]]; then
  PYELL Setting Up Flameshot......
  mkdir "$FLAMESHOT_DIR"
  mkdir -p ~/Pictures/screenshots
  touch "$FLAMESHOT_INI_DIR"

  echo "[General]
  contrastOpacity=188
  savePath=/home/$(whoami)/Pictures/screenshots
  savePathFixed=true

  [Shortcuts]
  TYPE_SAVE=Return" | tee "$FLAMESHOT_INI_DIR"
  PDONE
else
  echo
fi

# setup bluetooth
PYELL Setting Up Bluetooth......
sudo systemctl enable bluetooth --now
PDONE

# Create bookmarks
PYELL Setting Up Bookmarks of Filemanager
for dir in ${DIRS[@]}; do
  mkdir "$HOME"/"$dir"
  echo "file:///home/$(whoami)/$dir" | tee -a "$GTK3_DIR"/bookmarks
done
PDONE

# change user shell
PYELL Changing User shell to fish......
sudo chsh "$USER" -s /usr/bin/fish
PDONE

PYELL Create wallpaper directory
mkdir -p ~/.cache/wallpaper
PDONE
