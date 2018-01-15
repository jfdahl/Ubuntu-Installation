#!/usr/bin/env bash


# Binaries: https://nodejs.org/dist/v8.9.4/node-v8.9.4-linux-x64.tar.xz
# Source: https://nodejs.org/dist/v8.9.4/node-v8.9.4.tar.gz


sudo apt install -y nodejs npm
if [ "$?" == "0" ] && [ ! -f /usr/bin/node ]; then
    sudo ln -s /usr/bin/nodejs /usr/bin/node
fi
