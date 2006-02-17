# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/pinfo/pinfo-0.6.8.ebuild,v 1.15 2006/02/17 01:06:33 flameeyes Exp $

DESCRIPTION="Hypertext info and man viewer based on (n)curses"
HOMEPAGE="http://dione.ids.pl/~pborys/software/linux/"
SRC_URI="http://dione.ids.pl/~pborys/software/pinfo/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 hppa ia64 ~mips ppc ppc64 sparc x86"
IUSE="nls readline"

RDEPEND="sys-libs/ncurses
	nls? ( virtual/libintl )"

DEPEND="${RDEPEND}
	sys-devel/bison
	nls? ( sys-devel/gettext )"

src_compile() {
	econf \
		$(use_with readline) \
		$(use_enable nls) \
		|| die "econf failed"
	emake || die
}

src_install() {
	make DESTDIR=${D} sysconfdir=/etc install || die
}
