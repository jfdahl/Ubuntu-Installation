#!/usr/bin/env bash


scripts_source="https://gitlab.com/jfdahl/myscripts.git"
mkdir -p ~/Git
git clone ${scripts_source} ~/Git/scripts
chmod -R +x ~/Git/scripts
