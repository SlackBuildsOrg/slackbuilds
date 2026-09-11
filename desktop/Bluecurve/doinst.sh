# DESCRIPTION: Updates the GTK icon cache.
if [ -e usr/share/icons/Bluecurve/icon-theme.cache ]; then
  if [ -x /usr/bin/gtk-update-icon-cache ]; then
    /usr/bin/gtk-update-icon-cache -f usr/share/icons/Bluecurve >/dev/null 2>&1
  fi
fi
