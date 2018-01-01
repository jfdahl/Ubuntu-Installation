#!/usr/bin/env bash

local_file_location=/tmp/firefox.tar.bz2
remote_file_location="https://download.mozilla.org/?product=firefox-latest-ssl&os=linux64&lang=en-US"
install_location=/usr/share

wget -O ${local_file_location} "${remote_file_location}"
tar -xjf ${local_file_location} -C ${install_location}
ln -s ${install_location}/firefox/firefox /usr/bin
rm ${local_file_location}

# Setup desktop file and menu entries
cat >> /usr/share/applications/firefox.desktop << EOF
[Desktop Entry]
Name=Firefox
Comment=Web Browser.
GenericName=Web Browser
Exec=${install_location}/firefox/firefox %F
Icon=${install_location}/firefox/browser/icons/mozicon128.png
Type=Application
StartupNotify=true
Categories=GNOME;GTK;Internet;
MimeType=text/plain;
EOF
