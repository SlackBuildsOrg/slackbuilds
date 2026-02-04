.. RST source for tnfs-client(1) man page. Convert with:
..   rst2man.py tnfs-client.rst > tnfs-client.1

.. |version| replace:: 20240707_3b99907
.. |date| date::

===========
tnfs-client
===========

---------------------------------
trivial network filesystem client
---------------------------------

:Manual section: 1
:Manual group: SlackBuilds.org
:Date: |date|
:Version: |version|

SYNOPSIS
========

**tnfs-client** [**--udp** | **--tcp**] [*host* [*port*]]

DESCRIPTION
===========

TNFS is a simplified Internet file transfer protocol, designed for
simplicity and ease of implementation on small systems, such as 8-bit
computers. It's simpler than NFS, SMB, or FTP. It's similar to TFTP,
but has features TFTP lacks.

**tnfs-client** is a simple client for the TNFS protocol. It uses TCP
port 16384 by default (standard for TNFS), and falls back to UDP if it
can't connect via TCP.

**tnfs-client** doesn't mount the TNFS share as a directory (see
**tnfs-fuse**\(1) for that). It has a textmode user interface similar
to **ftp**\(1).

If **host** is omitted, the default host is *fujinet.online*. If
**port** is omitted, the default port is *16384*.

OPTIONS
=======

--tcp
  Connect via TCP. This option is redundant since TCP is the default already.

--udp
  Connect via UDP. If the server you're connecting to is known not
  to support TCP (e.g. **vexed4.alioth.net** as of this writing),
  this allows faster connection (it doesn't try and fail to connect
  via TCP before trying UDP).

COMMANDS
========

The client supports these commands:

**ls** [*-l*] [*-x*] [*remote-path*]
  List contents of a directory (default is current dir). With *-l*,
  show details. With *-x*, show extended attributes (creation and
  modification timestamps).

**l** [*remote-path*]
  Alias for **ls -l**.

**lx** [*remote-path*]
  Alias for **ls -x**.

**dir** [*-l*] [*-x*] [*remote-path*]
  Synonym for **ls**.

**cd** *remote-path*
  Change working directory on server to *remote-path*.

**lcd** *local-path*
  Change local working directory to *local-path*.

**pwd**
  Print current working directory on server.

**get** *remote-filename* [*local-filename*]
  Download a file.

**put** *local-filename* [*remote-filename*]
  Upload a file.

**cat** *remote-filename*
  Download and print a file to standard output.

**dump** *remote-filename*
  Download and print a file to standard output as hex.

**rm** *remote-filename*
  Delete a file from the server.

**mkdir** *remote-path*
  Create a directory.

**rmdir** *remote-path*
  Delete a directory (which must be empty).

**quit**
  Exit the client.

**?** **h** **help**
  Print built-in help.

COPYRIGHT
=========

See the file /usr/doc/tnfs-fuse-|version|/COPYING for license information.

AUTHORS
=======

tnfs-client was written by Radu Cristescu.

This man page written for the SlackBuilds.org project
by B. Watson, and is licensed under the WTFPL.

SEE ALSO
========

**tnfs-fuse**\(1), **tnfsd**\(1), **fuse**\(8)
