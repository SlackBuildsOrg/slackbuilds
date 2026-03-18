#!/bin/sh

if [ -x /usr/bin/update-desktop-database ]; then
  /usr/bin/update-desktop-database -q usr/share/applications >/dev/null 2>&1
fi

if [ -e usr/share/icons/hicolor/icon-theme.cache ]; then
  if [ -x /usr/bin/gtk-update-icon-cache ]; then
    /usr/bin/gtk-update-icon-cache usr/share/icons/hicolor >/dev/null 2>&1
  fi
fi



config() {
  NEW="$1"
  OLD="$(echo $NEW | sed 's/\.new$//')"

  if [ ! -r $OLD ]; then
    mv $NEW $OLD
  elif [ "$(md5sum < $OLD)" = "$(md5sum < $NEW)" ]; then
    rm $NEW
  fi
}

config etc/glance/glance.yml.new
