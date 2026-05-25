#!/bin/bash

# Setting up permissions for elects's data directories.

PRGNAM=electrs
ELECTRS_UID=386
ELECTRS_GID=386

setfacl -R -m u:$ELECTRS_UID:rwx etc/$PRGNAM
setfacl -R -m u:$ELECTRS_UID:rwx var/lib/$PRGNAM
setfacl -R -m u:$ELECTRS_UID:rwx var/log/$PRGNAM
setfacl -R -m u:$ELECTRS_UID:rwx var/run/$PRGNAM

# handle config.toml.new
config() {
  NEW="$1"
  OLD="$(dirname $NEW)/$(basename $NEW .new)"
  # If there's no config file by that name, mv it over:
  if [ ! -r $OLD ]; then
    mv $NEW $OLD
  elif [ "$(cat $OLD | md5sum)" = "$(cat $NEW | md5sum)" ]; then
    # toss the redundant copy
    rm $NEW
  fi
  # Otherwise, we leave the .new copy for the admin to consider…
}
config etc/$PRGNAM/config.toml.new

