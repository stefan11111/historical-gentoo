# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-crypt/pgpdump/pgpdump-0.19.ebuild,v 1.6 2004/06/27 21:34:58 vapier Exp $

DESCRIPTION="A PGP packet visualizer"
HOMEPAGE="http://pgp.iijlab.net/pgpdump.html"
SRC_URI="ftp://pgp.iijlab.net/pub/pgp/tools/${P}.tar.gz"

LICENSE="as-is"
SLOT="0"
KEYWORDS="x86"
IUSE=""

DEPEND="virtual/libc"

src_compile() {
	econf || die
	emake CFLAGS="${CFLAGS}" || die
}

src_install() {
	dodir /usr/bin
	dodir /usr/share/man/man1
	make \
		bindir=${D}/usr/bin \
		mandir=${D}/usr/share/man/man1 \
		install || die
	dodoc CHANGES README
}
