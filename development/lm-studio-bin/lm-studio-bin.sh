#!/bin/bash

#LD_LIBRARY_PATH=/opt/lm-studio-bin:$LD_LIBRARY_PATH
env -i DISPLAY=$DISPLAY XAUTHORITY=$XAUTHORITY XDG_CURRENT_DESKTOP=GNOME /opt/LM-Studio-*.AppImage
#--no-sandbox
