#!/usr/bin/bash
cd /opt/dooble || exit 1
export DOOBLE_TRANSLATIONS_PATH=/opt/dooble/Translations
export QTWEBENGINE_DICTIONARIES_PATH=/opt/dooble/qtwebengine_dictionaries
exec ./Dooble "$@"
