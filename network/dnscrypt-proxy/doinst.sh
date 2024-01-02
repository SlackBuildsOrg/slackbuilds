#!/bin/bash

# dnscrypt-proxy writes files to its data directories after 
# dropping privileges. This ensures $DNSCRYPT_USER can write 
# files to these directories, without having to change default
# root:root in slackware.
#
# This is a workaround, might not be a elegant solution. 

PRGNAM=dnscrypt-proxy
DNSCRYPT_USER=$(cat /usr/doc/dnscrypt-proxy-2.1.5/dnscrypt-proxy.SlackBuild | grep -oP '\${DNSCRYPT_USER:-\K[^}]*')
DNSCRYPT_GROUP=$(cat /usr/doc/dnscrypt-proxy-2.1.5/dnscrypt-proxy.SlackBuild | grep -oP '\${DNSCRYPT_GROUP:-\K[^}]*')

chown $DNSCRYPT_USER:$DNSCRYPT_GROUP /etc/$PRGNAM/*

setfacl -m u:$DNSCRYPT_USER:rwx /etc/$PRGNAM
setfacl -m u:$DNSCRYPT_USER:rwx /var/run/$PRGNAM
setfacl -m u:$DNSCRYPT_USER:rwx /var/log/$PRGNAM
