# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/bglibs/bglibs-1.009.ebuild,v 1.3 2004/01/07 22:16:45 robbat2 Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Bruce Guenters Libraries Collection"
HOMEPAGE="http://untroubled.org/bglibs/"
SRC_URI="http://untroubled.org/bglibs/${P}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 sparc"

DEPEND="virtual/glibc"

src_compile() {
	echo "${D}/usr/lib/bglibs" > conf-home
	echo "gcc ${CFLAGS}" > conf-cc
	MAKEOPTS="" emake || die
}

src_install () {
	dodir /usr/lib/bglibs
	./installer || die "install failed"
	dodoc ANNOUNCEMENT COPYING NEWS README
}
