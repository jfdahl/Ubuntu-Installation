#!/usr/bin/env bash

local_file_location=~/Miniconda3-latest-Linux-x86_64.sh
remote_file_location="https://repo.continuum.io/miniconda/Miniconda3-latest-Linux-x86_64.sh"
install_location=~/.local/share/miniconda3

wget -O ${local_file_location} "${remote_file_location}"
bash ${local_file_location} -b -p ${install_location}
cat >> ~/bin/env.sh << EOF

export PATH="${install_location}/bin:\$PATH"

EOF
