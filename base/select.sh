#!/bin/bash

prompt_select_wm() {
    local selected_options=()
    
    echo "Select your Window Manager :"
    echo "1. QTile"
    echo "2. Hyprland"
    echo "3. Sway"
    echo "4. All"
    
    read -p "Enter your choices (e.g., 1 2 3): " -a choices
    
    for choice in "${choices[@]}"; do
        case $choice in
            1)
                selected_options+=("QTile")
		export QTILE=1
                ;;
            2)
                selected_options+=("Hyprland")
		export HYPR=1
                ;;
            3)
                selected_options+=("Sway")
		export SWAY=1
                ;;
            4)
                selected_options+=("All")
		export QTILE=1 HYPR=1 SWAY=1
                ;;
            *)
                echo "Invalid option: $choice. Skipping."
                ;;
        esac
    done
    
    # Check if any valid options were selected
    if [ ${#selected_options[@]} -eq 0 ]; then
        echo "No valid options selected."
        return 1
    fi
    
    # Export selected options as a comma-separated string
    export SELECTED_OPTIONS=$(IFS=,; echo "${selected_options[*]}")
    
    # Display selected options
    echo "You selected: ${SELECTED_OPTIONS}"
}

prompt_select_wm
