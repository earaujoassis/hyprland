#!/usr/bin/env bash

HYPRLAND_HOME=$HOME/hyprland
CFG_FOLDER=$HOME/.config

### Update configuration files ###
read -n1 -rep '> Would you like to update all configuration files? (y,n) ' OPTION
if [[ $OPTION == "Y" || $OPTION == "y" ]]
then
    echo "> Updating config files..."
    cp -fR $HYPRLAND_HOME/hypr $CFG_FOLDER/
    cp -fR $HYPRLAND_HOME/mako $CFG_FOLDER/
    cp -fR $HYPRLAND_HOME/waybar $CFG_FOLDER/
    cp -fR $HYPRLAND_HOME/wofi $CFG_FOLDER/
    cp -fR $HYPRLAND_HOME/wlogout $CFG_FOLDER/
    cp -f $HYPRLAND_HOME/electron/electron-flags.conf $CFG_FOLDER/
    
    # Set some files as exacutable 
    chmod +x $CFG_FOLDER/hypr/xdg-portal-hyprland
    chmod +x $CFG_FOLDER/waybar/scripts/waybar-wttr.py
fi
