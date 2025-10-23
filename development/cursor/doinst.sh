#!/bin/sh
if command -v update-desktop-database 1>/dev/null 2>&1 ; then
  update-desktop-database -q usr/share/applications >/dev/null 2>&1
fi
if command -v gtk-update-icon-cache 1>/dev/null 2>&1 ; then
  gtk-update-icon-cache -q -t -f usr/share/icons/hicolor >/dev/null 2>&1
fi
