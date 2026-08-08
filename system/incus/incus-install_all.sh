#!/bin/bash

# Set the timezone
NEW_LOCAL_TIME=/usr/share/zoneinfo/Australia/NSW
(cd /etc && ln -sf $NEW_LOCAL_TIME localtime)
date

# Setup slackpkg
#
# Download packages one at a time
sed -i -e 's/DOWNLOAD_ALL=on/DOWNLOAD_ALL=off/' /etc/slackpkg/slackpkg.conf
#
# Blacklist kernel stuff. Should we include kernel-source?
sed -i -e 's/^#kernel-generic/kernel-generic/' \
       -e 's/^#kernel-huge/kernel-huge/' \
       -e 's/^#kernel-modules/kernel-modules/' \
        /etc/slackpkg/blacklist || true

slackpkg -default_answer=yes -batch=on update

export TERSE=0

# Update packages
for series in a ap d e f k kde l n t tcl x xap xfce y ; do
  slackpkg -default_answer=yes -batch=on install "$series"/*

  rm -rf /var/cache/packages/*
done

slackpkg -default_answer=yes -batch=on install-new
slackpkg -default_answer=yes -batch=on upgrade-all
slackpkg -default_answer=yes -batch=on clean-system
