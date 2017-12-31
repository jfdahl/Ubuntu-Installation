#!/usr/bin/env bash

# Pass the "-r" parameter to uninstall the Jitsi suite.
if ["${1}" == "-r"]; then
  apt purge -y jigasi jitsi-meet jitsi-meet-web-config jitsi-meet-web jicofo jitsi-videobridge
  apt purge -y jigasi jitsi-meet jitsi-meet-web-config jitsi-meet-web jicofo jitsi-videobridge
else
  echo 'deb https://download.jitsi.org stable/' >> /etc/apt/sources.list.d/jitsi-stable.list
  wget -qO -  https://download.jitsi.org/jitsi-key.gpg.key | apt-key add -
  apt update && apt -y install jitsi-meet
  echo "NOTE: To install a Let's Encrypt certificate, execute the following:"
  echo "/usr/share/jitsi-meet/scripts/install-letsencrypt-cert.sh"
