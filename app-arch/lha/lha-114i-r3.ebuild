# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-arch/lha/lha-114i-r3.ebuild,v 1.4 2004/06/28 01:25:24 tgall Exp $

inherit eutils

DESCRIPTION="Utility for creating and opening lzh archives"
HOMEPAGE="http://www2m.biglobe.ne.jp/~dolphin/lha/lha-unix.htm"
SRC_URI="http://www2m.biglobe.ne.jp/~dolphin/lha/prog/${P}.tar.gz"

LICENSE="lha"
SLOT="0"
KEYWORDS="x86 ppc sparc alpha amd64 ppc64"
IUSE=""

DEPEND="virtual/libc"

src_unpack () {
	unpack ${A} ; cd ${S}
	sed -i -e "/^OPTIMIZE/ s:-O2:${CFLAGS}:" Makefile
	cd src
	epatch ${FILESDIR}/${P}.diff
	epatch ${FILESDIR}/${P}-lhext.diff
}

src_compile() {
	emake || die
}

src_install() {
	dodir /usr/bin
	dodir /usr/share/man/ja/man1
	make \
		BINDIR=${D}/usr/bin \
		MANDIR=${D}/usr/share/man/ja \
		install MANSECT=1 || die

	dodoc *.txt *.euc *.eng
}
