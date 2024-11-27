#!/usr/bin/env bash

export HYPRLAND_HOME=$HOME/hyprland
export CFG_FOLDER=$HOME/.config

### Update configuration files ###
read -n1 -rep '> Would you like to update all configuration files? (y,n) ' CFG
if [[ $CFG == "Y" || $CFG == "y" ]]
then
    echo -e "> Updating config files...\n"
    cp -fR $HYPRLAND_HOME/hypr $CFG_FOLDER/
    cp -fR $HYPRLAND_HOME/alacritty $CFG_FOLDER/
    cp -fR $HYPRLAND_HOME/mako $CFG_FOLDER/
    cp -fR $HYPRLAND_HOME/waybar $CFG_FOLDER/
    cp -fR $HYPRLAND_HOME/wofi $CFG_FOLDER/
    cp -fR $HYPRLAND_HOME/wlogout $CFG_FOLDER/
    cp -f $HYPRLAND_HOME/starship/starship.toml $CFG_FOLDER/
    cp -f $HYPRLAND_HOME/electron/electron-flags.conf $CFG_FOLDER/
    
    # Set some files as exacutable 
    chmod +x $CFG_FOLDER/hypr/xdg-portal-hyprland
    chmod +x $CFG_FOLDER/waybar/scripts/waybar-wttr.py
fi
