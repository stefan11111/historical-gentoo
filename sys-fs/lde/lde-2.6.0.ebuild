# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-fs/lde/lde-2.6.0.ebuild,v 1.1 2003/09/26 08:46:36 vapier Exp $

DESCRIPTION="ext2fs and minix disk editor for linux"
HOMEPAGE="http://lde.sourceforge.net/"
SRC_URI="mirror://sourceforge/lde/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"

DEPEND="sys-libs/ncurses
	dev-util/yacc"

S=${WORKDIR}/${PN}

src_unpack() {
	unpack ${A}
	sed -i "s:-g -O2:${CFLAGS}:" ${S}/Makefile
}

src_compile() {
	econf || die
	emake YACC=yacc || die
}

src_install() {
	newman doc/lde.man lde.8
	into /
	dosbin lde
	dodoc WARNING README TODO
}
