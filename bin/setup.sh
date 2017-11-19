#!/usr/bin/env bash

# Setup working folder
current_location=$(pwd)
if [[ "$current_location" != "/tmp/bin" ]]; then
    mkdir -p /tmp/bin
    cp * /tmp/bin/
    cd /tmp/bin
fi
sudo chmod -R 777 /tmp/bin

# Configure package manager.
sudo sed -i.bak 's|# deb http://archive.canonical.com/ubuntu xenial partner|deb http://archive.canonical.com/ubuntu xenial partner|g' /etc/apt/sources.list
sudo apt-get update -qq

# Configure Grub
sudo sed -i.bak 's|GRUB_CMDLINE_LINUX_DEFAULT="splash quiet"|GRUB_CMDLINE_LINUX_DEFAULT=""|' /etc/default/grub
sudo update-grub

# Configure network interfaces

# Disable DNSMASQ

# Disable IPV6
echo >> /etc/sysctl.conf << EOF
net.ipv6.conf.all.disable_ipv6 = 1
net.ipv6.conf.default.disable_ipv6 = 1
net.ipv6.conf.lo.disable_ipv6 = 1
EOF

# Setup user
/tmp/bin/configure_user.sh

# Final action:
# Setup firewall
sudo ufw allow ssh
sudo ufw default deny
sudo ufw enable

usermod -p '!' root
