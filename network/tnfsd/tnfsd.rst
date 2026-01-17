.. RST source for tnfsd(1) man page. Convert with:
..   rst2man.py tnfsd.rst > tnfsd.1

.. |version| replace:: 24.0522.1+20260108_bac37dc
.. |date| date::

=====
tnfsd
=====

---------------------------------
trivial network filesystem daemon
---------------------------------

:Manual section: 1
:Manual group: SlackBuilds.org
:Date: |date|
:Version: |version|

SYNOPSIS
========

tnfsd [**-a**] [**-r**] [**-p** *port*] [**-u** *username* **-g** *group*] **directory** 

DESCRIPTION
===========

TNFS is a simplified Internet file transfer protocol, designed for
simplicity and ease of implementation on small systems, such as 8-bit
computers. It's simpler than NFS, SMB, or FTP. It's similar to TFTP,
but has features TFTP lacks.

**tnfsd** is the server for the TNFS protocol. It listens for clients
on UDP and TCP ports 16384 by default. Although TCP is supported, most
clients use UDP only... maybe *all* clients?

The mandatory **directory** option is the root of the TNFS
filesystem tree. With the **-u** and **-g** options, **tnfsd** will
**chroot**\(2) to this directory.

Even without **chroot**, **tnfsd** will not deliberately allow access
to files outside the *directory*. The **-u**\/**-g** chroot option
is a safety net, in case there's a bug in **tnfsd** that allows such
access (currently, no such bug is known of).

Note that **tnfsd** can be started by a normal user, since it uses an
unprivileged port number. The **-u**\/**-g** options won't work in this case.

**tnfsd** logs various information to standard error. If compiled with
*-DUSAGE_LOG*, the log includes all mount, umount, and file transfer
requests including the client IP addresses.

OPTIONS
=======

**-p**
  Set the port number to listen to for UDP and TCP. Default: *16384*.

**-r**
  Read-only. Attempts to upload, delete, or modify files will fail.

**-a**
  Atari 8-bit mode. Binary files will be wrapped in a bootable **ATR** image.

**-u** *user* **-g** *group*
  Causes **tnfsd** to **chroot** to *directory*, then set its user and
  group IDs to *user* and *group*. Requires **tnfsd** to be started as root.
  If **-u** is used, **-g** is required (and vice versa); it's an error
  to give only one of these options.

**Note:** Older versions of **tnfsd** used the **-c** option to chroot. Scripts
that start **tnfsd** will have to be updated to use **-u** and **-g** instead.

LIMITATIONS
===========

**tnfsd** is designed to be simple, so the following list of
limitations should not be read as complaints or feature requests.

There's no way to limit which hosts may access **tnfsd** using any
mechanism such as **tcpd**\(8), and there's no way to have **tnfsd**
bind to a particular interface (it listens on all of them). Firewall
rules may be used instead, e.g. **iptables**\(8).

There isn't a way to selectively share some subdirectories read-only
with the current **tnfsd** implementation. The **-r** option applies
to the whole tree. However, without **-r**, filesystem permissions can
be used to prevent the daemon from writing to directories you want to
be read-only while allowing writes to other dirs.

COPYRIGHT
=========

See the file /usr/doc/tnfsd-|version|/COPYING for license information.

AUTHORS
=======

tnfsd was written by Dylan Smith.

This man page written for the SlackBuilds.org project
by B. Watson, and is licensed under the WTFPL.

SEE ALSO
========

**tnfs-fuse**\(1), **fujinet-pc**\(1)

/usr/doc/tnfsd-|version|/tnfs-protocol.md
