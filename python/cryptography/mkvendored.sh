#!/bin/bash

# Create $PRGNAM-vendored-sources-$VERSION-$VSBUILD.tar.xz
# Requires network access, but does not require root privilege.
# Requires that $PRGNAM's REQUIRES need to be installed first (rust-opt)
# and cargo-vendor-filterer installed to include just the linux deps
#
# Expects to be run within a slackbuild dir with the source archive
# already downloaded.
#
# Variables to use in your SlackBuild:
# VSBUILD         # same use as BUILD but for vendored sources
# VSDIR=/sub/dir/ # (optional) alternate location in src for vendor dir
#
# Vendors sources for the following targets
# i686-unknown-linux-gnu
# x86_64-unknown-linux-gnu
# arm-unknown-linux-gnueabihf
# aarch64-unknown-linux-gnu

INFO="$( echo *.info )"
if [ ! -e "$INFO" ]; then
  echo "No (or multiple) .info file in current dir" 1>&2
  exit 1
fi

SBUILD="$( echo *.SlackBuild )"
if [ ! -e "$SBUILD" ]; then
  echo "No (or multiple) .SlackBuild file in current dir" 1>&2
  exit 1
fi

CWD=$(pwd)
source ./$INFO

INFOERR="variable not set, are you sure you have a valid *.info file?"
echo ${PRGNAM:?$INFOERR}
echo VERSION=${VERSION:?$INFOERR}

set -e
WORKDIR=$( mktemp -d )
cd $WORKDIR

# don't depend on user's ~/.cargo
mkdir -p cargohome
export CARGO_HOME=$(pwd)/cargohome

egrep "^BUILD=|^VSBUILD=|^VSDIR=|^SRCNAM=" $CWD/$SBUILD > sbvars
source ./sbvars

# if no SRCNAM in slackbuild set to PRGNAM
SRCNAM=${SRCNAM:-$PRGNAM}

tar xvf $CWD/$SRCNAM-$VERSION.tar.gz
cd $SRCNAM-$VERSION/$VSDIR || exit 1

if [ ! -e "Cargo.toml" ]; then
  echo "No Cargo.toml file in $SRCNAM-$VERSION dir" 1>&2
  exit 1
elif [ -e "$CWD/Cargo-toml.patch" ]; then
  echo "INFO: Applying Cargo.toml patch"
  patch -Np1 < $CWD/Cargo-toml.patch
fi

if [ -z "$ARCH" ]; then
  case "$( uname -m )" in
    i?86) ARCH=i686 ;;
    arm*) ARCH=arm ;;
       *) ARCH=$( uname -m ) ;;
  esac
fi

if [ "$ARCH" = "i586" ]; then
  SLKCFLAGS="-O2 -march=i586 -mtune=i686"
  LIBDIRSUFFIX=""
elif [ "$ARCH" = "i686" ]; then
  SLKCFLAGS="-O2 -march=i686 -mtune=i686"
  LIBDIRSUFFIX=""
elif [ "$ARCH" = "x86_64" ]; then
  SLKCFLAGS="-O2 -fPIC"
  LIBDIRSUFFIX="64"
elif [ "$ARCH" = "aarch64" ]; then
  SLKCFLAGS="-O2 -fPIC"
  LIBDIRSUFFIX="64"
else
  SLKCFLAGS="-O2"
  LIBDIRSUFFIX=""
fi

# check if rust-opt is installed or in current, default cargo from rust is enough
if [[ ! -d /opt/rust/bin && ! -f /usr/bin/cargo ]]; then
  echo "ERROR: The rust-opt slackbuild is required to be installed"
  exit 1
else
  export PATH="/opt/rust/bin:$PATH"
  if [ -z "$LD_LIBRARY_PATH" ]; then
    export LD_LIBRARY_PATH="/opt/rust/lib$LIBDIRSUFFIX"
  else
    export LD_LIBRARY_PATH="/opt/rust/lib$LIBDIRSUFFIX:$LD_LIBRARY_PATH"
  fi
fi

# Configure cargo-vendor-filterer
  cat << EOF >> Cargo.toml
[package.metadata.vendor-filter]
platforms = ["x86_64-unknown-linux-gnu", "i686-unknown-linux-gnu", "aarch64-unknown-linux-gnu", "arm-unknown-linux-gnueabihf"]
all-features = true
exclude-crate-paths = [
  { name = "openssl-src", exclude = "openssl" },
]
EOF

if [ -f /usr/bin/cargo-vendor-filterer ]; then
  echo "INFO: Creating filtered vendor libs tarball..."
  /usr/bin/cargo-vendor-filterer
else
  echo "WARNING: Creating unfiltered vendor libs tarball!"
  cargo vendor
fi

# build would fail if the .a files were removed
#find vendor -type f -a -name \*.a -print0 | xargs -0 rm -f

mkdir -p .cargo
  cat <<EOF >.cargo/config.toml
[source.crates-io]
replace-with = "vendored-sources"

[source.vendored-sources]
directory = "vendor"
EOF
cd -

cd $WORKDIR
tar cvfJ $CWD/$SRCNAM-vendored-sources-$VERSION-$VSBUILD.tar.xz \
         $SRCNAM-$VERSION/$VSDIR/{vendor,.cargo}
md5sum $CWD/$SRCNAM-vendored-sources-$VERSION-$VSBUILD.tar.xz
cd $CWD
rm -rf $WORKDIR
