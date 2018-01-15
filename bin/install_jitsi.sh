#!/usr/bin/env bash

# Pass the "-r" parameter to uninstall the Jitsi suite.
if ["${1}" == "-r"]; then
  apt purge -y jigasi jitsi-meet jitsi-meet-web-config jitsi-meet-web jicofo jitsi-videobridge
  apt purge -y jigasi jitsi-meet jitsi-meet-web-config jitsi-meet-web jicofo jitsi-videobridge
else
  apt -y install nginx || exit 1
  echo 'deb https://download.jitsi.org stable/' >> /etc/apt/sources.list.d/jitsi-stable.list
  wget -qO -  https://download.jitsi.org/jitsi-key.gpg.key | apt-key add -
  apt update && apt -y install jitsi-meet || exit 1
  echo "\nNOTE: To install a Let's Encrypt certificate, execute the following:"
  echo "\t/usr/share/jitsi-meet/scripts/install-letsencrypt-cert.sh"
fi
