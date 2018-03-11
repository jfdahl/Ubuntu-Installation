#!/usr/bin/env bash

# [ -f /usr/local/bin/virtualenv ] || \
# sudo apt-get install -y python3-pip python3-setuptools && \
# sudo pip3 install virtualenvwrapper ||
# exit 1
#
# cat << EOF >> ~/bin/env.sh
#
# # Python and VirtualEnv Settings:
# VIRTUALENVWRAPPER_PYTHON=\$(which python3)
#
# WORKON_HOME=\${HOME}/VEs
# [ -d \$WORKON_HOME ] || mkdir -p \$WORKON_HOME
#
# PROJECT_HOME=\${HOME}/Projects
# [ -d \$PROJECT_HOME ] || mkdir -p \$PROJECT_HOME
#
# script_loc=/usr/local/bin/virtualenvwrapper.sh
# [ -f \${script_loc} ] && source \${script_loc}
#
# EOF

local_file_location=~/Miniconda3-latest-Linux-x86_64.sh
remote_file_location="https://repo.continuum.io/miniconda/Miniconda3-latest-Linux-x86_64.sh"
install_location=~/.local/share/miniconda3

wget -O ${local_file_location} "${remote_file_location}"
bash ${local_file_location} -b -p ${install_location}
cat >> ~/bin/env.sh << EOF

export PATH="${install_location}/bin:\$PATH"

EOF
