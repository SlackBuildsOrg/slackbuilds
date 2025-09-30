#!/bin/sh

MACHINE=$(uname -m)

if [ "$MACHINE" = "x86_64" ] || [ "$MACHINE" = "aarch64" ]; then
    LIBDIRSUFFIX="64"
else
    LIBDIRSUFFIX=""
fi

rm -f /usr/bin/claude
ln -sf /usr/lib"$LIBDIRSUFFIX"/node_modules/@anthropic-ai/claude-code/cli.js /usr/bin/claude
