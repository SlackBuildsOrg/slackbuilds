config() {
  NEW="$1"
  OLD="$(dirname $NEW)/$(basename $NEW .new)"
  # If there's no config file by that name, mv it over:
  if [ ! -r $OLD ]; then
    mv $NEW $OLD
  elif [ "$(cat $OLD | md5sum)" = "$(cat $NEW | md5sum)" ]; then # toss the redundant copy
    rm $NEW
  fi
  # Otherwise, we leave the .new copy for the admin to consider...
}

config etc/zgv.conf.new

if [ -x /usr/bin/install-info ]; then
  /usr/bin/install-info --info-dir=usr/info usr/info/zgv.info.gz 1> /dev/null 2>&1
fi
