#!/usr/bin/env bash

## Variables
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
FF_PATH="${HOME}/.mozilla"
FF_INI_PATH="${FF_PATH}/firefox/profiles.ini"
JS_PATH="/tmp/user.js"
PROFILE_NAME="$(whoami)"
# Source colors
source $SCRIPT_DIR/colors.sh

# functions
get_profiles() {

  PROFILES=$(cat ${FF_INI_PATH} | awk -F '=' '/Path/ {print $2}' | tr -d ' ')

}

install_js() {
  
  get_profiles
  for profile in $PROFILES; do
    prof_path="${FF_PATH}/firefox/$profile"

    PCYAN Installing Betterfox for $prof_path

    if [ -d "$prof_path" ]; then
      cp -f $JS_PATH $prof_path
      rm -rf $prof_path/prefs.js
    else
      PRED Directory does not exist: $prof_path
    fi
    PDONE
  done
  echo

}

# Get custom user.js
PCYAN Grabbing betterfox user.js ....
sleep 1
wget -O $JS_PATH https://raw.githubusercontent.com/yokoffing/Betterfox/refs/heads/main/user.js &&
PDONE

sleep 2

PCYAN Getting Profiles
get_profiles

if [ -z "$PROFILES" ]; then
  PYELL No profiles found. Creating a new profile named as $PROFILE_NAME
  firefox -CreateProfile $PROFILE_NAME
  install_js
else
  PCYAN Pre-existing profile found, updating user.js
  install_js
fi

firefox -P $PROFILE_NAME &
sleep 2 
killall firefox
