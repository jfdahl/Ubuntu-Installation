#!/usr/bin/env bash

[[ $(which git) ]] || sudo apt-get install -y git || exit 1

local_file_location=/tmp/atom.deb
remote_file_location=https://atom.io/download/deb

wget -O ${local_file_location} ${remote_file_location} && \
sudo dpkg -i ${local_file_location} && \
rm ${local_file_location}
sudo apt-get install -yf

apm install minimap highlight-selected cobalt2-syntax
