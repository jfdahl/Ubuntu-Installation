#!/bin/bash
script=${0}
now=$(date +%Y%m%d_%H%M)

function installSoftware(){
    echo $now Install ${*} >> $script
    sudo apt-get install ${*}
}

function updateSoftware(){
    echo $now Update Software >> $script
    sudo apt-get update && sudo apt-get upgrade
}

function removeSoftware(){
    echo $now Uninstall ${*} >> $script
    sudo apt-get remove ${*}
    sudo apt-get autoremove && sudo apt-get autoclean
}

function usage() {
printf 'install.sh (-h|-r|-u) [package_name]
        -h = This help message
        -r = Remove Sofware
        -u = Update Software
        default = Install software'
}

case "\${1}" in
"-u" )
    updateSoftware ;;
"-r" )
    shift
    removeSoftware $* ;;
"-h" )
    usage ;;
* )
    installSoftware $* ;;
esac
exit 0

################################################################################
#   Installation history
################################################################################
