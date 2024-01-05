#!/bin/bash

# dnscrypt-proxy writes files to its data directories after
# dropping privileges. This ensures $DNSCRYPT_USER can write
# files to these directories, without having to change default
# root:root in slackware.
#
# This is a workaround, might not be a elegant solution.

PRGNAM=dnscrypt-proxy
<<<<<<< HEAD
DNSCRYPT_UID=dnscrypt
DNSCRYPT_GID=dnscrypt

chown $DNSCRYPT_UID:$DNSCRYPT_GID etc/$PRGNAM/*

setfacl -m u:$DNSCRYPT_UID:rwx etc/$PRGNAM
setfacl -m u:$DNSCRYPT_UID:rwx var/run/$PRGNAM
setfacl -m u:$DNSCRYPT_UID:rwx var/log/$PRGNAM
=======
DNSCRYPT_USER=dnscrypt
DNSCRYPT_GROUP=dnscrypt

chown $DNSCRYPT_USER:$DNSCRYPT_GROUP /etc/$PRGNAM/*

setfacl -m u:$DNSCRYPT_USER:rwx /etc/$PRGNAM
setfacl -m u:$DNSCRYPT_USER:rwx /var/run/$PRGNAM
setfacl -m u:$DNSCRYPT_USER:rwx /var/log/$PRGNAM
>>>>>>> 8cc6fa4773 (network/dnscrypt-proxy)
