if [ -x /usr/bin/install-info ]; then
  /usr/bin/install-info --info-dir=usr/info usr/info/global.info.gz 1> /dev/null 2>&1
fi
