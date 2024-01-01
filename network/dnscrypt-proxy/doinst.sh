#!/bin/bash

# dnscrypt-proxy writes files to /etc/$PRGNAM after dropping
# privileges. This ensures $DNSCRYPT_USER can write files
# to its config /etc/$PRGNAM, without having to change default
# root:root in slackware /etc/$PRGNAM
#
# This is a workaround, might not be a elegant solution. 

DNSCRYPT_USER=$(cat /usr/doc/dnscrypt-proxy-2.1.5/dnscrypt-proxy.SlackBuild | grep -oP '\${DNSCRYPT_USER:-\K[^}]*')
setfacl -m u:$DNSCRYPT_USER:rwx /etc/dnscrypt-proxy
