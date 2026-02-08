#!/bin/bash

# Slackware build script for blender-libs

# Copyright 2026 Christoph Willing   Sydney, Australia
# All rights reserved.
#
# Redistribution and use of this script, with or without modification, is
# permitted provided that the following conditions are met:
#
# 1. Redistributions of this script must retain the above copyright
#    notice, this list of conditions and the following disclaimer.
#
#  THIS SOFTWARE IS PROVIDED BY THE AUTHOR "AS IS" AND ANY EXPRESS OR IMPLIED
#  WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF
#  MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED.  IN NO
#  EVENT SHALL THE AUTHOR BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
#  SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,
#  PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS;
#  OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY,
#  WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR
#  OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF
#  ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

# BUILD = 1: Enable building of openimagedenoise
#            by disabling OIDN_DEVICE_HIP in its CMakeLists.txt
# BUILD = 2: rocm-6.4.4 available (like cudatoolkit for AMD)

cd $(dirname $0) ; CWD=$(pwd)

PRGNAM=blender-libs
SRCNAM=blender
VERSION=${VERSION:-5.0.1}
BUILD=${BUILD:-2}
TAG=${TAG:-_SBo}
PKGTYPE=${PKGTYPE:-tgz}

if [ -z "$ARCH" ]; then
  case "$( uname -m )" in
    i?86) ARCH=i586 ;;
    arm*) ARCH=arm ;;
       *) ARCH=$( uname -m ) ;;
  esac
fi

if [ ! -z "${PRINT_PACKAGE_NAME}" ]; then
  echo "$PRGNAM-$VERSION-$ARCH-$BUILD$TAG.$PKGTYPE"
  exit 0
fi

TMP=${TMP:-/tmp/SBo}
OUTPUT=${OUTPUT:-/tmp}

CUDAToolkit_ROOT=${CUDAToolkit_ROOT:-/opt/cuda-12.9}
ROCM_PATH=${ROCM_PATH:-/opt/rocm-6.4.4}

# cudatoolkit is mandatory, rocmtoolkit is optional (although recommended)
[ -d "$CUDAToolkit_ROOT" -a -x "$CUDAToolkit_ROOT"/bin/nvcc ] || {
  echo "Can't proceed without cudatoolkit being installed."
  echo "Please install the cudatoolkit_12 SlackBuild from SBo."
  exit 1
}

export CUDAToolkit_ROOT
export ROCM_PATH
echo "CUDAToolkit_ROOT set to $CUDAToolkit_ROOT, ROCM_PATH set to $ROCM_PATH"
export PATH=${CUDAToolkit_ROOT}/bin:${ROCM_PATH}/bin:${PATH}
echo "PATH = $PATH"

# Ensure updated versions of some system packages are installed
# Slackware 15.0 stock cmake version is 3.21.4 (NOT usable)
# Slackware 15.0 also has version 3.31.8 in testing (usable)
# SBo has cmake-opt with version 3.30.5 (usable)
# Slackware -current has 4.x.x
#REQUIRED_CMAKE_VERSION=3.31.8
REQUIRED_CMAKE_VERSION=3.30.5

# If cmake-opt is installed, ensure its newer cmake is found first
[ -x /opt/cmake-opt/bin/cmake ] && \
  export PATH="/opt/cmake-opt/bin:${PATH}"

installed_cmake_version=$(cmake --version | head -1 |cut -d' ' -f3)
if [ ! "$REQUIRED_CMAKE_VERSION" = "$installed_cmake_version" ]; then
  echo "Wrong cmake version ($installed_cmake_version) detected."
  echo "For Slackware 15.0, install the cmake-opt SlackBuild from SBo."
  exit 2
fi


# Obtain sources
# The user should set SOURCES_CACHE in the environment
# or change the definition here
SOURCES_CACHE=${SOURCES_CACHE:-/var/cache/vmbuilder/$SRCNAM-$VERSION-packages}
echo "SOURCES_CACHE = $SOURCES_CACHE"
. blender-libs.defs
for f in $DOWNLOAD_x86_64 ; do
  echo "Source file: $(basename $f)"
  cp -u $SOURCES_CACHE/$(basename $f) . || \
	wget $f
