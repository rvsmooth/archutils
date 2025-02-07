#!/usr/bin/env bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

source "$SCRIPT_DIR"/../icandy/colors.sh

NATIVE_PKGS=(
	"btop"
	"brave-bin"
	"calibre"
	"flatpak"
	"gimp"
	"kiwix-desktop"
	"libreoffice-fresh"
	"mpv"
	"musikcube"
	"neovim"
	"newsboat"
	"npm"
	"obs-studio"
	"qbittorrent"
	"thunderbird"
)

FLATPAKS=(
	"com.notesnook.Notesnook"
	"com.rustdesk.RustDesk"
	"io.github.troyeguo.koodo-reader"
	"org.localsend.localsend_app"
)


PYELL Installing User Applications......
$SPS "${NATIVE_PKGS[@]}"
PDONE

PYELL Installing Flatpaks
flatpak install -y --user "${FLATPAKS[@]}"
flatpak install -y --user https://flathub.org/beta-repo/appstream/org.gimp.GIMP.flatpakref
PDONE

