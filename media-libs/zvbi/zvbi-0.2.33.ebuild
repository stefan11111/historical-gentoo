# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/zvbi/zvbi-0.2.33.ebuild,v 1.10 2010/08/20 13:46:36 ssuominen Exp $

EAPI=2
inherit eutils libtool

DESCRIPTION="VBI Decoding Library for Zapping"
SRC_URI="mirror://sourceforge/zapping/${P}.tar.bz2"
HOMEPAGE="http://zapping.sourceforge.net"

LICENSE="GPL-2 LGPL-2"
SLOT="0"
KEYWORDS="alpha amd64 ia64 ppc ppc64 sparc x86 ~x86-fbsd"
IUSE="doc dvb nls static-libs v4l X"

RDEPEND=">=media-libs/libpng-1.4
	sys-libs/zlib
	nls? ( virtual/libintl )
	X? ( x11-libs/libX11 )"
DEPEND="${RDEPEND}
	virtual/os-headers
	doc? ( app-doc/doxygen )
	nls? ( sys-devel/gettext )
	X? ( x11-libs/libXt )"

src_prepare() {
	epatch "${FILESDIR}"/${P}-glibc212.patch
	elibtoolize
}

src_configure() {
	econf \
		--disable-dependency-tracking \
		$(use_enable static-libs static) \
		$(use_enable v4l) \
		$(use_enable dvb) \
		$(use_enable nls) \
		$(use_with X x) \
		$(use_with doc doxygen)
}

src_install() {
	emake DESTDIR="${D}" install || die

	dodoc AUTHORS BUGS ChangeLog NEWS README TODO
	use doc && dohtml -a png,gif,html,css doc/html/*

	find "${D}" -name '*.la' -delete
}
