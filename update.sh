#!/bin/bash

### Update Config Files ###
read -n1 -rep 'Would you like to copy config files? (y,n)' CFG
if [[ $CFG == "Y" || $CFG == "y" ]]; then
    echo -e "Copying config files...\n"
    cp -fR hypr ~/.config/
    cp -fR alacritty ~/.config/
    cp -fR mako ~/.config/
    cp -fR waybar ~/.config/
    cp -fR swaylock ~/.config/
    cp -fR wofi ~/.config/
    cp -f starship/starship.toml ~/.config/
    
    # Set some files as exacutable 
    chmod +x ~/.config/hypr/xdg-portal-hyprland
    chmod +x ~/.config/waybar/scripts/waybar-wttr.py
fi
