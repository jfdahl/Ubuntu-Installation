#!/usr/bin/env bash

# remote_file_location=https://go.microsoft.com/fwlink/?LinkID=620882 # 64bit osx package

# local_file_location=/tmp/visual_studio_code.deb
# remote_file_location=https://go.microsoft.com/fwlink/?LinkID=760868 # 64bit deb package
# wget -O ${local_file_location} ${remote_file_location} && \
# sudo dpkg -i ${local_file_location} && \
# rm ${local_file_location}
# sudo apt-get install -yf

local_file_location=/tmp/visual_studio_code.tar.gz
remote_file_location=https://go.microsoft.com/fwlink/?LinkID=620884 # 64bit tarball
install_location=/usr/share
wget -O ${local_file_location} ${remote_file_location}
tar -xzf ${local_file_location} -C ${install_location}
ln -s ${install_location}/VSCode-linux-x64/code /usr/bin
rm ${local_file_location}

cat >> /usr/share/applications/code.desktop << EOF
[Desktop Entry]
Name=Visual Studio Code
Comment=Text Editor.
GenericName=Text Editor
Exec=${install_location}/VSCode-linux-x64/code %F
Icon=${install_location}/VSCode-linux-x64/resources/app/resources/linux/code.png
Type=Application
StartupNotify=true
Categories=TextEditor;Development;
Terminal=false
MimeType=text/plain
EOF
