# DESCRIPTION: Updates the system desktop database.
# Does the finished package have a .desktop file in usr/share/applications/?
if [ -x /usr/bin/update-desktop-database ]; then
  /usr/bin/update-desktop-database -q usr/share/applications >/dev/null 2>&1
fi

# DESCRIPTION: Updates the system mime database.
# Does the finished package have files in usr/share/mime/?
if [ -x /usr/bin/update-mime-database ]; then
  /usr/bin/update-mime-database usr/share/mime >/dev/null 2>&1
fi

# DESCRIPTION: Updates the GTK icon cache.
# Does the finished package have files in usr/share/icons/hicolor/?
# If other icon themes are installed, then add to/modify this as needed
if [ -e usr/share/icons/hicolor/icon-theme.cache ]; then
  if [ -x /usr/bin/gtk-update-icon-cache ]; then
    /usr/bin/gtk-update-icon-cache -f usr/share/icons/hicolor >/dev/null 2>&1
  fi
fi
