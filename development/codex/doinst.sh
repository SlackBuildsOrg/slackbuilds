#!/bin/sh

rm -f /usr/bin/codex
ln -sf /usr/lib64/node_modules/@openai/codex/bin/codex.js /usr/bin/codex
