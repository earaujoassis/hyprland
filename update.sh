#!/usr/bin/env bash

### Update Config Files ###
read -n1 -rep '> Would you like to update all configuration files? (y,n) ' CFG
if [[ $CFG == "Y" || $CFG == "y" ]]
then
    echo -e "> Updating config files...\n"
    cp -fR hypr ~/.config/
    cp -fR alacritty ~/.config/
    cp -fR mako ~/.config/
    cp -fR waybar ~/.config/
    cp -fR wofi ~/.config/
    cp -fR wlogout ~/.config/
    cp -f starship/starship.toml ~/.config/
    cp -f electron/electron-flags.conf ~/.config/
    
    # Set some files as exacutable 
    chmod +x ~/.config/hypr/xdg-portal-hyprland
    chmod +x ~/.config/waybar/scripts/waybar-wttr.py
fi
