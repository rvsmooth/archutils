#!/usr/bin/env bash

# Some common vars
SPS='paru -S --noconfirm --needed'

# Color Codes
RESET='\033[0m'
BLACK='\033[0;30m'
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
BLUE='\033[0;34m'
MAGENTA='\033[0;35m'
CYAN='\033[0;36m'
WHITE='\033[0;37m'

# Color Functions
eblack() {
    echo -e "${BLACK}$@${RESET}"
}

ered() {
    echo -e "${RED}$@${RESET}"
}

egreen() {
    echo -e "${GREEN}$@${RESET}"
}

eyellow() {
    echo -e "${YELLOW}$@${RESET}"
}

eblue() {
    echo -e "${BLUE}$@${RESET}"
}

emagenta() {
    echo -e "${MAGENTA}$@${RESET}"
}

ecyan() {
    echo -e "${CYAN}$@${RESET}"
}

ewhite() {
    echo -e "${WHITE}$@${RESET}"
}

donemsg() {
  sleep 1 && egreen Done...
}

