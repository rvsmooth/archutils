#!/usr/bin/env bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

source $SCRIPT_DIR/colors.sh

emagenta Installing QTile and its dependencies...
$SPS qtile qtile-extras python-psutil
donemsg


