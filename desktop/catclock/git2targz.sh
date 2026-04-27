#!/bin/sh
PRGNAM=catclock
CLONE_URL=https://github.com/BarkyTheDog/catclock.git

set -e
GITDIR=$(mktemp -dt ${PRGNAM}.git.XXXXXX)
git clone $CLONE_URL $GITDIR
CWD="$(pwd)"
cd $GITDIR

if [ -n "$1" ]; then
  git reset --hard "$1"
fi

GIT_SHA=$(git rev-parse --short HEAD)
DATE=$(git log --date=format:%Y%m%d --format=%cd | head -1)
VERSION=${DATE}_${GIT_SHA}

rm -rf .git
find . -name .gitignore -delete
cd "$CWD"
rm -rf $PRGNAM-$VERSION $PRGNAM-$VERSION.tar.xz
mv $GITDIR $PRGNAM-$VERSION
tar cvfJ $PRGNAM-$VERSION.tar.xz $PRGNAM-$VERSION

echo
echo "Created tarball: $PRGNAM-$VERSION.tar.xz"
echo "VERSION=$VERSION"
