#!/bin/bash

[[ $(lspci | grep VirtualBox) ]] && VBOX=true || VBOX=false

packages="xfce4 xfce4-goodies gvfs alsa-utils xscreensaver mousepad dconf-cli" #xfce4-whiskermenu-plugin xfce4-statusnotifier-plugin
$VBOX && packages="${packages} dkms build-essential"

sudo apt install -y ${packages}
