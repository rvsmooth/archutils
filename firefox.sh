#!/usr/bin/env bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
FF_PATH="${HOME}/.mozilla"
FF_INI_PATH="${FF_PATH}/firefox/profiles.ini"
JS_PATH="/tmp/user.js"

source $SCRIPT_DIR/colors.sh

get_profiles() {

  PROFILES=$(cat ${FF_INI_PATH} | awk -F '=' '/Path/ {print $2}' | tr -d ' ')

}

install_js() {
  
  get_profiles
  for profile in $PROFILES; do
    prof_path="${FF_PATH}/firefox/$profile"

    ecyan Installing Betterfox for $prof_path

    if [ -d "$prof_path" ]; then
      cp -f $JS_PATH $prof_path
    else
      ered Directory does not exist: $prof_path
    fi
    donemsg
  done
    echo

}

ecyan Grabbing betterfox user.js ....
sleep 1
wget -O $JS_PATH https://raw.githubusercontent.com/yokoffing/Betterfox/refs/heads/main/user.js &&
donemsg

sleep 2

ecyan Getting Profiles
get_profiles

if [ -z "$PROFILES" ]; then
  eyellow No profiles found. Creating a new profile named as $(whoami)
  firefox -CreateProfile $(whoami)
  install_js
else
  install_js
fi

