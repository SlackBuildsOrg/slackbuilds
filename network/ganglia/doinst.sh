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

config etc/ganglia/gmond.conf.new
preserve_perms etc/rc.d/rc.gmond.new

if [ -e etc/ganglia/gmetad.conf.new ]; then
  config etc/ganglia/gmetad.conf.new
fi

if [ -e etc/rc.d/rc.gmetad.new ]; then
  preserve_perms etc/rc.d/rc.gmetad.new
fi
