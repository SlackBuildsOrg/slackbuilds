#!/bin/sh
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

( cd /etc/pulse
if [ -f "client.conf" ]; then
    md5check="$(md5sum client.conf | cut -d' ' -f1)"
    if [ $md5check != "5843366c456d2cd1bc50836d5eedce14" ]; then
        rm -f client.conf .client.conf.old
    fi
fi

if [ -f "daemon.conf" ]; then
    md5check="$(md5sum daemon.conf | cut -d' ' -f1)"
    if [ $md5check != "aa390d407078747795e9c386db1a88c0" ]; then
        rm -f daemon.conf
    fi
fi

if [ -f "default.pa" ]; then
    md5check="$(md5sum default.pa | cut -d' ' -f1)"
    if [ $md5check != "089e0535a9ebbf8447a4e7327d85518c" ]; then
        rm -f default.pa
    fi
fi

if [ -f "system.pa" ]; then
    md5check="$(md5sum system.pa | cut -d' ' -f1)"
    if [ $md5check != "cd146d25d7be2581ac016605363cccbc" ]; then
        rm -f system.pa
    fi
fi )

( cd /etc/xdg/autostart
rm -f pipewire*.desktop )

config etc/pulse/client.conf.new
config etc/pulse/daemon.conf.new
config etc/pulse/default.pa.new
config etc/pulse/system.pa.new
