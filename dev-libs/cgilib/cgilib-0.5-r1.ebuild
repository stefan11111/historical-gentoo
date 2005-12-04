# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/cgilib/cgilib-0.5-r1.ebuild,v 1.5 2005/12/04 20:15:06 tgall Exp $

inherit eutils toolchain-funcs

DESCRIPTION="A programmers library for the CGI interface"
HOMEPAGE="http://www.infodrom.org/projects/cgilib/"
SRC_URI="http://www.infodrom.org/projects/${PN}/download/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ppc64 ~s390 ~sparc ~x86"
IUSE=""

src_unpack(){
	unpack ${A}
	epatch ${FILESDIR}/${P}-cgitest.diff
	cd ${S}
	sed -i "s|^\(CFLAGS = -I. -Wall\).*$|\1 ${CFLAGS}|" Makefile || \
		die "sed Makefile failed"
}

src_compile(){
	emake
	# test is possibly broken on other arches
	use x86 && $(tc-getCC) -o cgilib.test cgitest.c -lcgi
}

src_install(){
	insinto /usr/include
	doins cgi.h
	dolib.a libcgi.a
	use x86 && dobin cgilib.test
	doman *.[35]
	dodoc CHANGES CREDITS readme cookies.txt
}
