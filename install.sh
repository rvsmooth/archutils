#!/usr/bin/env bash
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

source $SCRIPT_DIR/colors.sh

echo -e "${RED}"
cat <<"EOF"
     _       _   ____                        _   _     
  __| | ___ | |_/ ___| _ __ ___   ___   ___ | |_| |__  
 / _` |/ _ \| __\___ \| '_ ` _ \ / _ \ / _ \| __| '_ \ 
| (_| | (_) | |_ ___) | | | | | | (_) | (_) | |_| | | |
 \__,_|\___/ \__|____/|_| |_| |_|\___/ \___/ \__|_| |_|

EOF
echo -e "${RESET}"

 if pacman -Qi paru &> /dev/null; then
  eyellow paru is installed
else
   ered paru is not installed
   sleep 1
   emagenta beginning installation of paru...
   bash $SCRIPT_DIR/chaotic.sh
   sudo pacman -S --noconfirm --needed paru yay wget aria2
   donemsg
fi

source $SCRIPT_DIR/chaotic.sh
source $SCRIPT_DIR/qtile.sh
source $SCRIPT_DIR/sddm.sh
source $SCRIPT_DIR/themeing.sh
source $SCRIPT_DIR/user-apps.sh
source $SCRIPT_DIR/utilities.sh
source $SCRIPT_DIR/dots.sh

