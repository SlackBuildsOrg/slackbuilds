#!/bin/bash

if [ "$ARCH" = "i586" -o "$ARCH" = "i686" ]; then
  LIBDIRSUFFIX=""
elif [ "$ARCH" = "x86_64" ]; then
  LIBDIRSUFFIX="64"
fi

( cd /usr/bin
ln -sf /usr/bin/tx /usr/lib${LIBDIRSUFFIX}/python3.9/site-packages/cffsubr
)
