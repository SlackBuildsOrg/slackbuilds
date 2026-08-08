.. RST source for sfarkxtc(1) man page. Convert with:
..   rst2man.py sfarkxtc.rst > sfarkxtc.1

.. |version| replace:: 20181208
.. |date| date::

========
sfarkxtc
========

----------------------
extract sfArk v2 files
----------------------

:Manual section: 1
:Manual group: SlackBuilds.org
:Date: |date|
:Version: |version|

SYNOPSIS
========

sfarkxtc **input-file** *<output-file>*

DESCRIPTION
===========

sfarkxtc is a console utility to convert soundfonts in the legacy
sfArk v2 file format to sf2. sfArk is a lossless audio compression
format optimized for SoundFont files. Only v2 sfArk archives are
supported.

**input-file** must be a v2 sfArk file. Typically these have filenames
ending in **.sfArk**.

The output will be the result as a SoundFont (sf2) file. If no
*output-file* is given, the original filename stored in the .sfArk
file is used.

COPYRIGHT
=========

See the file /usr/doc/sfarkxtc-|version|/COPYING for license information.

AUTHORS
=======

sfarkxtc was written by Andy Inman.

This man page written for the SlackBuilds.org project
by B. Watson, and is licensed under the WTFPL.

SEE ALSO
========

The sfarkxtc homepage: https://github.com/raboof/sfarkxtc
