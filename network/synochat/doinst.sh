#!/bin/sh

gtk-update-icon-cache -q -t -f usr/share/icons/hicolor
ln -s '/opt/Synology Chat/synochat' '/usr/bin/synochat'
update-desktop-database -q
