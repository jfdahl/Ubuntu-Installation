#!/usr/bin/env bash

[[ $(which git) ]] || sudo apt-get install -y git

local_file_location=/tmp/atom.deb
remote_file_location=https://atom.io/download/deb


wget -O /tmp/${local_file_location} ${remote_file_location} && \
sudo dpkg -i /tmp/${local_file_location} && \
rm /tmp/${local_file_location}
