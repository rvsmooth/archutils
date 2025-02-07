#!/bin/bash

VERSION="135.0"
ARCH="x86_64"
DEPS=("alsa-lib" "dbus-glib" "gtk3" "libxt" "nss" "ccache" "ffmpeg" "hunspell" "hyphen" "libnotify")
URL="https://archive.mozilla.org/pub/firefox/releases/${VERSION}/linux-${ARCH}/en-US/firefox-${VERSION}.tar.xz"

function check_installation(){
	if command -v firefox &> /dev/null 
	then
		export FIREFOX_INSTALLED="1"
	else
		export FIREFOX_INSTALLED="0"
	fi
}
function install_firefox(){

	if [[ "$FIREFOX_INSTALLED" == "1" ]]; then
		echo "Firefox is already installed"
		echo "Please use --update flag if you want to update it."
	else
		wget $URL
		tar xf firefox-${VERSION}.tar.xz
		wget https://raw.githubusercontent.com/mozilla/sumo-kb/main/install-firefox-linux/firefox.desktop 
		sudo mv firefox /opt 
		sudo  ln -s /opt/firefox/firefox /usr/local/bin/firefox 
		sudo cp firefox.desktop /usr/local/share/applications
	fi
}

function uninstall_firefox(){
	if [[ "$FIREFOX_INSTALLED" == "1" ]]; then
		echo "Uninstalling firefox"
		sudo rm -rf  /opt/firefox /usr/local/share/applications/firefox.desktop /usr/local/bin/firefox
	else 
		echo $FIREFOX_INSTALLED
	fi
}

function update_firefox(){
	if [[ "$FIREFOX_INSTALLED" == "0" ]]; then
		echo "Firefox is not installed."
		echo "Please install it first using --install flag."
	else 
		echo "Updating firefox"
		LOCAL_VER=$(firefox --version | awk '{print $3}')
		if [[ "$LOCAL_VER" == "$VERSION" ]]; then
			echo "Firefox is already up-to-date."
		else
			install_firefox
		fi
	fi
	}

usage() {
  echo "Usage: $0 --browser <browser>"
  echo
  echo "Options:"
  echo "  --install     Install firefox"
  echo "  --update      Update firefox"
  echo "  --uninstall   Uninstall firefox"
  echo
  exit 1
}

if [ $# -eq 0 ]; then
  usage
fi

# Parse the command-line arguments
case "$1" in
	--install)
		check_installation
		install_firefox
		;;
	--uninstall)
		check_installation
		uninstall_firefox
		;;
	--update)
		check_installation
		update_firefox
		;;
	-h|--help)
		usage
		;;
	*)
		usage
		;;
esac

