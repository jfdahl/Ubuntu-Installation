#!/usr/bin/env bash

# Check for WIFI adapter
pci_wifi_count=$(lspci | egrep -ic 'wifi|wlan|wireless')
usb_wifi_count=$(lsusb | egrep -ic 'wifi|wlan|wireless')
wifi_count=$(( $pci_wifi_count + $usb_wifi_count ))
[ ${wifi_count} -gt 0 ] && WIFI=true || WIFI=false

if [ ! $WIFI ]; then exit 1; fi

# Disable IPv6
cat << EOF >> /etc/sysctl.d/20-disable-ipv6.conf
net.ipv6.conf.all.disable_ipv6 = 1
net.ipv6.conf.default.disable_ipv6 = 1
net.ipv6.conf.lo.disable_ipv6 = 1
EOF

apt install -y network-manager rfkill wireless-tools wpasupplicant
systemctl start NetworkManager

cat << EOF >> /home/public/bin/env.sh
alias scanap='nmcli d wifi list'

EOF
