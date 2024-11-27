#!/bin/bash

# The follwoing will attempt to install all needed packages to run Hyprland.
# This is a quick and dirty script, there is no error checking.
# This script is meant to run on a fresh Arch Linux system.
#
# A list of packages installed is available at packages.md.
#


#### Check for yay ####
ISYAY=/sbin/yay
if [ -f "$ISYAY" ]; then 
    echo -e "yay was located, moving on.\n"
    yay -Suy
else 
    echo -e "yay was not located, please install yay. Exiting script.\n"
    exit 
fi

### Disable wifi powersave mode ###
read -n1 -rep 'Would you like to disable wifi powersave? (y,n) ' WIFI
if [[ $WIFI == "Y" || $WIFI == "y" ]]; then
    LOC="/etc/NetworkManager/conf.d/wifi-powersave.conf"
    echo -e "The following has been added to $LOC.\n"
    echo -e "[connection]\nwifi.powersave = 2" | sudo tee -a $LOC
    echo -e "\n"
    echo -e "Restarting NetworkManager service...\n"
    sudo systemctl restart NetworkManager
    sleep 3
fi

### Install all of the above pacakges ####
read -n1 -rep 'Would you like to install the packages? (y,n) ' INST
if [[ $INST == "Y" || $INST == "y" ]]; then
    yay -S --noconfirm code htop btop tmux zsh less kitty chromium \
    gtk-engine-murrine xsel sof-firmware uwsm \
    hyprland hyprlock hypridle alacritty enpass gtk2-engines waybar \
    cmake freetype2 fontconfig pkg-config make libxcb libxkbcommon python \
    swaybg wofi wlogout mako thunar \
    ttf-jetbrains-mono-nerd ttf-fira-sans ttf-font-awesome noto-fonts-emoji \
    polkit-gnome python-requests starship \
    swappy grim slurp pamixer brightnessctl gvfs \
    bluez bluez-utils lxappearance xfce4-settings \
    dracula-gtk-theme dracula-icons-git xdg-desktop-portal-hyprland

    # Start the bluetooth service
    echo -e "Starting the Bluetooth Service...\n"
    sudo systemctl enable --now bluetooth.service
    sleep 2
    
    # Clean out other portals
    echo -e "Cleaning out conflicting xdg portals...\n"
    yay -R --noconfirm xdg-desktop-portal-gnome xdg-desktop-portal-gtk
fi

### Copy Config Files ###
read -n1 -rep 'Would you like to copy config files? (y,n) ' CFG
if [[ $CFG == "Y" || $CFG == "y" ]]; then
    echo -e "Copying config files...\n"
    cp -R hypr ~/.config/
    cp -R alacritty ~/.config/
    cp -R mako ~/.config/
    cp -R waybar ~/.config/
    cp -R wofi ~/.config/
    cp -R wlogout ~/.config/
    cp electron/electron-flags.conf ~/.config/
    echo "> WARNING Safely place extra-flags for spotify-launcher (check electron/spotify-launcher.conf)"
    
    # Set some files as exacutable 
    chmod +x ~/.config/hypr/xdg-portal-hyprland
    chmod +x ~/.config/waybar/scripts/waybar-wttr.py
fi

### Install teh starship shell ###
read -n1 -rep 'Would you like to install the starship shell? (y,n) ' STAR
if [[ $STAR == "Y" || $STAR == "y" ]]; then
    # install the starship shell
    echo -e "Updating .bashrc...\n"
    echo -e '\neval "$(starship init bash)"' >> ~/.bashrc
    echo -e "copying starship config file to ~/.confg ...\n"
    cp starship/starship.toml ~/.config/
fi

### Script is done ###
echo -e "Script had completed.\n"
echo -e "You can start Hyprland by typing Hyprland (note the capital H).\n"
read -n1 -rep 'Would you like to start Hyprland now? (y,n) ' HYP
if [[ $HYP == "Y" || $HYP == "y" ]]; then
    exec Hyprland
else
    exit
fi
