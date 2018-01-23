#!/usr/bin/env bash

# See the README.md file for instructions.

ip_addr=${1}
user=root
setup_script=setup.sh
if [[ "${ip_addr}" = "local" ]]; then
    cp -r ./scripts /tmp/scripts
    cd /tmp
    time bash sudo /tmp/scripts/$setup_script
else
    ssh_options='-o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no'
    scp -r $ssh_options ./scripts ${user}@${ip_addr}:/tmp/scripts
    time ssh $ssh_options ${user}@${ip_addr} bash /tmp/scripts/$setup_script
fi
