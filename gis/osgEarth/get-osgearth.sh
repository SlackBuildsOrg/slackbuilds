#!/bin/sh

# get-osgearth
#
# - clone the source repo
# - checkout the desired tag/branch
# - update submodules
# - pack into a tarball

OSG_TAG_DEFAULT=osgearth-3.8

# We must have a tag to checkout
OSG_TAG=${OSG_TAG:-$1}
if [ -z $OSG_TAG ]; then
  OSG_TAG="${OSG_TAG_DEFAULT}"
fi

set -e

# Clear download area:
rm -rf osgearth ${OSG_TAG}.tar.lz

# Clone repository:
git clone https://github.com/pelicanmapping/osgearth.git
( cd osgearth && \
  git co "$OSG_TAG" && \
  git submodule init && \
  git submodule update
)
( cd osgearth && find . -name ".git*" -exec rm -rf {} \; 2>/dev/null || true )

# Generate tarball
echo "Generating tarball ..."
mv osgearth $OSG_TAG
tar cf $OSG_TAG.tar $OSG_TAG
plzip -9 $OSG_TAG.tar
rm -rf TAG
echo
echo "osgEarth tarball generated as $OSG_TAG.tar.lz"
echo
