#!/usr/bin/env bash

# See the README.md file for instructions.

ip_addr=${1}
if [[ "${ip_addr}" = "local" ]]; then
    cp -r bin /tmp/
    cd /tmp/bin
    time bash sudo /tmp/bin/setup.sh
else
    ssh_options='-o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no'
    scp -r $ssh_options bin ${username}@${ip_addr}:/tmp/
    time ssh $ssh_options ${username}@${ip_addr} bash sudo /tmp/bin/setup.sh
fi

exit 0

ip_addr=10.0.0.226
ssh_options='-o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no'
ssh $ssh_options user@${ip_addr}
