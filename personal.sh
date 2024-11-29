#!/usr/bin/env bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
BARE_REPO_DIR="$HOME/.dotfiles"
source $SCRIPT_DIR/colors.sh

function config() {
    git_cmd='/usr/bin/git'
    git_dir="$HOME/.dotfiles/"
    work_tree="$HOME"

    $git_cmd --git-dir="$git_dir" --work-tree="$work_tree" config --unset status.showuntrackedfiles 2>/dev/null
    $git_cmd --git-dir="$git_dir" --work-tree="$work_tree" config status.showuntrackedfiles no

    $git_cmd --git-dir="$git_dir" --work-tree="$work_tree" "$@" 
  }

PMAG  Setting up git configs
git config --global user.name "RVSmooth"
git config --global user.email "riveeks.smooth@gmail.com"
git config --global core.editor "nvim"
PDONE


# Check if the directory exists
if [ -d "$BARE_REPO_DIR" ]; then
	config remote add origin git@gitlab.com:dotsmooth/dotfiles.git
	git remote add github git@github.com:RVSmooth/dotfiles.git
	config remote set-url --add --push origin git@github.com:RVSmooth/dotfiles.git
	config remote set-url --add --push origin git@gitlab.com:dotsmooth/dotfiles.git
	git remote set-url --add --push origin git@gitlab.com:dotsmooth/dotfiles.git
else
    echo "$BARE_REPO_DIR doesn't exist. \n First set up your bare git repo then run this script again"
fi

$SPS libva libva-intel-driver libva-utils
