# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-simulation/corewars/corewars-0.9.12.ebuild,v 1.6 2005/06/15 19:09:51 wolf31o2 Exp $

DESCRIPTION="Simulation game involving virtual machine code"
SRC_URI="mirror://sourceforge/corewars/${P}.tar.gz"
HOMEPAGE="http://corewars.sourceforge.net/"

KEYWORDS="x86 ppc"
IUSE=""
SLOT="0"
LICENSE="GPL-2"

DEPEND="virtual/x11
	virtual/libc
	>=dev-libs/glib-1.2.10-r1
	=x11-libs/gtk+-1.2*"

src_compile() {
	./configure --prefix=/usr \
		--mandir=/usr/share/man \
		--infodir=/usr/share/info || die

	emake || die
}

src_install() {
	make \
		prefix=${D}/usr \
		mandir=${D}/usr/share/man \
		infodir=${D}/usr/share/info \
		install || die

	dodoc ChangeLog README TODO DIFFERENCES INTERESTING-COMBINATIONS
}
