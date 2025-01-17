#!/usr/bin/env bash

THEMES_PATH="${HOME}/.themes"
ICONS_PATH="${HOME}/.icons"
CURSORS_PATH="${ICONS_PATH}"
ITEMS=(".themes" ".icons")

# in Linux themes are assumed to be folders containing an 'index.theme' file inside them and the folder name being the name of the theme (as I observed)
function get_themes(){
    THEMES_FETCHED=$(find "${THEMES_PATH}" -name "index.theme" | awk -F "${ITEMS[0]}/" '{print $2}' | awk -F '/' '{print $1}')
    THEMES=($THEMES_FETCHED) # store found gtk-theme in THEMES array
}

function get_icons(){
    ICONS_FETCHED=$(find "${ICONS_PATH}" -name "icon-theme.cache" | awk -F "${ITEMS[1]}/" '{print $2}' | awk -F '/' '{print $1}')
    ICONS=($ICONS_FETCHED)  #store found icon-theme names in ICONS array
}

function get_cursors(){
    CURSORS_FETCHED=$(find "${CURSORS_PATH}" -name "cursors" | awk -F "${ITEMS[1]}/" '{print $2}' | awk -F '/' '{print $1}')
    CURSORS=($CURSORS_FETCHED)  #store found cursor-theme in CURSORS array
}

function apply_cursors(){
	gsettings set org.gnome.desktop.interface cursor-theme "$CURSOR_CHOICE"
}

function apply_theme(){
	sudo flatpak override --filesystem=~/.themes
	sudo flatpak override --env=GTK_THEME="$THEME_CHOICE"
	flatpak --user override --env=GTK_THEME="$THEME_CHOICE"
	flatpak --user override --filesystem=~/.themes
	gsettings set org.gnome.desktop.interface gtk-theme "$THEME_CHOICE"
}

function apply_icon(){
	sudo flatpak override --filesystem=~/.icons
	sudo flatpak override --env=ICON_THEME="$ICON_CHOICE"
	flatpak --user override --filesystem=~/.icons
	flatpak --user override --env=ICON_THEME="$ICON_CHOICE"
	gsettings set org.gnome.desktop.interface icon-theme "$ICON_CHOICE"

}

get_icons
get_themes
get_cursors

echo "Please select an icon theme:"
select ICON_CHOICE in "${ICONS[@]}"; do
    if [[ -n "$ICON_CHOICE" ]]; then
        echo "You selected: $ICON_CHOICE"
	echo "Applying icon"
	apply_icon
	echo "Done"
        break
    else
        echo "Invalid selection, try again."
    fi
done

echo "Please select a gtk theme"
select THEME_CHOICE in "${THEMES[@]}"; do
    if [[ -n "$THEME_CHOICE" ]]; then
        echo "You selected: $THEME_CHOICE"
	echo "Applying theme"
	apply_theme
	echo "Done"
        break
    else
        echo "Invalid selection, try again."
    fi
done

echo "Please select a cursor theme"
select CURSOR_CHOICE in "${CURSORS[@]}"; do
    if [[ -n "$CURSOR_CHOICE" ]]; then
        echo "You selected: $CURSOR_CHOICE"
	echo "Applying theme"
	apply_cursors
	echo "Done"
        break
    else
        echo "Invalid selection, try again."
    fi
done

