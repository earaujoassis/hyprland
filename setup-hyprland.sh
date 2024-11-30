#!/usr/bin/env bash

# The follwoing will attempt to install all needed packages to run Hyprland.
# This is a quick and dirty script, there is no error checking.
# This script is meant to run on a fresh Arch Linux system.
#
# A list of packages installed is available at packages.md.
#

export HYPRLAND_HOME=$HOME/hyprland
export CFG_FOLDER=$HOME/.config

#### Check for yay ####
ISYAY=/sbin/yay
if [ -f "$ISYAY" ]
then 
    echo -e "> yay is available.\n"
    yay -Suy
else 
    echo -e "> yay is not available, please install yay. Exiting script.\n"
    exit 
fi

### Disable Wi-Fi powersave mode ###
read -n1 -rep '> Would you like to disable Wi-Fi powersave? (y,n) ' WIFI
if [[ $WIFI == "Y" || $WIFI == "y" ]]
then
    LOC="/etc/NetworkManager/conf.d/wifi-powersave.conf"
    echo -e "> The following has been added to $LOC.\n"
    echo -e "> [connection]\nwifi.powersave = 2" | sudo tee -a $LOC
    echo -e "\n"
    echo -e "> Restarting NetworkManager service...\n"
    sudo systemctl restart NetworkManager
    sleep 3
fi

### Install all of the the necessary packages ####
read -n1 -rep '> Would you like to install all the necessary packages? (y,n) ' INSTALL
if [[ $INSTALL == "Y" || $INSTALL == "y" ]]
then
    echo -e "> Installing all necessary packages through yay"
    yay -S --noconfirm \
        htop \
        btop \
        zsh \
        tmux \
        less \
        ripgrep \
        pkg-config \
        make \
        cmake \
        libxcb \
        libxkbcommon \
        gtk-engine-murrine \
        xsel \
        sof-firmware \
        uwsm \
        hyprland \
        hyprlock \
        hypridle \
        waybar \
        swaybg \
        wofi \
        wlogout \
        mako \
        swappy \
        hyprpolkitagent \
        xdg-desktop-portal-hyprland \
        polkit-gnome \
        gtk2-engines \
        python \
        python-requests \
        grim \
        slurp \
        pamixer \
        brightnessctl \
        gvfs \
        bluez \
        bluez-utils \
        lxappearance \
        xfce4-settings \
        dracula-gtk-theme \
        dracula-icons-git \
        freetype2 \
        fontconfig \
        ttf-jetbrains-mono-nerd \
        ttf-fira-sans \
        ttf-font-awesome \
        noto-fonts-emoji \
        thunar \
        kitty \
        alacritty \
        enpass \
        chromium \
        brave \
        visual-studio-code-bin \
        neovim \
        vim \
        docker-desktop \
        spotify-launcher

    # Start the bluetooth service
    echo -e "> Starting the Bluetooth Service...\n"
    sudo systemctl enable --now bluetooth.service
    sleep 2
    
    # Clean out other portals
    echo -e "> Cleaning out conflicting xdg portals...\n"
    yay -R --noconfirm \
        xdg-desktop-portal-gnome \
        xdg-desktop-portal-gtk
fi

### Copy configuration files ###
read -n1 -rep '> Would you like to copy all configuration files? (y,n) ' CFG
if [[ $CFG == "Y" || $CFG == "y" ]]; then
    echo -e "Copying config files...\n"
    cp -R $HYPRLAND_HOME/hypr $CFG_FOLDER/
    cp -R $HYPRLAND_HOME/alacritty $CFG_FOLDER/
    cp -R $HYPRLAND_HOME/mako $CFG_FOLDER/
    cp -R $HYPRLAND_HOME/waybar $CFG_FOLDER/
    cp -R $HYPRLAND_HOME/wofi $CFG_FOLDER/
    cp -R $HYPRLAND_HOME/wlogout $CFG_FOLDER/
    cp $HYPRLAND_HOME/electron/electron-flags.conf $CFG_FOLDER/
    echo "> WARNING Safely place extra-flags for spotify-launcher (check electron/spotify-launcher.conf)"
    
    # Set some files as exacutable 
    chmod +x $CFG_FOLDER/hypr/xdg-portal-hyprland
    chmod +x $CFG_FOLDER/waybar/scripts/waybar-wttr.py
fi

### Install the starship shell ###
read -n1 -rep '> Would you like to install starship? (y,n) ' STAR
if [[ $STAR == "Y" || $STAR == "y" ]]; then
    echo -e "> Installing starship...\n"
    yay -S --noconfirm starship
    echo -e "> Updating .bashrc to load starship...\n"
    echo -e '\neval "$(starship init bash)"' >> ~/.bashrc
    echo -e "> Copying starship config file to $CFG_FOLDER ...\n"
    cp starship/starship.toml $CFG_FOLDER/
fi

### Script is complete ###
echo -e "> Script has completed.\n"
echo -e "> You can start Hyprland by typing 'Hyprland' on terminal.\n"
read -n1 -rep '> Would you like to start Hyprland now? (y,n) ' HYP
if [[ $HYPRLAND == "Y" || $HYPRLAND == "y" ]]; then
    exec Hyprland
else
    exit
fi
