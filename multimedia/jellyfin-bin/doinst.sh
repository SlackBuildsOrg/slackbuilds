# FUNCTION:    config()
# DESCRIPTION: Discards identical copies of config and rc.INIT files.
# ARGUMENTS:   A single filename.
# NOTE
# Files should be installed with a .new extension.
# Example: etc/rc.d/rc.myshinynewdaemon.new
# We don't clobber if it's avoidable.
# "slackpkg new-config" is one way that users can list+process .new files.

config() {
  NEW="$1"
  OLD="$(dirname $NEW)/$(basename $NEW .new)"
  # If there's no config file by that name, mv it over:
  if [ ! -r $OLD ]; then
    mv $NEW $OLD
  elif [ "$(cat $OLD | md5sum)" = "$(cat $NEW | md5sum)" ]; then
    # toss the redundant copy
    rm $NEW
  fi
  # Otherwise, we leave the .new copy for the admin to consider...
}

# Does the finished package have config files in etc/?
config etc/default/jellyfin.new
