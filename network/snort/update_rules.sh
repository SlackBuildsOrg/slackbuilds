#!/bin/bash
#=============================================================================
# Sample script to update snort rules, signatures and configurations
# *** USE AT YOUR OWN RISK *** NO GUARANTEES ***
#=============================================================================
# Written by Niels Horn
# Maintained by David Spencer <baildon.research@googlemail.com>
# v2 2015-02-22 dbs
# v3 2026-02-08 Willy Sudiarto Raharjo

CONFDIR=/etc/snort/rules

# Exit on most errors
set -e

if [ -z "$1" ]; then
  echo "Please specify snortrules file:"
  echo "  $0 snort3-community-rules.tar.gz"
  exit 1
fi

# Configuration files
echo "*** Updating configuration files..."
tar -o -xf "$1" snort3-community-rules/snort3-community.rules -O > "$CONFDIR/snort3-community.rules.new"
if [ -e $CONFDIR/snort3-community.rules ]; then
  if [ "$(md5sum <"$CONFDIR/snort3-community.rules")" = "$(md5sum <"$CONFDIR/snort3-community.rules.new")" ]; then
    # nothing new, dump new rules
    rm "$CONFDIR/snort3-community.rules.new"
    echo "No new rules."
  else
    # update the rule with newer version
    mv -f "$CONFDIR/snort3-community.rules.new" "$CONFDIR/snort3-community.rules"
    echo "Rules updated"
  fi
else
  mv -f "$CONFDIR/snort3-community.rules.new" "$CONFDIR/snort3-community.rules"
 echo "Rules Added"
fi
echo "All done."
