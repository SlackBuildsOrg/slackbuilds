# Patched by Peter Christy <pete.christy.uk@gmail.com>

# update configuration and shared library cache for linker to find .so files
echo "/usr/lib64/nordvpn" > /etc/ld.so.conf.d/nordvpn.conf
# NOTE: We found some really strange behavior with `ldconfig` cache refresh here.
# On .deb systems, using just `ldconfig` causes the nordvpnd daemon to fail on
# the first start with error that .so are missing. On restart, it's working again.
# Adding ANY flag to `ldconfig` (even the one we added on our own which does
# literally nothing) fixes the issue.
ldconfig -v > /dev/null 2>&1

if [ -x /usr/bin/update-desktop-database ]; then
  /usr/bin/update-desktop-database -q usr/share/applications >/dev/null 2>&1
fi

if [ -x /usr/bin/update-mime-database ]; then
  /usr/bin/update-mime-database usr/share/mime >/dev/null 2>&1
fi

if [ -e usr/share/icons/hicolor/icon-theme.cache ]; then
  if [ -x /usr/bin/gtk-update-icon-cache ]; then
    /usr/bin/gtk-update-icon-cache -f usr/share/icons/hicolor >/dev/null 2>&1
  fi
fi

if [ -x /etc/rc.d/rc.nordvpn ]; then
    /etc/rc.d/rc.nordvpn restart > /dev/null
fi
