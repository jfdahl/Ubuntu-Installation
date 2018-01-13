#!/usr/bin/env bash

# Setup working folder
current_location=$(pwd)
if [[ "$current_location" != "/tmp/bin" ]]; then
    cd /tmp/bin
fi

mkdir -p /home/public/bin
cp -r * /home/public/bin/
chown -R root:users /home/public
chmod -R 775 /home/public/bin
ln -s /home/public/bin /etc/skel/bin

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
core_packages="git htop mc mtr pv network-manager"
$WIFI && core_packages="${core_packages} rfkill wireless-tools wpasupplicant"
apt-get install -y ${core_packages}

# Networking ###################################################################
systemctl start NetworkManager
systemctl enable NetworkManager
# Disable IPV6
echo >> /etc/sysctl.d/20-disable-ipv6.conf << EOF
net.ipv6.conf.all.disable_ipv6 = 1
net.ipv6.conf.default.disable_ipv6 = 1
net.ipv6.conf.lo.disable_ipv6 = 1
EOF

$WIFI && {
cat << EOF >> /home/public/bin/env.sh
alias scanap='nmcli d wifi list'
EOF
}

sed -i.bak \ # Disable DNSMASQ
    's/^dns=dnsmasq/#dns=dnsmasq/' \
    /etc/NetworkManager/NetworkManager.conf

systemctl restart network

# Final action:
# Setup firewall
ufw allow ssh
ufw default deny
ufw enable << EOF
y
EOF

# Cleanup temporary settings, update the default user and reboot
cp -r /home/public/bin /home/user/bin
chown -R user:user /home/user/bin

usermod -a -G users user
usermod -p '!' root
sed -i 's/^\(PermitRootLogin\) yes$/\1 no/' /etc/ssh/sshd_config

shutdown -r now
