#!/bin/bash

# dnscrypt-proxy writes files to /etc/$PRGNAM after dropping
# privilege. This ensure $DNSCRYPT_USER can write files
# to its config directory, without having to change default
# owner:group in slackware /etc

DNSCRYPT_USER=$(cat /usr/doc/dnscrypt-proxy-2.1.5/dnscrypt-proxy.SlackBuild | grep -oP '\${DNSCRYPT_USER:-\K[^}]*' )
setfacl -m u:$DNSCRYPT_USER:rwx /etc/dnscrypt-proxy
