#!/usr/bin/env bash

FLAMESHOT_DIR="${HOME}/.config/flameshot"
FLAMESHOT_INI_DIR="${FLAMESHOT_DIR}/flameshot.ini"
GTK3_DIR="${HOME}/.config/gtk-3.0"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

source $SCRIPT_DIR/colors.sh

emagenta Installing Utilities......
$SPS flameshot rofi pcmanfm-gtk3 engrampa gvfs gvfs-mtp mtpfs \
  bluez bluez-libs bluez-utils alsa-utils wireplumber imagemagick wget lxsession feh expac \
  reflector plocate redshift flatpak ddcutil starship fish zsh zip unzip usbutils android-tools \
  xclip kitty dunst picom rsync
donemsg

sleep 2

# setup flameshot
eblue Setting Up Flameshot......
mkdir "$FLAMESHOT_DIR"
mkdir -p ~/Pictures/screenshots
touch "$FLAMESHOT_INI_DIR"

echo "[General]
  contrastOpacity=188
  savePath=/home/$(whoami)/Pictures/screenshots
  savePathFixed=true

  [Shortcuts]
  TYPE_SAVE=Return" | tee "$FLAMESHOT_INI_DIR"
donemsg

sleep 2

# setup bluetooth
eblue Setting Up Bluetooth......
sudo systemctl enable bluetooth --now
donemsg

sleep 2

# Create bookmarks
eblue Setting Up Bookmarks of Filemanager
mkdir ~/Library ~/Downloads ~/Media ~/Music ~/Pictures ~/Work
touch "$GTK3_DIR"/bookmarks
echo "
file:///home/$(whoami)/Library
file:///home/$(whoami)/Downloads
file:///home/$(whoami)/Media
file:///home/$(whoami)/Music
file:///home/$(whoami)/Pictures
file:///home/$(whoami)/Work" | tee "$GTK3_DIR/bookmarks"
donemsg

# change user shell
eblue Changing User shell to fish......
sudo chsh $USER -s /usr/bin/fish
donemsg
