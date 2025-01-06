#!/usr/bin/env bash

## Variables
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
JS_PATH="/tmp/user.js"
PROFILE_NAME="$(whoami)"
function get_profs() {

	PROFILES="$(cat "${INI_PATH}" | awk -F '=' '/Path/ {print $2}' | tr -d ' ')"
}

# Source colors
source "$SCRIPT_DIR"/../icandy/colors.sh

# functions
function install_js() { 
	get_profs
	for profile in $PROFILES; do
		prof_path="${BROWSER_PATH}/$profile"
		PCYAN Installing Betterfox for "$prof_path"

		if [ -d "$prof_path" ]; then
			cp -f $JS_PATH "$prof_path"
			rm -rf "$prof_path"/prefs.js
		else
			PRED Directory does not exist: "$prof_path"
		fi
		PDONE
	done
	echo
}

## the exact format of get_js is IMPORTANT!; do not change if
function get_js() {
	PCYAN Grabbing betterfox user.js ....
	sleep 1
	wget -O "$JS_PATH" https://raw.githubusercontent.com/yokoffing/Betterfox/refs/heads/main/user.js &&
		cat ${SCRIPT_DIR}/prefs | tee -a "$JS_PATH"

	}

function wfox() {
	BROWSER="waterfox"
	BROWSER_PATH="${HOME}/.waterfox"
	INI_PATH="${BROWSER_PATH}/profiles.ini"
}

function ffox() {
	BROWSER="firefox"
	BROWSER_PATH="/home/subham/.var/app/org.mozilla.firefox/.mozilla/firefox"
	INI_PATH="${BROWSER_PATH}/profiles.ini"	
}

function installer() {

	get_profs
	if [ -z "$PROFILES" ]; then
		PYELL No profiles found. Creating a new profile named as "$PROFILE_NAME"
		$BROWSER -CreateProfile "$PROFILE_NAME"
		install_js
	else
		PCYAN Pre-existing profile found, updating user.js
		install_js
	fi

}

function check_browser() {
	if ! command -v "$BROWSER" &> /dev/null; then
		echo "$BROWSER not found. Please install it first."
		exit 1
fi

}

function lunch_browser_once() {

	$BROWSER -P "$PROFILE_NAME" &
}

usage() {
  echo "Usage: $0 --browser <browser>"
  echo
  echo "Options:"
  echo "  -ff/--firefox    Install Betterfox for Firefox profile"
  echo "  --wf/--waterfox   Install Betterfox for Waterfox profile"
  echo
  echo "Arguments:"
  echo "  <browser>    Specify the browser for which to install Betterfox. The supported browsers are:"
  echo "               firefox    For Firefox profiles"
  echo "               waterfox   For Waterfox profiles"
  echo
  echo "Example usage:"
  echo "  $0 --firefox       # Installs Betterfox for Firefox profile"
  echo "  or "
  echo "  $0 --ff"
  echo
  echo "  $0 --waterfox      # Installs Betterfox for Waterfox profile"
  echo "  or "
  echo "  $0 --wf"
  echo
  echo "If no profiles exist, a new profile will be created with your system username."
  echo "If a profile already exists, it will be updated with the latest Betterfox settings."
  exit 1
}

# Check if arguments are provided
if [ $# -eq 0 ]; then
  usage
fi

# Parse the command-line arguments
case "$1" in
	-ff|--firefox)
		get_js
		ffox
		installer
		lunch_browser_once
		;;
	-wf|--waterfox)
		get_js
		wfox
		check_browser
		installer
		lunch_browser_once
		;;
	-h|--help)
		usage
		;;
	*)
		usage
		;;
esac


