if [ -x /usr/bin/install-info ]; then
  /usr/bin/install-info --info-dir=usr/info usr/info/sbcl.gz 1> /dev/null 2>&1
  /usr/bin/install-info --info-dir=usr/info usr/info/asdf.gz 1> /dev/null 2>&1
fi
