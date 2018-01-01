#!/usr/bin/env bash

[ -f /usr/bin/terminator ] || sudo apt install -y terminator || exit 1

config_file_location=${HOME}/.config/terminator
mkdir -p ${config_file_location}

cat << EOF >> ${config_file_location}/config
[global_config]
[keybindings]
[profiles]
  [[default]]
    login_shell = True
    use_system_font = False
    font = DejaVu Sans Mono 12
    show_titlebar = False
[layouts]
  [[default]]
    [[[child1]]]
      type = Terminal
      parent = window0
    [[[window0]]]
      type = Window
      parent = ""
[plugins]
EOF
