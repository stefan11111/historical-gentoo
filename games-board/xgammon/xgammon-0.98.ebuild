# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-board/xgammon/xgammon-0.98.ebuild,v 1.5 2004/05/07 23:01:39 mr_bones_ Exp $

inherit eutils

S="${WORKDIR}/${P}a"
DESCRIPTION="very nice backgammon game for X"
HOMEPAGE="http://fawn.unibw-hamburg.de/steuer/xgammon/xgammon.html"
SRC_URI="http://fawn.unibw-hamburg.de/steuer/xgammon/Downloads/${P}a.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc sparc"
IUSE=""

DEPEND="virtual/x11"

src_unpack() {
	unpack ${A}
	cd ${S}

	epatch "${FILESDIR}/${P}-broken.patch"
	epatch "${FILESDIR}/${P}-config.patch"
	epatch "${FILESDIR}/gcc33.patch"
}

src_compile() {
	xmkmf || die "xmkmf died"
	env PATH="${PATH}:." emake || die "emake failed"
}

src_install() {
	make DESTDIR="${D}" install || die "make install failed"
}
