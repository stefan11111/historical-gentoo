# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-action/nighthawk/nighthawk-2.2.ebuild,v 1.5 2004/06/24 21:57:25 agriffis Exp $

inherit games eutils

DESCRIPTION="A tribute to one of the most playable and contagious games ever written- Paradroid by Andrew Braybrook"
HOMEPAGE="http://jsno.arafuraconnect.com.au/proj_linux/nighthawk.html"
SRC_URI="ftp://metalab.unc.edu/pub/Linux/games/arcade/${P}-1.tar.gz"

KEYWORDS="x86 ppc"
LICENSE="GPL-2"
SLOT="0"
IUSE=""

DEPEND="virtual/x11"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/nighthawk.patch
}

src_install () {
	make DESTDIR=${D} install || die "make install failed"
	prepgamesdirs
}
