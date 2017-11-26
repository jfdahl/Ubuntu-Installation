#!/usr/bin/env bash

# Setup working folder
current_location=$(pwd)
if [[ "$current_location" != "/tmp/bin" ]]; then
    cd /tmp/bin
fi
chmod -R 777 /tmp/bin

# Configure package manager.
#sed -i.bak 's|# deb http://archive.canonical.com/ubuntu artful partner|deb http://archive.canonical.com/ubuntu artful partner|g' /etc/apt/sources.list
sed -i.bak 's|# \(deb http://archive.canonical.com/ubuntu artful partner\)|\1|g' /etc/apt/sources.list
apt-get update -qq

# Install core apps and utilities
core_packages="git htop mc mtr pv"
apt-get install -y ${core_packages}

# Configure Grub
sed -i.bak 's|\(GRUB_CMDLINE_LINUX_DEFAULT="\)splash quiet"|\1"|' /etc/default/grub
update-grub

# Configure network interfaces

# Disable DNSMASQ

# Disable IPV6
echo >> /etc/sysctl.conf << EOF
net.ipv6.conf.all.disable_ipv6 = 1
net.ipv6.conf.default.disable_ipv6 = 1
net.ipv6.conf.lo.disable_ipv6 = 1
EOF

# Final action:
# Setup firewall
sudo ufw allow ssh
sudo ufw default deny
sudo ufw enable << EOF
y
EOF

# Cleanup temporary settings and reboot
usermod -p '!' root
sed -i 's/^\(PermitRootLogin\) yes$/\1 no/' /etc/ssh/sshd_config

#shutdown -r now
