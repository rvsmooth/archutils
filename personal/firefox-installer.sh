
#!/usr/bin/env bash

VERSION="135.0"
ARCH="x86_64"
DEPS=("alsa-lib" "dbus-glib" "gtk3" "libxt" "nss" "ccache" "ffmpeg" "hunspell" "hyphen" "libnotify")
URL="https://archive.mozilla.org/pub/firefox/releases/${VERSION}/linux-${ARCH}/en-US/firefox-${VERSION}.tar.xz"

function install_firefox(){
	wget $URL
	tar xf firefox-${VERSION}.tar.xz
	wget https://raw.githubusercontent.com/mozilla/sumo-kb/main/install-firefox-linux/firefox.desktop 
	sudo mv firefox /opt 
	sudo  ln -s /opt/firefox/firefox /usr/local/bin/firefox 
	sudo cp firefox.desktop /usr/local/share/applications

}

function uninstall_firefox(){
	sudo rm -rf  /opt/firefox /usr/local/share/applications/firefox.desktop /usr/local/bin/firefox
}

install_firefox
