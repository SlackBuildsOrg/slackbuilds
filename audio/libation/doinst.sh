( cd usr/bin ; rm -rf hangover )
( cd usr/bin ; ln -sf /usr/lib/libation/Hangover hangover )
( cd usr/bin ; rm -rf libation )
( cd usr/bin ; ln -sf /usr/lib/libation/Libation libation )
( cd usr/bin ; rm -rf libationcli )
( cd usr/bin ; ln -sf /usr/lib/libation/LibationCli libationcli )

if [ -x /usr/bin/update-desktop-database ]; then
  /usr/bin/update-desktop-database -q usr/share/applications >/dev/null 2>&1
fi


if [ -e usr/share/icons/hicolor/icon-theme.cache ]; then
  if [ -x /usr/bin/gtk-update-icon-cache ]; then
    /usr/bin/gtk-update-icon-cache -f usr/share/icons/hicolor >/dev/null 2>&1
  fi
fi

if [ -e usr/share/glib-2.0/schemas ]; then
  if [ -x /usr/bin/glib-compile-schemas ]; then
    /usr/bin/glib-compile-schemas usr/share/glib-2.0/schemas >/dev/null 2>&1
  fi
fi

