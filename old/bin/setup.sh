#!/usr/bin/env bash

# Setup working folder
current_location=$(pwd)
if [[ "$current_location" != "/tmp/bin" ]]; then
    cd /tmp/bin
fi

mkdir -p /home/public/bin
cp -r * /home/public/bin/
chown -R root:users /home/public
chmod -R 755 /home/public/bin

mkdir -p /etc/skel/bin
cp /home/public/bin/env.sh /etc/skel/bin/
cat >> /etc/skel/.profile << EOF

[ -f ~/bin/env.sh ] && . ~/bin/env.sh

EOF

# Configure package manager.
sed -i.bak \
    's|# \(deb http://archive.canonical.com/ubuntu artful partner\)|\1|g' \
    /etc/apt/sources.list
apt-get update -qq

# Configure Grub
sed -i.bak \
    's|\(GRUB_CMDLINE_LINUX_DEFAULT="\)splash quiet"|\1"|' \
    /etc/default/grub
update-grub

# Check hardware
pci_wifi_count=$(lspci | egrep -ic 'wifi|wlan|wireless')
usb_wifi_count=$(lsusb | egrep -ic 'wifi|wlan|wireless')
wifi_count=$(( $pci_wifi_count + $usb_wifi_count ))
[ ${wifi_count} -gt 0 ] && WIFI=true || WIFI=false

# Install default packages
core_packages="dialog git network-manager"
$WIFI && core_packages="${core_packages} rfkill wireless-tools wpasupplicant"
apt-get install -y ${core_packages}

# Networking ###################################################################
systemctl start NetworkManager
systemctl enable NetworkManager
# Disable IPV6
cat >> /etc/sysctl.d/20-disable-ipv6.conf << EOF
net.ipv6.conf.all.disable_ipv6 = 1
net.ipv6.conf.default.disable_ipv6 = 1
net.ipv6.conf.lo.disable_ipv6 = 1
EOF

$WIFI && {
cat >> /home/public/bin/env.sh << EOF
alias scanap='nmcli d wifi list'
EOF
}

# Disable DNSMASQ
sed -i.bak \
    's/^dns=dnsmasq/#dns=dnsmasq/' \
    /etc/NetworkManager/NetworkManager.conf

# Cleanup temporary settings, update the default user and reboot ###############
usermod -a -G users user
usermod -p '!' root
sed -i.bak 's/^\(PermitRootLogin\) yes$/\1 no/' /etc/ssh/sshd_config

# Setup firewall
ufw allow ssh
ufw default deny
ufw enable << EOF
y
EOF

shutdown -r now
