#!/usr/bin/env bash

# See the README.md file for instructions.

ip_addr=${1}
if [[ "${ip_addr}" = "local" ]]; then
    cp -r bin /tmp/
    cd /tmp/bin
    time bash /tmp/bin/setup.sh
else
    ssh_options='-o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no'
    scp -r $ssh_options bin root@${ip_addr}:/tmp/
    time ssh $ssh_options root@${ip_addr} bash /tmp/bin/setup.sh
fi
