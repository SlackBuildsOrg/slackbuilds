#!/bin/sh

# fujinet-pc.sh, wrapper for fujinet-pc. Part of the SlackBuilds.org
# fujinet-pc build. Written by B. Watson, released under the WTFPL.
# Based on the run-fujinet script that ships with the fujinet-firmware
# source.

SELF="$( basename $0 )"

SHARE=/usr/share/fujinet-pc
EXE=/usr/libexec/fujinet-pc/fujinet

# The executable doesn't support a --help option, but it does
# show usage when run with an unknown option. Clean up the output
# a bit.
if [ "$1" = "-help" -o "$1" = "--help" -o "$1" = "-h" ]; then
  echo -n "Usage: $( basename $0 ) "
  $EXE --help 2>&1 | grep '^Usage:' | cut -d' ' -f3-
  exit 0
fi

# If the user doesn't have a ~/.fujinet-pc, create one and
# populate it with the default config file and SD contents.
# 20260203 bkw: data/ is a symlink, it never gets written to.
# SD/ is a copy because the user has to be able to write to it,
# same for the config file.
FUJINET_HOME="${FUJINET_HOME:-$HOME/.fujinet-pc}"
if [ ! -e "$FUJINET_HOME" ]; then
  echo "$SELF: $FUJINET_HOME does not exist, populating from $SHARE"
  mkdir -p "$FUJINET_HOME"                  || exit 1
  ln -s $SHARE/data "$FUJINET_HOME"         || exit 1
  cp -a $SHARE/SD "$FUJINET_HOME"           || exit 1
  cp -a $SHARE/fnconfig.ini "$FUJINET_HOME" || exit 1
fi

cd "$FUJINET_HOME" || exit 1

STARTING="Starting"
rc=75

# from sysexits.h
# #define EX_TEMPFAIL     75      /* temp failure; user is invited to retry */
while [ $rc -eq 75 ]; do
  echo "$SELF: $STARTING FujiNet"
  STARTING="Restarting"
  $EXE "$@"
  rc=$?
done

echo "$SELF: FujiNet exited with status $rc"
