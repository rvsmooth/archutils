#!/usr/bin/env bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
DOTS_CLONE_DIR='/tmp/dotfiles'
LOCAL_DOTS_VERSION="$(cat ${HOME}/.config/assets/version)"
UPSTREAM_VERSION=$(curl https://gitlab.com/dotsmooth/dotfiles/-/raw/main/.config/assets/version)
COMPARE=$(vercmp "$LOCAL_DOTS_VERSION" "$UPSTREAM_VERSION")
BARE_REPO="${HOME}/.dotfiles"
BARE_REPO_BAK="${HOME}/.dotfiles-bak"
CONFIGS="${HOME}/.config"
CONFIGS_BAK="${HOME}/.config-bak"

source $SCRIPT_DIR/colors.sh

function prepare_env(){
	eyellow Backing up old config files into $CONFIGS_BAK
	rm -rf $DOTS_CLONE_DIR
	cp -rf $CONFIGS $CONFIGS_BAK
	donemsg
}

function bak_old_repo(){
	eyellow Backing up old bare git repo to $BARE_REPO_BAK
	rm -rf $BARE_REPO_BAK
	git clone $BARE_REPO $BARE_REPO_BAK
	rm -rf $BARE_REPO
	donemsg
}
function get_dots(){
	eyellow Installing dotfiles as a bare git repo
        git clone https://gitlab.com/dotsmooth/dotfiles -b main $DOTS_CLONE_DIR
	cd $DOTS_CLONE_DIR
	cp -rf .* * $HOME/ 
	cd -
	mv -f $HOME/.git $BARE_REPO
	donemsg
}

function execute_updater(){
	if [[ "$COMPARE" -lt 0 ]]; then
		eblue Updates found
		sleep 1
		echo
		eyellow Preparing for updates
		bak_old_repo
		prepare_env
		get_dots
		donemsg
	elif [[ "$COMPARE" -eq 0 ]]; then
		egreen Already up-to-date
	fi
}

if [[ -n "$LOCAL_DOTS_VERSION" ]]; then
	emagenta Dotsmooth is installed already 
	sleep 1 
	echo
	emagenta Checking for Updates
	execute_updater
else
	emagenta Dotsmooth has not been installed 
	echo
	sleep 1
	eyellow Initiating Fresh installation
	sleep 1
	prepare_env
	get_dots
fi
