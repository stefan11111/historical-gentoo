# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-action/geki3-KXL/geki3-KXL-1.0.3-r1.ebuild,v 1.5 2004/06/24 21:55:32 agriffis Exp $

inherit games eutils

DESCRIPTION="2D length scroll shooting game"
SRC_URI="http://kxl.hn.org/download/${P}.tar.gz"
HOMEPAGE="http://kxl.hn.org/"

KEYWORDS="x86"
SLOT="0"
LICENSE="GPL-2"
IUSE=""

DEPEND=">=dev-games/KXL-1.1.7"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${PV}-gentoo-paths.patch
	aclocal || die "aclocal failed"
	automake -a || die "automake failed"
	autoconf || die "autoconf failed"
}

src_install() {
	make DESTDIR=${D} install || die
	dodoc ChangeLog README
	prepgamesdirs
}
