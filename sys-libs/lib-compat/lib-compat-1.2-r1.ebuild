# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-libs/lib-compat/lib-compat-1.2-r1.ebuild,v 1.2 2003/10/26 18:30:59 azarah Exp $

IUSE=

S="${WORKDIR}/${P}/${ARCH}"
DESCRIPTION="Compatibility C++ and libc5 and libc6 libraries for programs new and old"
HOMEPAGE="http://www.gentoo.org/"
SRC_URI="mirror://gentoo/${P}.tar.bz2"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ppc sparc alpha"

DEPEND="virtual/glibc"

src_unpack() {
	unpack ${A}

	cd ${S}
	# Rather install this with the proper filename
	mv -f libstdc++-libc6.2-2.so.3 libstdc++-3-libc6.2-2-2.10.0.so
	# libstdc++-2-libc6.1-1-2.9.0.so provides this one ...
	rm -f libstdc++-libc6.1-1.so.2
	# No package installs this one, so no need for the .dummy
	mv -f libstdc++.so.2.9.dummy libstdc++.so.2.9.0
}

src_install() {
	into /usr
	dolib.so *.so*
	preplib /usr
}

