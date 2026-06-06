if [ -x /usr/bin/install-info ]; then
  /usr/bin/install-info --info-dir=usr/info usr/info/udunits.info.gz 1> /dev/null 2>&1
  /usr/bin/install-info --info-dir=usr/info usr/info/udunitslib.info.gz 1> /dev/null 2>&1
  /usr/bin/install-info --info-dir=usr/info usr/info/udunitsprog.info.gz 1> /dev/null 2>&1
fi
