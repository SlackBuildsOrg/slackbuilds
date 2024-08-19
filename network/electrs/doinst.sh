#!/bin/bash

# ELECTRS writes files to its data directories after
# dropping privileges. This ensures $ELECTRS_USER can write
# files to these directories, without having to change default
# root:root in slackware.
#
# This is a workaround, might not be a elegant solution.

PRGNAM=ELECTRS
ELECTRS_UID=293
ELECTRS_GID=293

chown $ELECTRS_UID:$ELECTRS_GID etc/$PRGNAM/*

setfacl -m u:$ELECTRS_UID:rwx etc/$PRGNAM
setfacl -m u:$ELECTRS_UID:rwx var/run/$PRGNAM
setfacl -m u:$ELECTRS_UID:rwx var/log/$PRGNAM
