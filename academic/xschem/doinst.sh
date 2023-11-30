
if [ -x /usr/bin/update-desktop-database ]; then
  /usr/bin/update-desktop-database -q usr/share/applications >/dev/null 2>&1
fi
ln -s /usr/share/doc/xschem /usr/doc/xschem-3.4.4

