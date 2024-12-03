#!/usr/bin/env bash
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

source "$SCRIPT_DIR"/icandy/colors.sh

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
  PYELL paru is installed
else
   PRED paru is not installed
   sleep 1
   PMAG beginning installation of paru...
   bash "$SCRIPT_DIR"/chaotic.sh
   sudo pacman -S --noconfirm --needed paru yay wget aria2
   PDONE
fi

source "$SCRIPT_DIR"/base/chaotic.sh
source "$SCRIPT_DIR"/base/dots.sh
source "$SCRIPT_DIR"/packages/twms.sh
source "$SCRIPT_DIR"/packagessddm.sh
source "$SCRIPT_DIR"/icandy/themeing.sh
source "$SCRIPT_DIR"/packages/user-apps.sh
source "$SCRIPT_DIR"/packages/utilities.sh
