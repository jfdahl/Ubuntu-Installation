#!/usr/bin/env bash
# Depends: Firefox is installed

[ $(which firefox) ] || \
sudo /home/public/bin/install_firefox.sh || \
exit 1

home_page=http://ipinfo.io/

# Setup Profile
ffconfig=${HOME}/.mozilla/firefox
local_profile=${ffconfig}/profile.default
mkdir -p ${local_profile}
local_ext_dir=${ffconfig}/../extensions

# Setup preferences file
global_prefs=/etc/firefox/syspref.js
local_prefs=${local_profile}/prefs.js
touch ${local_prefs}

cat << EOF >> ${ffconfig}/profiles.ini
[General]
StartWithLastProfile=1

[Profile0]
Name=default
IsRelative=1
Path=profile.default
Default=1
EOF

function install_adblock_plus(){
    file_name=addon-1865-latest.xpi
    wget -q -O /tmp/${file_name} https://addons.mozilla.org/firefox/downloads/latest/adblock-plus/${file_name}
    firefox /tmp/${file_name} 2>/dev/null
    rm /tmp/${file_name}
}


function set_pref(){
    echo "user_pref(\"${1}\", ${2});" >> ${local_prefs}
}


function update_pref(){
    sed -i 's|^user_pref\("\${1}\", .*\);$|^user_pref(\"${1}\", ${2});$|' ${local_prefs}
}


function set_local_preferenes(){
    cp ${local_prefs} ${local_prefs}.bak
    set_pref 'beacon.enabled' false
    set_pref 'browser.cache.disk.enable' false
    set_pref 'browser.search.defaultEngineName' "\"DuckDuckGo\""
    set_pref 'browser.startup.homepage' "\"${home_page}\""
    set_pref 'browser.tabs.warnOnClose' false
    set_pref 'browser.toolbarbuttons.introduced.pocket-button' true
    set_pref 'datareporting.healthreport.uploadEnabled' false
    set_pref 'datareporting.policy.dataSubmissionPolicyAcceptedVersion' 2
    set_pref 'network.cookie.cookieBehavior' 3
    set_pref 'privacy.donottrackheader.enabled' true
    set_pref 'privacy.sanitize.migrateFx3Prefs' true
    set_pref 'browser.reader.detectedFirstArticle' true
}

set_local_preferenes
install_adblock_plus
