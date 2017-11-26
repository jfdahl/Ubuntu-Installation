#!/usr/bin/env bash

local_file_location=/tmp/firefox.tar.bz2
remote_file_location="https://download.mozilla.org/?product=firefox-latest-ssl&os=linux64&lang=en-US"

wget -O ${local_file_location} "${remote_file_location}"
tar -xjf ${local_file_location} -C /usr/share/
ln -s /usr/share/firefox/firefox /usr/bin
rm ${local_file_location}
