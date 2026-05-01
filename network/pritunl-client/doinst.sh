config() {
  NEW="$1"
  OLD="$(dirname $NEW)/$(basename $NEW .new)"
  # If there's no config file by that name, mv it over:
  if [ ! -r $OLD ]; then
    mv $NEW $OLD
  elif [ "$(cat $OLD | md5sum)" = "$(cat $NEW | md5sum)" ]; then
    # toss the redundant copy
    rm $NEW
  fi
  # Otherwise, we leave the .new copy for the admin to consider...
}

preserve_perms() {
  NEW="$1"
  OLD="$(dirname $NEW)/$(basename $NEW .new)"
  if [ -e $OLD ]; then
    cp -a $OLD ${NEW}.incoming
    cat $NEW > ${NEW}.incoming
    mv ${NEW}.incoming $NEW
  fi
  config $NEW
}

preserve_perms etc/rc.d/rc.pritunl-client.new
config etc/logrotate.d/pritunl-client.new

chmod 0755 /usr/lib/pritunl_client_electron >/dev/null 2>&1

if [ -e /etc/rc.d/rc.pritunl-client ]; then
  chmod 0755 /etc/rc.d/rc.pritunl-client
fi

ln -s /usr/lib64/pritunl_client_electron/Pritunl ${PKG}/usr/bin/pritunl-client-electron

if [ -e usr/share/icons/hicolor/icon-theme.cache ]; then
  if [ -x /usr/bin/gtk-update-icon-cache ]; then
    /usr/bin/gtk-update-icon-cache usr/share/icons/hicolor >/dev/null 2>&1
  fi
fi

if [ -x /usr/bin/xdg-icon-resource ]; then
  /usr/bin/xdg-icon-resource --theme hicolor >/dev/null 2>&1
fi

if [ -x /usr/bin/update-desktop-database ]; then
  /usr/bin/update-desktop-database -q usr/share/applications >/dev/null 2>&1
fi

# Update rc.local so that pritunl-client service will be started on boot:
if ! grep "rc.pritunl-client" etc/rc.d/rc.local 1>/dev/null 2>&1 ; then
  cat <<_EOM_ >> etc/rc.d/rc.local

if [ -x /etc/rc.d/rc.pritunl-client ]; then
  # Start pritunl-client service:
  echo "Starting pritunl-client service:    /etc/rc.d/rc.pritunl-client start"
  /etc/rc.d/rc.pritunl-client start
fi
_EOM_
fi

# Update rc.local_shutdown so that pritunl-client service will be stopped:
if ! grep "rc.pritunl-client" etc/rc.d/rc.local_shutdown 1>/dev/null 2>&1 ; then
  cat <<_EOM2_ >> etc/rc.d/rc.local_shutdown

if [ -x /etc/rc.d/rc.pritunl-client ]; then
  # Stop pritunl-client service:
  echo "Stopping pritunl-client service:    /etc/rc.d/rc.pritunl-client stop"
  /etc/rc.d/rc.pritunl-client stop
fi
_EOM2_
fi
