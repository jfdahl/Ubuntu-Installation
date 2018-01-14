
[ $(which firefox) ] || \
echo 'Please install Firefox first.'; exit 1

file_name=addon-1865-latest.xpi
wget -q -O /tmp/${file_name} https://addons.mozilla.org/firefox/downloads/latest/adblock-plus/${file_name}
firefox /tmp/${file_name} 2>/dev/null
rm /tmp/${file_name}
