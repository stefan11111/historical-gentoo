# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/geoclue/geoclue-0.12.99.ebuild,v 1.5 2012/09/26 14:10:14 ago Exp $

EAPI=4
inherit autotools eutils

DESCRIPTION="A geoinformation D-Bus service"
HOMEPAGE="http://freedesktop.org/wiki/Software/GeoClue"
SRC_URI="http://freedesktop.org/~hadess/${P}.tar.gz"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="amd64 ~arm ~ppc ~ppc64 ~sparc ~x86 ~amd64-fbsd"
IUSE="connman geonames gps gsmloc gtk hostip manual networkmanager nominatim plazes skyhook static-libs yahoo-geo"

REQUIRED_USE="skyhook? ( networkmanager )"

RDEPEND=">=dev-libs/dbus-glib-0.100
	>=dev-libs/glib-2
	dev-libs/libxml2
	sys-apps/dbus
	gps? ( sci-geosciences/gpsd )
	gtk? ( x11-libs/gtk+:2 )
	networkmanager? ( net-misc/networkmanager )
	skyhook? ( net-libs/libsoup )"
DEPEND="${RDEPEND}
	dev-util/gtk-doc
	dev-util/gtk-doc-am
	virtual/pkgconfig"

src_prepare() {
	epatch \
		"${FILESDIR}"/${PN}-0.12.0_p20110307-use-flag.patch \
		"${FILESDIR}"/${PN}-0.12.0_p20110307-use-fallback-mac.patch \
		"${FILESDIR}"/${P}-gpsd.patch

	sed -i -e '/CFLAGS/s:-g ::' configure.ac || die #399177

	eautoreconf
}

src_configure() {
	# Conic is only for Maemo. Don't enable.
	# Gypsy has multiple vulnerabilities:
	# https://bugs.freedesktop.org/show_bug.cgi?id=33431
	econf \
		--disable-silent-rules \
		$(use_enable static-libs static) \
		--disable-schemas-compile \
		$(use_enable gtk tests) \
		$(use_enable gtk) \
		--disable-conic \
		$(use_enable connman) \
		$(use_enable networkmanager) \
		--disable-gypsy \
		$(use_enable gps gpsd) \
		$(use_enable skyhook) \
		$(use_enable geonames) \
		$(use_enable gsmloc) \
		$(use_enable hostip) \
		$(use_enable manual) \
		$(use_enable nominatim) \
		$(use_enable plazes) \
		$(use_enable yahoo-geo yahoo) \
		--with-html-dir=/usr/share/doc/${PF}/html
}

src_install() {
	emake DESTDIR="${D}" install
	use gtk && dobin test/.libs/geoclue-test-gui
	prune_libtool_files
}
