# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/m17n-lib/m17n-lib-1.3.3.ebuild,v 1.1 2006/08/07 00:19:59 matsuu Exp $

inherit flag-o-matic

DESCRIPTION="Multilingual Library for Unix/Linux"
HOMEPAGE="http://www.m17n.org/m17n-lib/"
SRC_URI="http://www.m17n.org/m17n-lib/download/${P}.tar.gz"

LICENSE="LGPL-2.1"

SLOT="0"
KEYWORDS="~alpha ~amd64 ~hppa ~ppc ~ppc64 ~sparc ~x86"
IUSE=""

DEPEND="|| ( (
			x11-libs/libXaw
			x11-libs/libICE
			x11-libs/libXrender
			x11-libs/libXft
		)
		virtual/x11
	)
	dev-libs/libxml2
	dev-libs/fribidi
	>=media-libs/freetype-2.1
	media-libs/fontconfig
	media-libs/gd
	>=dev-libs/libotf-0.9.2
	>=dev-db/m17n-db-${PV}"

src_compile() {
	append-flags -fPIC
	econf || die
	emake -j1 || die
}

src_install() {
	emake DESTDIR="${D}" install || die

	dodoc AUTHORS ChangeLog INSTALL NEWS README TODO
}
