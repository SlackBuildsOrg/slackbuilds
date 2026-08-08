.. RST source for xatmas2(1) man page.
.. rst2man.py xatmas2.rst > xatmas2.1

.. |version| replace:: 2.7+20240613_b06cec3
.. |date| date::

=======
xatmas2
=======

----------------------------------------------
6502 cross assembler for Atari 8-bit computers
----------------------------------------------

:Manual section: 1
:Manual group: SlackBuilds.org
:Date: |date|
:Version: |version|

SYNOPSIS
========

xatmas2 [*-q*] [*-v*] [*-o* **output.xex**] **file.src**

DESCRIPTION
===========

**xatmas2** is a cross-assembler for modern systems to cross-assemble
original source code for the Atmas II assembler for the Atari 8-bit
series, once a popular assembler in the eighties and nineties.

The source code must be in ASCII format, not ATASCII. To convert Atari
text files to ASCII, see **a8cat**\(1), from *bw-atari8-tools*\.

The output is an Atari "binary load" executable.

With no **-o** option, the output file is the source filename with
*.xex* appended.

OPTIONS
=======

-o **output.xex**
  Set the output file. The **.xex** extension is not required.

-q
  Quiet. Normally **xatmas2** is quite verbose.

-v
  Print built-in help. Redundant, since running **xatmas2** with
  no arguments does the same thing.

EXIT STATUS
===========

0 for success, non-zero for failure.

COPYRIGHT
=========

Public Domain. For more information, see:

  /usr/doc/xatmas2-|version|/LICENSE

AUTHORS
=======

**xatmas2** was written by Richard Jackman and Ivo van Poorten.

This man page written for the SlackBuilds.org project
by B. Watson, and is licensed under the WTFPL.

SEE ALSO
========

The manual for the Atari 8-bit version of Atmas II:

  /usr/doc/xatmas2-|version|/atmas2.pdf (German)

  /usr/doc/xatmas2-|version|/atmas2-en.pdf (English; imcomplete)
