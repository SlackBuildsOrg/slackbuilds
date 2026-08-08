#!/bin/bash

if [ "$ARCH" = "i586" -o "$ARCH" = "i686" ]; then
  LIBDIRSUFFIX=""
elif [ "$ARCH" = "x86_64" ]; then
  LIBDIRSUFFIX="64"
fi

rm -vf /usr/lib${LIBDIRSUFFIX}/python3.9/site-packages/cffsubr/tx
rm -rvf /usr/lib${LIBDIRSUFFIX}/python3.9/site-packages/cffsubr


