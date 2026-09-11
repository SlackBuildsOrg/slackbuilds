#!/bin/sh

# Reload udev rules so the Rockchip device node is picked up immediately.
if [ -x /sbin/udevadm ]; then
  /sbin/udevadm control --reload-rules 2>/dev/null
  /sbin/udevadm trigger --subsystem-match=usb 2>/dev/null
fi