#  md5sum $(basename $f) |cut -f1 -d' '
done

# rename some source files (those listed in .defs file):
RENAMED_SOURCES=""
cp  pthreads4w-code-v3.0.0.zip pthreads4w-code-3.0.0.zip && RENAMED_SOURCES="pthreads4w-code-3.0.0.zip $RENAMED_SOURCES"
cp  c4298933fe046e3f915977b5a69537a59aac8f47.tar.gz hiprt-c4298933fe046e3f915977b5a69537a59aac8f47.tar.gz && RENAMED_SOURCES="hiprt-c4298933fe046e3f915977b5a69537a59aac8f47.tar.gz $RENAMED_SOURCES"
cp  efd24d75bcbc55620e759f6bf42c45a32abac5f8.tar.gz glslang-efd24d75bcbc55620e759f6bf42c45a32abac5f8.tar.gz && RENAMED_SOURCES="glslang-efd24d75bcbc55620e759f6bf42c45a32abac5f8.tar.gz $RENAMED_SOURCES"
cp  2a611a970fdbc41ac2e3e328802aed9985352dca.tar.gz SPIRV-Headers-2a611a970fdbc41ac2e3e328802aed9985352dca.tar.gz && RENAMED_SOURCES="SPIRV-Headers-2a611a970fdbc41ac2e3e328802aed9985352dca.tar.gz $RENAMED_SOURCES"
cp  33e02568181e3312f49a3cf33df470bf96ef293a.tar.gz SPIRV-Tools-33e02568181e3312f49a3cf33df470bf96ef293a.tar.gz && RENAMED_SOURCES="SPIRV-Tools-33e02568181e3312f49a3cf33df470bf96ef293a.tar.gz $RENAMED_SOURCES"
cp  8a889d3699b3c09ade435641fb034427f3fd12b6.tar.gz parallel-hashmap-8a889d3699b3c09ade435641fb034427f3fd12b6.tar.gz && RENAMED_SOURCES="parallel-hashmap-8a889d3699b3c09ade435641fb034427f3fd12b6.tar.gz $RENAMED_SOURCES"
cp  d03f19a88e42cb98be9604ff24b61190d1e48727.tar.gz unified-runtime-d03f19a88e42cb98be9604ff24b61190d1e48727.tar.gz && RENAMED_SOURCES="unified-runtime-d03f19a88e42cb98be9604ff24b61190d1e48727.tar.gz $RENAMED_SOURCES"
cp  2b2e05e088841c63c0b6fd4c9fb380d8688738d3.tar.gz DPCPP-SPIR-V-Headers-2b2e05e088841c63c0b6fd4c9fb380d8688738d3.tar.gz && RENAMED_SOURCES="DPCPP-SPIR-V-Headers-2b2e05e088841c63c0b6fd4c9fb380d8688738d3.tar.gz $RENAMED_SOURCES"
cp  3ba9abdfdc2e0430fcc2fd8993cad31945b6a02b.tar.gz emhash-3ba9abdfdc2e0430fcc2fd8993cad31945b6a02b.tar.gz && RENAMED_SOURCES="emhash-3ba9abdfdc2e0430fcc2fd8993cad31945b6a02b.tar.gz $RENAMED_SOURCES"
cp  804b6f040503c47148bee535230070da6b857ae4.tar.gz icdloader-804b6f040503c47148bee535230070da6b857ae4.tar.gz && RENAMED_SOURCES="icdloader-804b6f040503c47148bee535230070da6b857ae4.tar.gz $RENAMED_SOURCES"
cp  542d7a8f65ecfd88b38de35d8b10aa67b36b33b2.tar.gz opencl_headers-542d7a8f65ecfd88b38de35d8b10aa67b36b33b2.tar.gz && RENAMED_SOURCES="opencl_headers-542d7a8f65ecfd88b38de35d8b10aa67b36b33b2.tar.gz $RENAMED_SOURCES"
cp  4e51b2467104a257c22788e343dafbdde72e28bb.tar.gz vc-intrinsics-4e51b2467104a257c22788e343dafbdde72e28bb.tar.gz && RENAMED_SOURCES="vc-intrinsics-4e51b2467104a257c22788e343dafbdde72e28bb.tar.gz $RENAMED_SOURCES"
cp  05e047c0932d5043ddff5e4058a3afca8e0943aa.tar.gz DPCPP-05e047c0932d5043ddff5e4058a3afca8e0943aa.tar.gz && RENAMED_SOURCES="DPCPP-05e047c0932d5043ddff5e4058a3afca8e0943aa.tar.gz $RENAMED_SOURCES"
cp  227cc413fb2d50b2a10073087be96b59d5364aea.tar.gz sse2neon-227cc413fb2d50b2a10073087be96b59d5364aea.tar.gz && RENAMED_SOURCES="sse2neon-227cc413fb2d50b2a10073087be96b59d5364aea.tar.gz $RENAMED_SOURCES"
cp  3cf6c1e53037eb9e198860365712e1bafb22f7c6.tar.gz x265-3cf6c1e53037eb9e198860365712e1bafb22f7c6.tar.gz && RENAMED_SOURCES="x265-3cf6c1e53037eb9e198860365712e1bafb22f7c6.tar.gz $RENAMED_SOURCES"

