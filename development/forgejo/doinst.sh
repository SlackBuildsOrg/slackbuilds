config() {
  NEW="$1"
  OLD="$(dirname "$NEW")/$(basename "$NEW" .new)"

  if [ ! -r "$OLD" ]; then
    mv "$NEW" "$OLD"
  elif [ "$(cat "$OLD" | md5sum)" = "$(cat "$NEW" | md5sum)" ]; then
    rm "$NEW"
  fi
}

config etc/forgejo/app.ini.new
config etc/forgejo/app.ini.mariadb.new
config etc/rc.d/rc.forgejo.new
