#!/bin/bash

packages="xfce4 xfce4-whiskermenu-plugin gvfs mousepad"

sudo apt install -y ${packages}

sudo bash /tmp/bin/install_firefox.sh
sudo bash /tmp/bin/install_atom.sh
