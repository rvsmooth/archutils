#!/usr/bin/env bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

source "$SCRIPT_DIR"/../icandy/colors.sh
browser_primary='one.ablaze.floorp'
browser_secondary='com.brave.Browser'

NATIVE_PKGS=(
	"btop"
	"calibre"
	"flatpak"
	"gimp"
	"kiwix-desktop"
	"mpv"
	"musikcube"
	"neovim"
	"newsboat"
	"npm"
	"obs-studio"
	"qbittorrent"
)

FLATPAKS=(
	"$browser_primary"
	"com.notesnook.Notesnook"
	"com.rustdesk.RustDesk"
	"eu.betterbird.Betterbird"
	"io.github.troyeguo.koodo-reader"
	"$browser_secondary"
	"org.localsend.localsend_app"
	"org.onlyoffice.desktopeditors"
)


PYELL Installing User Applications......
$SPS "${NATIVE_PKGS[@]}"
PDONE

PYELL Installing Flatpaks
flatpak install -y --user "${FLATPAKS[@]}"
flatpak install -y --user https://flathub.org/beta-repo/appstream/org.gimp.GIMP.flatpakref
PDONE

PYELL Configuring Browsers...
PYELL Setting floorp as default Browser
xdg-settings set default-web-browser "$browser_primary".desktop
PYELL Allow ~/Pictures and ~/Downloads directory to browser 
flatpak override --user $browser_primary --filesystem=~/Downloads
flatpak override --user $browser_primary --filesystem=~/Pictures
flatpak override --user $browser_secondary --filesystem=~/Downloads
flatpak override --user $browser_secondary --filesystem=~/Pictures
PDONE
