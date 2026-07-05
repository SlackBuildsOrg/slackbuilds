ln -sf /usr/share/games/lightyears-1.5.2/lib20k /usr/share/games/lightyears-1.5.2/code

if [ -x /usr/bin/update-desktop-database ]; then
  /usr/bin/update-desktop-database -q usr/share/applications >/dev/null 2>&1
fi
