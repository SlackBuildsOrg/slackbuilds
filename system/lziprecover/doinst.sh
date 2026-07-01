# 20260701 bkw: this file is used as both doinst.sh and douninst.sh,
# it's not an error.

if [ -x /usr/bin/install-info -a -d usr/info ]; then
  ( cd usr/info
    rm -f dir
    for i in *.info*; do /usr/bin/install-info $i dir 2>/dev/null; done
  )
fi
