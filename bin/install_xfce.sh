#!/bin/bash

[[ $(lspci | grep VirtualBox) ]] && VBOX=true || VBOX=false

packages="xfce4 xfce4-whiskermenu-plugin gvfs alsa-utils xscreensaver mousepad terminator"
$VBOX && packages="${packages} dkms build-essential"

sudo apt install -y ${packages}

sudo bash install_firefox.sh
sudo bash install_atom.sh
sudo bash install_python.sh
sudo bash install_node.sh
