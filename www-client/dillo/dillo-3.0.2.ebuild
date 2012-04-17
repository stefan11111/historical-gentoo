# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-client/dillo/dillo-3.0.2.ebuild,v 1.9 2012/04/17 21:43:13 ranger Exp $

EAPI=4
inherit eutils flag-o-matic multilib

DESCRIPTION="Lean FLTK based web browser"
HOMEPAGE="http://www.dillo.org/"
SRC_URI="http://www.dillo.org/download/${P}.tar.bz2
	mirror://gentoo/${PN}.png"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~alpha amd64 arm hppa ppc ppc64 ~sparc x86"
IUSE="doc +gif ipv6 +jpeg +png ssl"

RDEPEND="sys-libs/zlib
	>=x11-libs/fltk-1.3:1[-cairo]
	jpeg? ( virtual/jpeg )
	png? ( >=media-libs/libpng-1.2:0 )
	ssl? ( dev-libs/openssl:0 )"
DEPEND="${RDEPEND}
	doc? ( app-doc/doxygen )"

src_prepare() {
	epatch "${FILESDIR}"/${PN}2-inbuf.patch
}

src_configure() {
	append-ldflags "-L/usr/$(get_libdir)/fltk"

	econf  \
		--docdir="/usr/share/doc/${PF}" \
		$(use_enable gif) \
		$(use_enable ipv6) \
		$(use_enable jpeg) \
		$(use_enable png) \
		$(use_enable ssl)
}

src_compile() {
	default
	if use doc; then
		doxygen Doxyfile || die
	fi
}

src_install() {
	dodir /etc
	default

	use doc && dohtml html/*
	dodoc AUTHORS ChangeLog README NEWS
	dodoc doc/*.txt doc/README

	doicon "${DISTDIR}"/${PN}.png
	make_desktop_entry ${PN} Dillo
}

pkg_postinst() {
	elog "Dillo has installed a default configuration into /etc/dillo/dillorc"
	elog "You can copy this to ~/.dillo/ and customize it"
}
