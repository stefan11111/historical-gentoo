# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/asyncresolv/asyncresolv-0.0.3.ebuild,v 1.4 2004/07/16 09:21:55 dholm Exp $

DESCRIPTION="Asynchronous DNS query library written in C++"
HOMEPAGE="http://asyncresolv.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc"

IUSE=""
DEPEND="virtual/libc"

src_install() {
	make install DESTDIR=${D} || die "install failed"

	dodoc AUTHORS COPYING* ChangeLog INSTALL README TODO
	dohtml doc/index.html
}
