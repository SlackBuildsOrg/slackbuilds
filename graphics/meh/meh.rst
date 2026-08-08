.. rst2man.py meh.rst > meh.1

.. |version| replace:: 0.3+20181021_69f653a
.. |date| date::

===
meh
===

---------------------------------------------------
simple, minimalist, super fast image viewer for X11
---------------------------------------------------

:Manual section: 1
:Manual group: SlackBuilds.org
:Date: |date|
:Version: |version|

SYNOPSIS
========

meh *FILE* [*FILE* ...]

meh **-list** *LISTFILE*

meh **-ctl**

meh **-v**

DESCRIPTION
===========

**meh** is a small, simple, super fast image viewer using raw XLib.
It is similar to feh(1), but faster and simpler.

Built-in formats are JPEG, PNG, BMP, GIF, and netpbm, but **meh**
can use ImageMagick's **convert**\(1) to view almost 200 file formats
(though it is slower for these formats).

Animations (e.g. GIF, MNG) are not supported. Only the first frame will be displayed.

OPTIONS
=======

-list *LISTFILE*
  Treat *LISTFILE* as list of images. Defaults to stdin.

**-ctl**
  Display files as they are received on stdin.

-v
  Print version and exit.

KEY BINDINGS
============

While meh is displaying an image, the following key bindings are active:

**j** **l** **Right** **Down** **Space**
  Next image.

**k** **h** **Left** **Up** **Backspace**
  Previous image.

**r**
  Reload current image.

**Enter**
  Print current image's filename to stdout.

**0**
  Resize window to current image's size.

**Escape** **q**
  Exit meh.

COPYRIGHT
=========

See the file /usr/doc/PRGNAM-|version|/COPYING for license information.

AUTHORS
=======

**meh** was written by John Hawthorn (jhawthor@uvic.ca).

This man page written for the SlackBuilds.org project
by B. Watson, and is licensed under the WTFPL.

SEE ALSO
========

The meh homepage: https://www.johnhawthorn.com/meh

The meh github repository: https://github.com/jhawthorn/meh
