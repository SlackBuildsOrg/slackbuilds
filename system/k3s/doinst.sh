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

config etc/rancher/k3s/k3s.service.env.new

if [ -x /etc/rc.d/rc.k3s ]; then
  if [ ! -f /etc/rancher/k3s/k3s.yaml ]; then
    k3s server \
      --write-kubeconfig /etc/rancher/k3s/k3s.yaml \
      --write-kubeconfig-mode 644 > /dev/null 2>&1 &
  fi
  /etc/rc.d/rc.k3s restart > /dev/null
fi
