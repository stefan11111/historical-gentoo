# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/dev-libs/gmp/gmp-4.1-r1.ebuild,v 1.1 2002/07/06 15:44:21 agriffis Exp $

DESCRIPTION="Library for arithmetic on arbitrary precision integers, rational numbers, and floating-point numbers"
SRC_URI="ftp://prep.ai.mit.edu/gnu/gmp/${P}.tar.gz"
HOMEPAGE="http://www.gnu.org/software/gmp/gmp.html"
DEPEND="virtual/glibc
	>=sys-devel/m4-1.4p"
RDEPEND="virtual/glibc"

src_unpack() {
	unpack ${A}
	cd ${S}
	patch < ${FILESDIR}/randraw.c.41.diff
}

src_compile() {                           
	./configure \
		--build=${CHOST} \
		--host=${CHOST} \
		--target=${CHOST} \
		--prefix=/usr \
		--infodir=/usr/share/info \
		--mandir=/usr/share/man \
		--sysconfdir=/etc \
		--localstatedir=/var/state/gmp \
		--enable-cxx \
		--enable-mpbsd \
		--enable-mpfr || die "configure failed"

	emake || die "make failed"
}

src_install() {                               
	make DESTDIR=${D} install || die

	dodoc AUTHORS ChangeLog COPYING* NEWS README
	dodoc doc/configuration doc/isa_abi_headache
	dohtml -r doc
}
