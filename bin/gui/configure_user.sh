#!/usr/bin/env bash

[ -d ~/bin ] || ln -s /user/public/bin ${HOME}/bin
cd ${HOME}/bin
cat << EOF >> ${HOME}/.profile

[ -f ~/bin/env.sh ] || . ~/bin/env.sh

EOF

#Configure Thunar
xfconf-query --channel thunar --property /misc-full-path-in-title --create --type bool --set true
xfconf-query --channel thunar --property /default-view --create --type string --set ThunarDetailsView
xfconf-query --channel thunar --property /last-side-pane --create --type string --set ThunarTreePane
xfconf-query --channel thunar --property /last-details-view-visible-columns --create --type string --set THUNAR_COLUMN_DATE_MODIFIED,THUNAR_COLUMN_GROUP,THUNAR_COLUMN_NAME,THUNAR_COLUMN_OWNER,THUNAR_COLUMN_PERMISSIONS,THUNAR_COLUMN_SIZE,THUNAR_COLUMN_TYPE
xfconf-query --channel thunar --property /last-details-view-column-order --create --type string --set THUNAR_COLUMN_NAME,THUNAR_COLUMN_SIZE,THUNAR_COLUMN_TYPE,THUNAR_COLUMN_DATE_MODIFIED,THUNAR_COLUMN_OWNER,THUNAR_COLUMN_GROUP,THUNAR_COLUMN_PERMISSIONS,THUNAR_COLUMN_DATE_ACCESSED,THUNAR_COLUMN_MIME_TYPE
xfconf-query --channel thunar --property /last-details-view-column-widths --create --type string --set 50,136,77,50,204,80,122,83,153

#Configure desktop
xfconf-query --channel xfce4-desktop --property /backdrop/screen0/monitor0/workspace0/image-style --type int --set 0
xfconf-query --channel xfce4-desktop --property /backdrop/screen0/monitor0/workspace1/image-style --type int --set 0
xfconf-query --channel xfce4-desktop --property /backdrop/screen0/monitor0/workspace2/image-style --type int --set 0
xfconf-query --channel xfce4-desktop --property /backdrop/screen0/monitor0/workspace3/image-style --type int --set 0
xfconf-query --channel xfce4-desktop --property /desktop-icons/file-icons/show-filesystem --create --type bool --set false
xfconf-query --channel xfce4-desktop --property /desktop-icons/file-icons/show-home --create --type bool --set false
xfconf-query --channel xfce4-desktop --property /desktop-icons/file-icons/show-trash --create --type bool --set false

#Configure mousepad
dconf write /org/xfce/mousepad/preferences/view/indent-width 4
dconf write /org/xfce/mousepad/preferences/view/highlight-current-line true
dconf write /org/xfce/mousepad/preferences/view/show-right-margin true
dconf write /org/xfce/mousepad/preferences/view/show-line-numbers true
dconf write /org/xfce/mousepad/preferences/view/insert-spaces true
dconf write /org/xfce/mousepad/preferences/view/match-braces true
dconf write /org/xfce/mousepad/preferences/view/indent-on-tab true
dconf write /org/xfce/mousepad/preferences/view/right-margin-position 80
dconf write /org/xfce/mousepad/preferences/view/tab-width 4
dconf write /org/xfce/mousepad/preferences/view/auto-indent true
dconf write /org/xfce/mousepad/preferences/window/path-in-title true
dconf write /org/xfce/mousepad/preferences/window/statusbar-visible true

#Configure xfce4-terminal
terminal_config=~/.config/xfce4/terminal/terminalrc
mkdir -p ~/.config/xfce4/terminal && echo "[Configuration]" > $terminal_config
cat >> $terminal_config << EOF
CommandLoginShell=TRUE
FontName=DejaVu Sans Mono 12
MiscSlimTabs=TRUE
MiscMenubarDefault=FALSE
MiscConfirmClose=TRUE
EOF


# TODO:
# Configure the panel
cat << EOF > ~/.config/xfce4/xfconf/xfce-perchannel-xml/xfce4-panel.xml
<?xml version="1.0" encoding="UTF-8"?>

<channel name="xfce4-panel" version="1.0">
  <property name="configver" type="int" value="2"/>
  <property name="panels" type="array">
    <value type="int" value="1"/>
    <property name="panel-1" type="empty">
      <property name="position" type="string" value="p=6;x=96;y=24"/>
      <property name="size" type="uint" value="35"/>
      <property name="length" type="uint" value="100"/>
      <property name="position-locked" type="bool" value="true"/>
      <property name="plugin-ids" type="array">
        <value type="int" value="1"/>
        <value type="int" value="2"/>
        <value type="int" value="3"/>
        <value type="int" value="4"/>
        <value type="int" value="5"/>
        <value type="int" value="6"/>
        <value type="int" value="7"/>
        <value type="int" value="8"/>
        <value type="int" value="9"/>
        <value type="int" value="10"/>
        <value type="int" value="11"/>
        <value type="int" value="12"/>
        <value type="int" value="13"/>
      </property>
    </property>
  </property>
  <property name="plugins" type="empty">
    <property name="plugin-1" type="string" value="whiskermenu"/>
    <property name="plugin-2" type="string" value="directorymenu">
      <property name="base-directory" type="string" value="/home/user"/>
      <property name="file-pattern" type="string" value="*"/>
      <property name="icon-name" type="string" value="user-home"/>
    </property>
    <property name="plugin-3" type="string" value="tasklist"/>
    <property name="plugin-4" type="string" value="separator">
      <property name="expand" type="bool" value="true"/>
    </property>
    <property name="plugin-5" type="string" value="systray"/>
    <property name="plugin-6" type="string" value="pulseaudio">
      <property name="enable-keyboard-shortcuts" type="bool" value="true"/>
    </property>
    <property name="plugin-7" type="string" value="netload"/>
    <property name="plugin-8" type="string" value="clock">
      <property name="timezone" type="string" value="US/Central"/>
      <property name="digital-format" type="string" value=" | %r | "/>
    </property>
    <property name="plugin-9" type="string" value="actions">
      <property name="items" type="array">
        <value type="string" value="+lock-screen"/>
        <value type="string" value="-switch-user"/>
        <value type="string" value="+separator"/>
        <value type="string" value="-suspend"/>
        <value type="string" value="-hibernate"/>
        <value type="string" value="-separator"/>
        <value type="string" value="+shutdown"/>
        <value type="string" value="+restart"/>
        <value type="string" value="+separator"/>
        <value type="string" value="+logout"/>
        <value type="string" value="-logout-dialog"/>
      </property>
      <property name="ask-confirmation" type="bool" value="false"/>
    </property>
  </property>
</channel>
EOF
