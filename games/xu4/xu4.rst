.. RST source for xu4(6) man page. Convert with:
..  rst2man.py xu4.rst > xu4.6

.. |version| replace:: 1.4.3
.. |date| date::

===
xu4
===

---------------------------------------------------------------------
A modern reimplementation of the classic Ultima IV role-playing game.
---------------------------------------------------------------------

:Manual section: 6
:Manual group: SlackBuilds.org
:Date: |date|
:Version: |version|

SYNOPSIS
========

xu4 [*options*]

DESCRIPTION
===========

XU4 is a remake of the computer game Ultima IV.  The goal is to make it
easy and convenient to play this classic on modern operating systems.

This man page only describes the command-line options and keyboard
commands supported by xu4. For  full  documentation,  see  the
files  in /usr/doc/xu4-|version|/. The README is a good place to
start. Also the "History of Britannia" and the "Book of Mystic Wisdom"
are found  there (you should read them before playing).


OPTIONS
=======

xu4 accepts the following options:

**-f**, **--fullscreen**
        Run in fullscreen mode.

**--filter** *<filt>*
        Apply  a  filter on the scaled images. The *<filt>* parameter must
        be set to one of the following case-sensitive options:
        *point*, *HQX*, *xBR-lv2*, *xBRZ*, *point-43*, *xBRZ-43*.

**-i**, **--skip-intro**
        Skip  the intro, and go directly into the game.  This option
        requires the existence of a valid saved game.

**-m**, **--module** *<file>*
        Specify game module (default is Ultima-IV).

**-p** *<profname>*, **--profile** *<profname>*
        Activate a specific save game profile.  Using this  option,
        you may have multiple saved games at the same time. Also, the
        game's config is stored on a per-profile basis, so  different
        profiles could  have  e.g.  different  screen resolutions.
        Use quotation marks around profile names that include  spaces.
        All  profiles are stored in the **~/.config/xu4/profiles**
        sub-directory.  The active profile name is shown on the
        introduction map view off  the main menu.

**-q**, **--quiet**
        Disable audio.

**-s**, **--scale** *<n>*
        Scale the original graphics by a factor of <n>.  Factor <n> must
        be *1*, *2*, *3*, *4*, or *5*.

**-v**, **--verbose**
        Verbose output; prints out information useful for trouble-shooting.

KEYBOARD CONTROLS
=================

XU4  is  played  mainly  with  the keyboard (though mouse input is supported).
To make choices from menus, press the first letter of the menu
choice  (e.g. J for "Journey Onward" at the main menu). The Config menu
also supports navigation with the arrow keys and Enter.

At the main menu, press **Escape** for the game module browser.

During gameplay, the following keystrokes  are  supported  (information
taken from Keyboard.txt and README):

A (Attack)
      Attempt  to  engage  thy  foe  with the weapon thou hast readied
      (Ready Weapon command); must be followed by the direction of thy
      foe.

B (Board)
      Board a vessel or mount a horse.

C (Cast)
      Cast  a  magical  spell;  must  be followed by the number of the
      player who wishes to cast it (not needed in combat or in dungeon
      rooms),  and  then the first letter of the desired spell.  Note:
      All spells must have reagents mixed in advance of casting.

D (Descend)
      Climb down ladder to next level of dungeon or building.

E (Enter)
      Go into such places as villages, townes, castles,  dungeons  and
      shrines.

F (Fire)
      Fire a ship's cannons (once thou hast Boarded); must be followed
      by a direction.  Note: Broadsides only!

G (Get Chest)
      Attempt to open (and disarm, if trapped) chest; must be followed
      by the number of the player who wishes to open the chest, except
      during combat and in dungeon rooms.  Note: 'Tis  wisest  to  use
      the player with the highest Dexterity when examining potentially
      dangerous chests as this lessens the chances of setting off  any
      traps.

H (Hole up and camp)
      Set  up  camp  to  rest and recover from thy wounds.  Note: This
      command may only be used successfully with limited frequency.

