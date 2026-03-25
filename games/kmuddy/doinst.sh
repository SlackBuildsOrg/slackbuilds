#!/bin/sh

if [ -x /usr/bin/update-mime-database ]; then
  /usr/bin/update-mime-database /usr/share/mime &> /dev/null
fi
if [ -x /usr/bin/update-desktop-database ]; then
  /usr/bin/update-desktop-database /usr/share/applications &> /dev/null
fi
if [ -x /usr/bin/gtk-update-icon-cache ]; then
  for theme in /usr/share/icons/*; do
    /usr/bin/gtk-update-icon-cache -q -t -f $theme &> /dev/null
  done
fi
