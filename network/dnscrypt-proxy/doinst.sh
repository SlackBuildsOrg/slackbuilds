#!/bin/bash

# dnscrypt-proxy writes files to its data directories after
# dropping privileges. This ensures $DNSCRYPT_USER can write
# files to these directories, without having to change default
# root:root in slackware.
#
# This is a workaround, might not be a elegant solution.

PRGNAM=dnscrypt-proxy
DNSCRYPT_USER=dnscrypt
DNSCRYPT_GROUP=dnscrypt

chown $DNSCRYPT_USER:$DNSCRYPT_GROUP /etc/$PRGNAM/*

setfacl -m u:$DNSCRYPT_USER:rwx /etc/$PRGNAM
setfacl -m u:$DNSCRYPT_USER:rwx /var/run/$PRGNAM
setfacl -m u:$DNSCRYPT_USER:rwx /var/log/$PRGNAM