1 (Ignite a torch)
      Light a torch for illumination in dungeons. Requires  a  special
      item.

J (Jimmy lock)
      Use  a  magical key to unlock a sealed door. Must be followed by
      the direction of the door that thou dost wish to unlock.

K (Klimb)
      Climb up a ladder to the next level of a building or dungeon, or
      to reach the surface from the topmost level of a dungeon.

L (Locate Position)
      Requires a special item.

M (Mix Reagents)
      Prepare material components of spells for later use.  Note: Thou
      must have reagents mixed ahead of time  in  order  to  cast  any
      spells.  When asked "Reagent:", type the letter corresponding to
      the reagents desired and then type [Return] when thou wishes  to
      mix them.

N (New order)
      Exchanges  the  position  of  two  players  indicated within thy
      party, except for player #1, for thou must lead the party.

O (Open door)
      Open a door in the direction indicated.

P (Peer at gem)
      Requires a special item.

Q (Quit & Save)
      Saves the current game status to disk; thou may  continue  after
      this command or power down thy computer.

R (Ready a weapon)
      Equip  a player with the weapon of thy choice (if owned) for use
      in combat.

S (Search)
      Search thy exact current location for unusual items.

T (Talk)
      Allows a player to converse with merchants or townesfolk in  the
      direction indicated.

U (Use)
      Use an item thou hast found during play by means of the "Search"
      command.

V (Volume)
      Toggles sound effects on or off.

W (Wear armour)
      Outfits a player with the armour of thy choice if owned for  defense in combat.

X (Xit)
      That's (e)xit thy current form of transportation and continue on
      foot.

Y (Yell)
      Yell "giddyup" or "whoa" to speed up or slow down thy horse.

Z (Ztats)
      Displays the status and attributes of a selected player; if 0 is
      pressed  instead  of  a player number, this command will display
      the lists of weapons, armour, items, reagents and mixtures.  The
      left and right arrow keys will scroll through these lists, while
      pressing any other key will return thee to game play.

ARROW KEYS
      Control movement. North/South/East/West.

FILES
=====

~/.config/xu4/
      Configuration and saved games are stored here, when **-p**
      is not in use.  The  config  file  is  **xu4rc**. It is
      human-readable and editable, but normally is created and updated
      by the in-game  configuration menu. The savegames are in a
      binary format.

~/.config/xu4/profiles/<profname>/
      When  using  the  **-p** *<profname>* option, config and savegame data
      are stored here instead.

COPYRIGHT
=========

See the file /usr/doc/xu4-|version|/COPYING for license information.

AUTHORS
=======

Ultima IV was created by Richard Garriott, aka Lord British.

XU4 authors:

Andrew Taylor <andrewtaylor@users.sourceforge.net>
       Main developer

Marc Winterrowd <nodling at yahoo dot com>
       LZW decoder, tile animations, title screen fixes, and lots more

Daniel Browning-Weber <dan_ultima@users.sourceforge.net>
       Developer

Darren Janeczek <darren_janeczek@users.sourceforge.net>
       Developer

Doug Day <dougday@users.sourceforge.net>
       Developer

Travis Howell <kirben@users.sourceforge.net>
       Windows port

Frank Wolter <FrankWolter@gmx.net>
       Ultima IV icon used in xu4

Dennis De Marco <dennis@demarco.com>
       Sound code

Steve Saunders <s_j_nevets@yahoo.com.au>
       MacOSX port

Michael Ryan <solus@users.sourceforge.net>
       Text colorization, profiles, enhanced LOS algorithm,  title/intro sequence, general fixes

Gregory Saunders <grerfy@users.sourceforge.net>
       Amiga file formats, minor enhancements

This man  page  created  (from README and Keyboard.txt contents) by
B. Watson, for the SlackBuilds.org project. Permission hereby granted
to use this man page anywhere, for any purpose.
