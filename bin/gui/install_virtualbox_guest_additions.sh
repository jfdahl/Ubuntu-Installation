#!/usr/bin/env bash
# Run this as the user so that the username can be captured.

script_location=$(find /media/${user} -name VBoxLinuxAdditions.run)
[[ -f $script_location ]] || \
sudo mount -o loop /dev/sr0 /mnt && \
script_location=$(find /mnt -name VBoxLinuxAdditions.run) || \
exit 1

sudo bash $script_location && \
sudo usermod -a -G vboxsf ${user}
sudo eject /dev/sr0
sudo reboot
