if [ -x usr/bin/update-desktop-database ]; then
  usr/bin/update-desktop-database usr/share/applications >/dev/null 2>&1
fi

if [ -x usr/bin/update-mime-database ]; then
  usr/bin/update-mime-database usr/share/mime >/dev/null 2>&1
fi

# Remove the unused Qt desktop file
if [ -x usr/share/applications/autokey-qt.desktop ]; then
  rm -f usr/share/applications/autokey-qt.desktop
fi

if [ -e usr/share/icons/hicolor/icon-theme.cache ]; then
  if [ -x /usr/bin/gtk-update-icon-cache ]; then
    /usr/bin/gtk-update-icon-cache -f usr/share/icons/hicolor >/dev/null 2>&1
  fi
fi

