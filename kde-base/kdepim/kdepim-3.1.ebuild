# Copyright 1999-2001 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdepim/kdepim-3.1.ebuild,v 1.3 2002/11/23 14:05:19 danarmak Exp $
inherit kde-dist 

DESCRIPTION="KDE PIM (Personal Information Management) apps: korganizer..."
KEYWORDS="x86"
DEPEND="$DEPEND sys-devel/perl"

newdepend "pda? ( >=dev-libs/pilot-link-0.11.1-r1 )
	    ~kde-base/kdebase-$PV
	    ~kde-base/kdenetwork-$PV" # mimelib is needed for support of some stuff with exchange servers

use pda && myconf="$myconf --with-extra-includes=/usr/include/libpisock"

# reported by doctomoe on ppc
MAKEOPTS="$MAKEOPTS -j1"

src_install() {
	kde_src_install
	docinto html
	dodoc *.html
}
