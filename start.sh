#!/usr/bin/env bash

# 1. Boot up the mini.iso disk, usb drive, or image file (for vm).
# 2. Select install
# 3. Select the appropriate items:
#       language
#       keyboard
#       network card
# 4. Enter a hostname
# 5. Select a mirror and set the proxy server
# 6. Wait for additional components
# 7. Set the User information
        username=user
        password=user
# 8. Set home directory encryption
# 9. Set the timezone
# 10. Setup HDD
#       Suggestion to create 1 primary ext4 partition
#       A swap file will be created by the post-install setup script
# 11. Set the automatic update selection
#       Default: "No automatic udpates"
# 12. Select software
#         Default: standard system utilities
#         Add: OpenSSH server
# 13. Install Grub to master boot record
# 14. Complete installation and shutdown the system.
# 15. Remove the installation media
# 16. IF using a NAT'd VM, start the system and add an accessible network interface.
# 17. Get the IP Address of the target system that is accessible


ip_addr=${1}
if [[ "${ip_addr}" = "local" ]]; then
    cp -r bin /tmp/
    cd /tmp/bin
    time bash /tmp/bin/setup.sh
else
    ssh_options='-o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no'
    scp -r $ssh_options bin ${username}@${ip_addr}:/tmp/
    time ssh $ssh_options ${username}@${ip_addr} bash /tmp/bin/setup.sh
fi
