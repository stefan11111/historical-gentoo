# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/rol/rol-0.2.2.ebuild,v 1.6 2003/09/22 02:54:46 seemant Exp $

inherit eutils

S=${WORKDIR}/${P}
DESCRIPTION="A RSS/RDF Newsreader"
HOMEPAGE="http://unknown-days.com/rol/"
SRC_URI="http://unknown-days.com/rol/${P}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ~amd64 ~ppc ~sparc ~alpha ~hppa ~mips ~arm"


DEPEND="virtual/x11
	dev-libs/libxml
	>=x11-libs/gtk+-2.0.9"

src_compile() {
	emake || die
}

src_install() {
	cd ${S}/src
	dobin rol
	cd ${S}
	dodoc AUTHORS ChangeLog README SITES
}
