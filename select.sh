#!/bin/bash

WMS=("QTile" "Hyprland" "Sway" "Niri" "Continue" "Exit")
WM_SELECTED=()

echo "Please choose a WM"
select WM_CHOICE in "${WMS[@]}"; do
  if [[ -n "$WM_CHOICE" ]]; then
    if [[ "$WM_CHOICE" == "QTile" ]]; then
      echo "You have selected QTile"
      export QTILE=1
      WM_SELECTED+=("$WM_CHOICE")
    elif [[ "$WM_CHOICE" == "Hyprland" ]]; then
      echo "You have selected Hyprland"
      export HYPR=1
      WM_SELECTED+=("$WM_CHOICE")
    elif [[ "$WM_CHOICE" == "Sway" ]]; then
      echo "You have selected Sway"
      export SWAY=1
      WM_SELECTED+=("$WM_CHOICE")
    elif [[ "$WM_CHOICE" == "Niri" ]]; then
      echo "You have selected Niri"
      export NIRI=1
      WM_SELECTED+=("$WM_CHOICE")
    elif [[ "$WM_CHOICE" == "Continue" ]]; then
      echo "Continuing with the current selections"
      echo "Selected WMs:" "${WM_SELECTED[@]}"
      return
    elif [[ "$WM_CHOICE" == "Exit" ]]; then
      echo "Exiting the script"
      exit
    fi
  else
    echo "Invalid selection, try again"
  fi

done
