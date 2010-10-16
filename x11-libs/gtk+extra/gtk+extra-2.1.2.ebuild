# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-libs/gtk+extra/gtk+extra-2.1.2.ebuild,v 1.7 2010/10/16 19:00:34 hwoarang Exp $

EAPI=2
inherit autotools eutils

DESCRIPTION="Useful Additional GTK+ widgets"
HOMEPAGE="http://gtkextra.sourceforge.net"
SRC_URI="mirror://sourceforge/gtkextra/${P}.tar.gz"

LICENSE="FDL-1.1 LGPL-2"
SLOT="0"
KEYWORDS="amd64 ~ia64 ~ppc ~ppc64 ~sparc ~x86"
IUSE="static-libs"

RDEPEND="x11-libs/gtk+:2
	dev-libs/glib:2"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

src_prepare() {
	epatch "${FILESDIR}"/${P}-build.patch \
		"${FILESDIR}"/${P}-marshal.patch \
		"${FILESDIR}"/${P}-gtk+-2.21.patch
	eautoreconf
}

src_configure() {
	econf \
		--disable-dependency-tracking \
		$(use_enable static-libs static) \
		--with-html-dir=/usr/share/doc/${PF}/html
}

src_install() {
	emake DESTDIR="${D}" install || die
	dodoc AUTHORS ChangeLog README || die
	find "${D}" -name '*.la' -exec rm -f '{}' + || die
}
