#!/bin/sh

# Copyright 2020  Patrick J. Volkerding, Sebeka, Minnesota, USA
# All rights reserved.
#
# Redistribution and use of this script, with or without modification, is
# permitted provided that the following conditions are met:
#
# 1. Redistributions of this script must retain the above copyright
#    notice, this list of conditions and the following disclaimer.
#
#  THIS SOFTWARE IS PROVIDED BY THE AUTHOR ``AS IS'' AND ANY EXPRESS OR IMPLIED
#  WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF
#  MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED.  IN NO
#  EVENT SHALL THE AUTHOR BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
#  SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,
#  PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS;
#  OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY,
#  WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR
#  OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF
#  ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

###########################################################################
# This script is here to show how to generate a source tarball for incus-ui
# since the git repo has no release tarballs available. It is based on PV's
# script for some other package (whose name I don't recall right now, hence
# the copyright attribution above.
#
# This is the exact script used to generate the source tarballs found here
# at sbodirectlinks. Feel free to generate your own source tarball.
#
# The *-NM* tarballs of javascript node modules are generated separately.
# See SBo's system/incus-ui/incus-ui.SlackBuild


# Clear download area:
rm -rf uPDFParser

# Clone repository:
git clone https://forge.soutade.fr/soutade/uPDFParser.git

HEADISAT="$( cd uPDFParser && git log -1 --format=%h )"
DATE="$( cd uPDFParser && git log -1 --format=%cd --date=format:%Y%m%d )"

echo "DATE = $DATE"
echo "HEADISAT = $HEADISAT"

# Cleanup.  We're not packing up the whole git repo.
( cd uPDFParser && find . -type d -name ".git*" -exec rm -rf {} \; 2> /dev/null )

# Generate tarball
mv uPDFParser uPDFParser-${DATE}_${HEADISAT}
tar cf uPDFParser-${DATE}_${HEADISAT}.tar uPDFParser-${DATE}_${HEADISAT}
plzip -9 uPDFParser-${DATE}_${HEADISAT}.tar
rm -rf uPDFParser-${DATE}_${HEADISAT}
touch -d "$DATE" uPDFParser-${DATE}_${HEADISAT}.tar.lz
echo
echo "uPDFParser branch $BRANCH with HEAD at $HEADISAT packaged as uPDFParser-${DATE}_${HEADISAT}.tar.lz"
echo
