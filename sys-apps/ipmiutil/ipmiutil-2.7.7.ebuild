# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/ipmiutil/ipmiutil-2.7.7.ebuild,v 1.3 2012/03/14 07:25:34 ssuominen Exp $

EAPI=4
inherit autotools

DESCRIPTION="IPMI Management Utilities"
HOMEPAGE="http://ipmiutil.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 ~x86"
IUSE=""

RDEPEND="dev-libs/openssl:0"
DEPEND="${RDEPEND}
	virtual/os-headers"

MAKEOPTS="${MAKEOPTS} -j1"

src_prepare() {
	eautoreconf
}

src_install() {
	emake \
		DESTDIR="${D}" \
		initto="${ED}"/usr/share/doc/${PF}/examples \
		install

	dodoc AUTHORS ChangeLog NEWS README TODO doc/UserGuide
}
