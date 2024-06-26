config() {
    NEW="$1"
    OLD=${NEW%%.new}
    # If there's no config file by that name, mv it over:
    if [ ! -r $OLD ]; then
	mv $NEW $OLD
    elif [ "`cat $OLD | md5sum`" = "`cat $NEW | md5sum`" ]; then
	# toss the redundant copy
        rm $NEW
    fi
    # Otherwise, we leave the .new copy for the admin to consider...
}

config etc/mailfromd/mailfromd.mfl.new
config etc/rc.d/rc.mailfromd.new
