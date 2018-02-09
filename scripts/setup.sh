#!/usr/bin/env bash

default_user=user
release_codename=$(lsb_release -cs)

cd /tmp

# Setup swap file ##############################################################
if [ -f /swapfile ]; then
    swapoff /swapfile
    rm /swapfile
fi
fallocate -l 1024M /swapfile
chmod 0600 /swapfile
mkswap /swapfile
sysctl -w vm.swappiness=1
swapon /swapfile
mkdir -p /etc/sysctl.d
echo 'vm.swappiness = 1' >> /etc/sysctl.d/99-sysctl.conf
echo '/swapfile none    swap    deafults    0   0' >> /etc/fstab

# Configure package manager ####################################################
sed -i.bak \
    "s|# \(deb http://archive.canonical.com/ubuntu ${release_codename} partner\)|\1|g" \
    /etc/apt/sources.list
apt-get update -qq

# Configure Grub ###############################################################
sed -i.bak \
    's|\(GRUB_CMDLINE_LINUX_DEFAULT="\).*?"|\1"|' \
    /etc/default/grub
update-grub

# Check for WIFI hardware ######################################################
pci_wifi_count=$(lspci | egrep -ic 'wifi|wlan|wireless')
usb_wifi_count=$(lsusb | egrep -ic 'wifi|wlan|wireless')
wifi_count=$(( $pci_wifi_count + $usb_wifi_count ))
[ ${wifi_count} -gt 0 ] && WIFI=true || WIFI=false
wifi_packages="rfkill dialog wireless-tools wpasupplicant network-manager"

# Install default packages #####################################################
core_packages="ufw sudo git"
$WIFI && core_packages="${core_packages} ${wifi_packages}"
apt-get install -y ${core_packages}


# Setup the public folders
mkdir -p /home/public/bin
cp -r /tmp/scripts /home/public/bin/
cat >> /home/public/bin/env.sh << EOF
export PS1="-\n\h (\u)\n\w\n> "
alias ll='ls -l'
alias lla='ls -la'
EOF
cat >> /home/public/bin/add_env.sh << EOF
mkdir -p ~/bin
cp env.sh ~/bin/
cat >> ~/.profile << EEOF

# Load the environment script if it exists.
[ -f ~/bin/env.sh ] && . ~/bin/env.sh

EEOF
. ~/bin/env.sh
EOF
chown -R root:users /home/public
chmod -R 755 /home/public/bin

# Configure Networking ########################################################
# Disable IPv6
if [ -z /etc/sysctl.d/20-disable-ipv6.conf ]; then
cat >> /etc/sysctl.d/20-disable-ipv6.conf << EOF
net.ipv6.conf.all.disable_ipv6 = 1
net.ipv6.conf.default.disable_ipv6 = 1
net.ipv6.conf.lo.disable_ipv6 = 1
EOF
fi

$WIFI && {
systemctl start NetworkManager
systemctl enable NetworkManager
sed -i.bak \
    's/^dns=dnsmasq/#dns=dnsmasq/' \
    /etc/NetworkManager/NetworkManager.conf
cat >> /home/public/bin/env.sh << EOF
alias scanap='nmcli d wifi list'
EOF
}

# Cleanup temporary settings, update the default user and reboot ###############
sed -i.bak 's/^\(PermitRootLogin\) yes$/\1 no/' /etc/ssh/sshd_config

usermod -aG users,sudo,ssh ${default_user}
ln -s /home/public /home/${default_user}/public
usermod -p '!' root


# Setup firewall
ufw allow ssh
ufw default deny
ufw enable << EOF
y
EOF

shutdown -r now
