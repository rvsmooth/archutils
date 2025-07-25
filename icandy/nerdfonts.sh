#!/bin/bash

# Function to check if a command exists
command_exists() {
  command -v "$1" >/dev/null 2>&1
}

# Check if unzip is installed; if not, install it
if ! command_exists unzip; then
  echo "Installing unzip..."
  sudo apt install unzip -y
fi

# Create directory for fonts if it doesn't exist
[ ! -d "$HOME/.fonts" ] && mkdir -p "$HOME/.fonts"

# Array of font names
fonts=(
  "CascadiaCode"
  "FiraCode"
  "Hack"
  "JetBrainsMono"
)

# Function to check if font directory exists
check_font_installed() {
  font_name=$1
  if [ -d ~/.fonts/$font_name ]; then
    echo "Font $font_name is already installed. Skipping."
    return 0 # Font already installed
  else
    return 1 # Font not installed
  fi
}

# Loop through each font, check if installed, and install if not
for font in "${fonts[@]}"; do
  if check_font_installed "$font"; then
    echo "Skipping installation of font: $font"
    continue # Skip installation if font is already installed
  fi

  echo "Installing font: $font"
  wget -q --show-progress -nc --wait=2 --random-wait "https://github.com/ryanoasis/nerd-fonts/releases/latest/download/$font.zip" -P /tmp
  if [ $? -ne 0 ]; then
    echo "Failed to download font: $font"
    continue
  fi

  unzip -q /tmp/$font.zip -d ~/.fonts/$font/
  if [ $? -ne 0 ]; then
    echo "Failed to extract font: $font"
    continue
  fi

  rm /tmp/$font.zip
done

# Update font cache
fc-cache -f

echo "Fonts installation completed."
