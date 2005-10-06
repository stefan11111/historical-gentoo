# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/abook/abook-0.5.4.ebuild,v 1.4 2005/10/06 18:55:26 hansmi Exp $

inherit eutils gnuconfig

DESCRIPTION="Abook is a text-based addressbook program designed to use with mutt mail client."
HOMEPAGE="http://abook.sourceforge.net/"
SRC_URI="mirror://sourceforge/abook/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ppc ~ppc-macos ~ppc64 sparc x86"
IUSE=""

DEPEND="sys-libs/ncurses
	sys-libs/readline"

src_unpack() {
	unpack ${A}
	cd ${S}
	gnuconfig_update
}

src_install() {
	make install DESTDIR=${D} || die "install died"
	dodoc ANNOUNCE AUTHORS BUGS ChangeLog FAQ NEWS README THANKS TODO
	dodoc sample.abookrc
}
