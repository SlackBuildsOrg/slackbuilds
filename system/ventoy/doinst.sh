if [ -x /usr/bin/update-desktop-database ]; then
  /usr/bin/update-desktop-database -q usr/share/applications >/dev/null 2>&1
fi

if [ -x /usr/bin/update-mime-database ]; then
  /usr/bin/update-mime-database usr/share/mime >/dev/null 2>&1
fi

if [ -e usr/share/icons/gnome/icon-theme.cache ]; then
  if [ -x /usr/bin/gtk-update-icon-cache ]; then
    /usr/bin/gtk-update-icon-cache -f usr/share/icons/gnome >/dev/null 2>&1
  fi
fi

printf "$(tput setaf 4)  ->$(tput sgr0; tput bold) %s$(tput sgr0)\n" \
'NOTE: You can create persistence images for ventoy with the "ventoy-persistent" command,'
printf "$(tput setaf 4)  ->$(tput sgr0; tput bold) %s$(tput sgr0)\n" \
'      and losslessly expand persistence ".dat" files using "ventoy-extend-persistent",'
printf "$(tput setaf 4)  ->$(tput sgr0; tput bold) %s$(tput sgr0)\n" \
'      which are shortcuts to "/opt/ventoy/CreatePersistentImg.sh" and'
printf "$(tput setaf 4)  ->$(tput sgr0; tput bold) %s$(tput sgr0)\n" \
'      "/opt/ventoy/ExtendPersistentImg.sh", respectively.'
printf "$(tput setaf 4)  ->$(tput sgr0; tput bold) %s$(tput sgr0)\n" \
'      (See https://www.ventoy.net/en/plugin_persistence.html for documentation.)'
