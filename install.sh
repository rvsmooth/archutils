#!/usr/bin/env bash
INSTALL_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

source "$INSTALL_DIR"/icandy/colors.sh

echo -e "${RED}"
cat <<"EOF"
     _       _   ____                        _   _     
  __| | ___ | |_/ ___| _ __ ___   ___   ___ | |_| |__  
 / _` |/ _ \| __\___ \| '_ ` _ \ / _ \ / _ \| __| '_ \ 
| (_| | (_) | |_ ___) | | | | | | (_) | (_) | |_| | | |
 \__,_|\___/ \__|____/|_| |_| |_|\___/ \___/ \__|_| |_|

EOF
echo -e "${RESET}"

source "$INSTALL_DIR"/base/select.sh
source "$INSTALL_DIR"/base/chaotic.sh
source "$INSTALL_DIR"/base/dots.sh
source "$INSTALL_DIR"/packages/twms.sh
source "$INSTALL_DIR"/packages/sddm.sh
source "$INSTALL_DIR"/icandy/themeing.sh
source "$INSTALL_DIR"/packages/user-apps.sh
source "$INSTALL_DIR"/packages/utilities.sh

PGREEN Installation is Done.'\n'A reboot is recommended before proceeding to use the system.
