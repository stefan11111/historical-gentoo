# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/mergetrees/mergetrees-0.9.3.ebuild,v 1.14 2004/06/28 05:59:30 ciaranm Exp $

DESCRIPTION="A three-way directory merge tool"
SRC_URI="http://cvs.bofh.asn.au/mergetrees/${P}.tar.gz"
HOMEPAGE="http://cvs.bofh.asn.au/mergetrees/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 sparc ~ppc ~mips"

DEPEND=">=dev-lang/perl-5
	>=sys-apps/diffutils-2"

src_compile() {
	econf || die
	make clean || die
	emake || die
}

src_install() {
	einstall || die
	dodoc AUTHORS COPYING Changelog NEWS README* TODO
}
