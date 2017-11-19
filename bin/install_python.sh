#!/usr/bin/env bash

~/bin/install.sh -y python3-pip python3-setuptools && pip3 install virtualenvwrapper

cat << EOF >> /tmp/bin/env.sh
# Python and VirtualEnv Settings:
VIRTUALENVWRAPPER_PYTHON=\$(which python3)

WORKON_HOME=\${HOME}/VEs
[ -d \$WORKON_HOME ] || mkdir -p \$WORKON_HOME

PROJECT_HOME=\${HOME}/Projects
[ -d \$PROJECT_HOME ] || mkdir -p \$PROJECT_HOME

script_loc=~${HOME}/.local/bin/virtualenvwrapper.sh
[ -f \${script_loc} ] && source \${script_loc}

export PATH=${PATH}:${HOME}/.local/bin

EOF
