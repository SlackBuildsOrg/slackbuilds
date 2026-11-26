fix_cgroups() {
  CG="cgroup_no_v1=all"

  if [ -f /boot/efi/EFI/Slackware/elilo.conf ]; then
    sed -i "/^[[:space:]]*append=/ { /$CG/! s/\(append=\"[^\"]*\)\"/\1 $CG\"/ }" /boot/efi/EFI/Slackware/elilo.conf
  elif [ -f /etc/lilo.conf ]; then
    sed -i "/^[[:space:]]*append=/ { /$CG/! s/\(append=\"[^\"]*\)\"/\1 $CG\"/ }" /etc/lilo.conf
    [ -x /sbin/lilo ] && [ "$(pwd)" = "/" ] && /sbin/lilo
  elif [ -f /etc/default/grub ]; then
    sed -i "/^[[:space:]]*GRUB_CMDLINE_LINUX_DEFAULT=/ { /$CG/! s/\(GRUB_CMDLINE_LINUX_DEFAULT=\"[^\"]*\)\"/\1 $CG\"/ }" /etc/default/grub
    [ -x /usr/sbin/grub-mkconfig ] && [ "$(pwd)" = "/" ] && /usr/sbin/grub-mkconfig -o /boot/grub/grub.cfg
  else
    echo "No supported bootloader config found." >&2
  fi
}

patch_startup() {
PATCH="/usr/doc/podman-@VERSION@/cgroups2.patch"

if [ -f /etc/rc.d/rc.S ] && [ -f "$PATCH" ]; then
  if patch --dry-run -s -N -p0 /etc/rc.d/rc.S < "$PATCH" >/dev/null 2>&1; then
    patch -s -N --no-backup-if-mismatch -p0 /etc/rc.d/rc.S < "$PATCH"
  fi
fi
}

share_root() {
if [ -f /etc/rc.d/rc.local ]; then
  grep -q "mount --make-rshared /" /etc/rc.d/rc.local || \
    printf '\nmount --make-rshared /\n' >> /etc/rc.d/rc.local
fi
}

fix_cgroups
patch_startup
share_root
