#!/bin/sh

# Create source tarball from git repo, with generated version number.

# Special weirdness here, because of upstream's use of cmake's
# FetchContent. Dunno why they didn't just use a git submodule...

# Takes one optional argument, which is the commit or tag to create a
# tarball of. With no arg, HEAD is used.

# Version number example: 0.0.1+20200227_ad7ec17

# Notes:

# Do not use this if you're packaging a release.

# This script doesn't need to be run as root. It does need to be able
# to write to the current directory it's run from.

# Running this script twice for the same commit will NOT give identical
# tarballs, even if the contents are identical. This is because tar
# includes the current time in a newly-created tarball (plus there may
# be other git-related reasons).

# Once you've generated a tarball, you'll still need a place to host it.
# Ask on the mailing list, if you don't have your own web server to
# play with.

## Config:
# Github project and user names:
PRGNAM=qzdl
GITUSER=qbasicer

# For github projects, you can use this unmodified:
CLONE_URL=https://github.com/$GITUSER/$PRGNAM.git

# For non-github projects, you might not need GITUSER, in which case
# just omit it from the script.

## End of config.

set -e

GITDIR=$( mktemp -dt $PRGNAM.git.XXXXXX )
rm -rf $GITDIR
git clone $CLONE_URL $GITDIR

CWD="$( pwd )"
cd $GITDIR

if [ "$1" != "" ]; then
  git reset --hard "$1" || exit 1
fi

GIT_SHA=$( git rev-parse --short HEAD )

DATE=$( git log --date=format:%Y%m%d --format=%cd | head -1 )

VERTAG=$( git tag -l | tail -1 | sed 's,^v,,' )

VERSION=${VERTAG}+${DATE}_${GIT_SHA}

# FetchContent stuff
mkdir -p build
cd build
cmake ..
cd -
mv build/_deps .keepme
rm -rf build
mkdir -p build
mv .keepme build/_deps

rm -rf .git
find . -name .gitignore -print0 | xargs -0 rm -f

cd "$CWD"
rm -rf $PRGNAM-$VERSION $PRGNAM-$VERSION.tar.xz
mv $GITDIR $PRGNAM-$VERSION
tar cvfJ $PRGNAM-$VERSION.tar.xz $PRGNAM-$VERSION

echo
echo "Created tarball: $PRGNAM-$VERSION.tar.xz"
echo "VERSION=\"$VERSION\""
echo "MD5SUM=\"$( md5sum $PRGNAM-$VERSION.tar.xz | cut -d' ' -f1 )\""
