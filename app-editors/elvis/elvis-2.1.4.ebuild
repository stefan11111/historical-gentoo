# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-editors/elvis/elvis-2.1.4.ebuild,v 1.10 2002/12/09 04:17:38 manson Exp $

MY_P="${PN}-2.1_4"
S=${WORKDIR}/${MY_P}
DESCRIPTION="A vi/ex clone"
SRC_URI="ftp://ftp.cs.pdx.edu/pub/${PN}/${MY_P}.tar.gz"
HOMEPAGE="ftp://ftp.cs.pdx.edu/pub/elvis/"

SLOT="0"
LICENSE="Artistic"
KEYWORDS="x86 ppc sparc "
IUSE="X"

DEPEND="virtual/glibc
	>=sys-libs/ncurses-5.2
	X? ( virtual/x11 )"
RDEPEND=""

src_compile() {
	local myconf
	use X \
		&& myconf="--with-x" \
		|| myconf="--without-x"
	./configure --bindir=${D}/usr/bin --datadir=${D}/usr/share/elvis ${myconf} || die
	cp Makefile Makefile.orig
	cat Makefile.orig | sed -e "s:gcc -O2:gcc ${CFLAGS}:" > Makefile
	make || die
}

src_install() {
	cp instman.sh instman.sh.orig
	sed -e "s:/usr/man:${D}/usr/share/man:g" instman.sh.orig > instman.sh

	cp insticon.sh insticon.sh.orig
	sed -e "s:^xinc=.*$:xinc=${D}/usr/include:" \
	 -e "s:^xlib=.*$:xlib=${D}/usr/lib:" \
		insticon.sh.orig > insticon.sh

	dodir /usr/bin
	dodir /usr/share/man/man1
	make install || die
}
