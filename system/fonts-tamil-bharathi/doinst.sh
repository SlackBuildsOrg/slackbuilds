#!/bin/sh

# Update the X font indexes:

if [ -x /usr/bin/mkfontdir ]; then
  ( cd /usr/share/fonts/TTF
    mkfontscale .
    mkfontdir .
  )
fi

[ "$DISPLAY" != "" ] && xset fp rehash 2>/dev/null

if [ -x /usr/bin/fc-cache ]; then
  /usr/bin/fc-cache -f
fi
