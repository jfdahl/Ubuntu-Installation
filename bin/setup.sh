#!/usr/bin/env bash

# Setup working folder
current_location=$(pwd)
if [[ "$current_location" != "/tmp/bin" ]]; then
    mkdir -p /tmp/bin
    cp * /tmp/bin/
    cd /tmp/bin
fi
chmod -R 777 /tmp/bin

# Configure package manager.
sed -i.bak 's|# deb http://archive.canonical.com/ubuntu xenial partner|deb http://archive.canonical.com/ubuntu xenial partner|g' /etc/apt/sources.list
apt-get update -qq

# Configure Grub
sed -i.bak 's|GRUB_CMDLINE_LINUX_DEFAULT="splash quiet"|GRUB_CMDLINE_LINUX_DEFAULT=""|' /etc/default/grub
update-grub

# Configure network interfaces

# Disable DNSMASQ
sed -i.bak 's/^dns=dnsmasq/#dns=dnsmasq/' /etc/NetworkManager/NetworkManager.conf
systemctl restart network

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
ufw allow ssh
ufw default deny
ufw enable

usermod -p '!' root
