if [ -x /usr/bin/install-info ]; then
  /usr/bin/install-info --info-dir=usr/info usr/info/ocp.gz 1> /dev/null 2>&1
fi

if [ -e usr/share/icons/hicolor/icon-theme.cache ]; then
  if [ -x /usr/bin/gtk-update-icon-cache ]; then
    /usr/bin/gtk-update-icon-cache -f usr/share/icons/hicolor >/dev/null 2>&1
  fi
fi
