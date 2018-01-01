#!/usr/bin/env bash

local_file_location=/tmp/visual_studio_code.deb
# remote_file_location=https://go.microsoft.com/fwlink/?LinkID=620884 # 64bit tarball
# remote_file_location=https://go.microsoft.com/fwlink/?LinkID=620882 # 64bit osx package
remote_file_location=https://go.microsoft.com/fwlink/?LinkID=760868 # 64bit deb package

wget -O ${local_file_location} ${remote_file_location} && \
sudo dpkg -i ${local_file_location} && \
rm ${local_file_location}
sudo apt-get install -yf


# install_location=/usr/share

# wget -O ${local_file_location} "${remote_file_location}"
# tar -xjf ${local_file_location} -C ${install_location}
# ln -s ${install_location}/firefox/firefox /usr/bin
# rm ${local_file_location}
