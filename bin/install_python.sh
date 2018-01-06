#!/usr/bin/env bash

[ -f /usr/local/bin/virtualenv ] || \
sudo apt-get install -y python3-pip python3-setuptools && \
sudo pip3 install virtualenvwrapper ||
exit 1

cat << EOF >> ~/bin/env.sh

# Python and VirtualEnv Settings:
VIRTUALENVWRAPPER_PYTHON=\$(which python3)

WORKON_HOME=\${HOME}/VEs
[ -d \$WORKON_HOME ] || mkdir -p \$WORKON_HOME

PROJECT_HOME=\${HOME}/Projects
[ -d \$PROJECT_HOME ] || mkdir -p \$PROJECT_HOME

script_loc=/usr/local/bin/virtualenvwrapper.sh
[ -f \${script_loc} ] && source \${script_loc}

EOF
