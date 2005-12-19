# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/tcmplex-panteltje/tcmplex-panteltje-0.4.7.ebuild,v 1.2 2005/12/19 17:13:47 hd_brummy Exp $

inherit eutils

DESCRIPTION="audio video multiplexer for 8 audio channels"
HOMEPAGE="http://panteltje.com/panteltje/dvd/"
SRC_URI="http://panteltje.com/panteltje/dvd/${P}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc"
IUSE=""

src_compile() {

	sed -i "s:CFLAGS = -O2:CFLAGS +=:" Makefile
	emake  || die "emake failed"

}

src_install() {
	dobin tcmplex-panteltje
	dodoc CHANGES COPYRIGHT LICENSE README
}
