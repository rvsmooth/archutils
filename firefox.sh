#!/usr/bin/env bash

FF_PATH="${HOME}/.mozilla"
FF_INI_PATH="${FF_PATH}/firefox/profiles.ini"
PROFILES=$(cat ${FF_INI_PATH} | awk -F '=' '/Path/ {print $2}' | tr -d ' ')
JS_PATH="/tmp/user.js"


install_js() {

  for profile in $PROFILES; do
    prof_path="${FF_PATH}/firefox/$profile"

    echo "Installing Betterfox for $prof_path:"

    if [ -d "$prof_path" ]; then
      cp -f $JS_PATH $prof_path
    else
      echo "Directory does not exist: $prof_path"
    fi

    echo
  done

}

create_user() {

  firefox -CreateProfile $(whoami)

}

echo "Grabbing betterfox user.js ...."
wget -O $JS_PATH https://raw.githubusercontent.com/yokoffing/Betterfox/refs/heads/main/user.js &&
echo "Done"


if [ -z "$PROFILES" ]; then
  echo "No profiles found. Creating a new profile named as $(whoami)"
  create_user
  install_js
else
  install_js
fi

