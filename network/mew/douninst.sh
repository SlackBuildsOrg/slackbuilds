if [ -x /usr/bin/install-info ]; then
  /usr/bin/install-info --delete --info-dir=usr/info usr/info/mew.info.gz 1> /dev/null 2>&1
fi
