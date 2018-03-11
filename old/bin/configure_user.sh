#!/usr/bin/env bash

mkdir -p ${HOME}/bin
cp -r /home/public/bin ${HOME}/
cat >> ${HOME}/.profile << EOF

[ -f ~/bin/env.sh ] && . ~/bin/env.sh

EOF
