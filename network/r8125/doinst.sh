config() {
  NEW="$1"
  OLD="$(dirname $NEW)/$(basename $NEW .new)"
  if [ ! -r $OLD ]; then
    mv $NEW $OLD
  elif [ "$(cat $OLD | md5sum)" = "$(cat $NEW | md5sum)" ]; then
    rm $NEW
  fi
}

config etc/modprobe.d/r8169_blacklist.conf.new

# A good idea whenever kernel modules are added or changed:
if [ -x sbin/depmod ]; then
  chroot . /sbin/depmod -a @KERNEL@ 1> /dev/null 2> /dev/null
fi
