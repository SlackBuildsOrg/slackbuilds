#!/bin/bash

########################################################################
# Update a minimal image (as typically obtained from aclemons/slackware)
# to a full Slackware installation. To do this, we need to know:
# - (required   to be passed as $1) name of the container
# - (optionally to be passed as $2) mirror for package download

cd $(dirname $0) ; CWD=$(pwd)

INCUS_INSTALL_SCRIPT=${INCUS_INSTALL_SCRIPT:-incus-install_all.sh}

# Use local timezone
NEW_LOCAL_TIME=${NEW_LOCAL_TIME:-$(readlink /etc/localtime)}
# or use some explicit setting e.g.
#NEW_LOCAL_TIME=/usr/share/zoneinfo/Atlantic/Reykjavik
sed -i -e "/^NEW_LOCAL_TIME=/cNEW_LOCAL_TIME=${NEW_LOCAL_TIME}" $INCUS_INSTALL_SCRIPT

usage () {
  echo "Usage:"
  echo "    $(basename $0) <image_name> [mirror]"
  echo
  echo "For example:"
  echo "    $(basename $0) SL32-150 [mirror]"
}

# $1 is required
if [ $# -lt 1 ]; then
  usage
  exit 1
fi
IMAGE_NAME="$1"

# Does this image exist locally
#
have_image=$(incus list -f csv,noheader "$IMAGE_NAME")
if [[ ! "$have_image" == *"$IMAGE_NAME"* ]]; then
  echo "Can't find image named ${IMAGE_NAME}. Exiting now ..."
  exit 2
fi

# Make the image is running
#
if [[ ! "$have_image" == *"RUNNING"* ]]; then
  echo -n "Starting $IMAGE_NAME ... "
  incus start "$IMAGE_NAME"
  echo
else
  echo "$IMAGE_NAME already running"
fi

# Exit if image can't be started
#
have_image=$(incus list -f csv,noheader "$IMAGE_NAME")
if [[ ! "$have_image" == *"RUNNING"* ]]; then
  echo "Can't start ${IMAGE_NAME}. Exiting now ..."
  exit 2
fi

# Start preparing mirrors file
# - download existing file and comment all entries
#
IMAGE_MIRRORS_FILE=${IMAGE_MIRRORS_FILE:-"$(mktemp -t .image_mirrors_file-XXXXXX)"}
$(incus file pull ${IMAGE_NAME}/etc/slackpkg/mirrors $IMAGE_MIRRORS_FILE)
sed -i -e 's/^[^#]/#&/' $IMAGE_MIRRORS_FILE

# $2 is optional
if [ $# -eq 2 ]; then
  MIRROR_BASE="$2"
else
  # use mirror from image's /etc/slackpkg/mirrors
  MIRROR_BASE=$(incus file pull ${IMAGE_NAME}/etc/slackpkg/mirrors - | tail -1)
fi

#echo "INFO: Updating image $IMAGE_NAME from $MIRROR_BASE"

# Insert preferred timezone file
#
echo "NEW_LOCAL_TIME = $NEW_LOCAL_TIME"
tzdir=$(dirname $NEW_LOCAL_TIME)
incus exec ${IMAGE_NAME} -- mkdir -p $tzdir
incus file push "$NEW_LOCAL_TIME" "${IMAGE_NAME}/${NEW_LOCAL_TIME}"

# Finish mirrors file
# - add chosen entry and push back to image
#
# First try rudimentry architecture check for downloads
# In case of bad exits due to this test, comment out the next 15 lines
image_arch="$(incus info ${IMAGE_NAME} |grep Architecture |cut -d' ' -f2)"
if [ "$image_arch" = "i686" ]; then
  # Don't want "slackware64" in the mirror URL for i686
  if [[ "$MIRROR_BASE" == *"ware64"* ]]; then
	  echo "Bad mirror $MIRROR_BASE for i686"
	  exit 3
  fi
else
  #  Must have "slackware64" in the mirror URL for x86_64
  if [[ "$MIRROR_BASE" != *"ware64"* ]]; then
	  echo "Bad mirror $MIRROR_BASE for x86_64"
	  exit 4
  fi
fi

# Test mirror connectivity
# Try to download a small file which is expected to exist at download site
#
if ! wget -q -O - $MIRROR_BASE/CRYPTO_NOTICE.TXT >/dev/null ; then
  echo "Couldn't download CRYPTO_NOTICE.TXT from ${MIRROR_BASE}. Exiting now ..."
  exit 5
fi

echo $MIRROR_BASE >> $IMAGE_MIRRORS_FILE
cat $IMAGE_MIRRORS_FILE
incus file push "$IMAGE_MIRRORS_FILE" "${IMAGE_NAME}/etc/slackpkg/mirrors"
rm $IMAGE_MIRRORS_FILE


#  Push the installation script to the image; then execute it
incus file push "$INCUS_INSTALL_SCRIPT" "${IMAGE_NAME}/usr/bin/$INCUS_INSTALL_SCRIPT"
incus exec "$IMAGE_NAME" -- /bin/bash /usr/bin/$INCUS_INSTALL_SCRIPT
