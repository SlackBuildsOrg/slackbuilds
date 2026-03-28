#!/bin/sh

# We must have a tag to checkout
OBS_TAG=${OBS_TAG:-$1}
if [ -z $OBS_TAG ]; then
  echo "Need a tag/version number. Exiting now ..."
  exit 1
fi

set -e

# Clear download area:
rm -rf obs-studio

# Clone repository:
git clone https://github.com/obsproject/obs-studio.git

( cd obs-studio && \
  git co "$OBS_TAG" && \
  git submodule init && \
  git submodule update
)

( cd obs-studio && find . -name ".git*" -exec rm -rf {} \; 2>/dev/null || true )

# Generate tarball
echo "Generating tarball ..."
mv obs-studio obs-studio-$OBS_TAG
tar cf obs-studio-$OBS_TAG.tar obs-studio-$OBS_TAG
plzip -9 obs-studio-$OBS_TAG.tar
rm -rf obs-studio-$OBS_TAG
echo
echo "obs-studio tarball generated as obs-studio-$OBS_TAG.tar.lz"
echo
