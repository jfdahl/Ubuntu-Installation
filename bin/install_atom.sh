#!/usr/bin/env bash

[[ $(which git) ]] || sudo apt-get install -y git || exit 1

local_file_location=/tmp/atom.deb

wget -O /tmp/${local_file_location} https://atom.io/download/deb && \
sudo dpkg -i /tmp/${local_file_location} && \
rm /tmp/${local_file_location}