set -e

mkdir -p $TMP $OUTPUT
cd $TMP
rm -rf $SRCNAM-$VERSION
rm -rf build_linux
echo "Unpacking $SRCNAM-$VERSION.tar.xz"
tar xf $CWD/$SRCNAM-$VERSION.tar.xz
cd $SRCNAM-$VERSION
chown -R root:root .
find -L . \
 \( -perm 777 -o -perm 775 -o -perm 750 -o -perm 711 -o -perm 555 \
  -o -perm 511 \) -exec chmod 755 {} \; -o \
 \( -perm 666 -o -perm 664 -o -perm 640 -o -perm 600 -o -perm 444 \
  -o -perm 440 -o -perm 400 \) -exec chmod 644 {} \;

# Disable building openimagedenoise if hipcc not available
#
[ -x "$ROCM_PATH"/bin/hipcc ] || \
  sed -i -e 's/DOIDN_DEVICE_HIP=ON/DOIDN_DEVICE_HIP=OFF/' \
  build_files/build_environment/cmake/openimagedenoise.cmake


# Copy source files to where blender expects them
# (where make deps would download them to)
#
mkdir -p $TMP/build_linux/deps_x64/packages
cp $CWD/*.tar.?z*  $CWD/*.zip  $TMP/build_linux/deps_x64/packages/
for rs in $RENAMED_SOURCES ; do
  #echo $rs
  cp $CWD/$rs $TMP/build_linux/deps_x64/packages/
done

rm -f $OUTPUT/$PRGNAM-$VERSION.tar*
make deps

( cd lib && {
  echo "Generating tarball ..."
  tar cf $OUTPUT/$PRGNAM-$VERSION.$BUILD.tar linux_x64

  echo "Compressing tarball ..."
  plzip -9 $OUTPUT/$PRGNAM-$VERSION.$BUILD.tar
})
echo "Result tarball is at $OUTPUT/$PRGNAM-$VERSION.$BUILD.tar.lz"
ls -l $OUTPUT/$PRGNAM-$VERSION.$BUILD.tar.lz


# Some cleanup
echo "Cleaning up ..."
if [ -d $SOURCES_CACHE ]; then
  for f in $DOWNLOAD_x86_64 ; do
    mv $CWD/$(basename $f) $SOURCES_CACHE
  done
else
  for f in $DOWNLOAD_x86_64 ; do
    rm -f $CWD/$(basename $f)
  done
fi
# Remove renamed files
for rs in $RENAMED_SOURCES ; do
  #echo $rs
  rm -f $CWD/$rs
done

