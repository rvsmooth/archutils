#!/usr/bin/env bash

FLAMESHOT_DIR="${HOME}/.config/flameshot"
FLAMESHOT_INI_DIR="${FLAMESHOT_DIR}/flameshot.ini"
GTK3_DIR="${HOME}/.config/gtk-3.0"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

source $SCRIPT_DIR/colors.sh

PMAG Installing Utilities......
$SPS flameshot rofi pcmanfm-gtk3 engrampa gvfs gvfs-mtp mtpfs \
  bluez bluez-libs bluez-utils alsa-utils wireplumber imagemagick wget lxsession feh expac \
  reflector plocate redshift flatpak ddcutil starship fish zsh zip unzip usbutils android-tools \
  xclip kitty dunst picom rsync aria2 less qemu-full fastfetch
PDONE

sleep 2

# setup flameshot
PBLUE Setting Up Flameshot......
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

sleep 2

# setup bluetooth
PBLUE Setting Up Bluetooth......
sudo systemctl enable bluetooth --now
PDONE

sleep 2

# Create bookmarks
PBLUE Setting Up Bookmarks of Filemanager
mkdir -p ~/Library ~/Downloads ~/Media ~/Music ~/Pictures/wallpapers ~/Work ~/Projects
touch "$GTK3_DIR"/bookmarks
echo "
file:///home/$(whoami)/Library
file:///home/$(whoami)/Downloads
file:///home/$(whoami)/Media
file:///home/$(whoami)/Music
file:///home/$(whoami)/Pictures
file:///home/$(whoami)/Projects
file:///home/$(whoami)/Work" | tee "$GTK3_DIR/bookmarks"
PDONE

# change user shell
PBLUE Changing User shell to fish......
sudo chsh $USER -s /usr/bin/fish
PDONE
