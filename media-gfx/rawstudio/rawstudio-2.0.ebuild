# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/rawstudio/rawstudio-2.0.ebuild,v 1.1 2011/10/08 16:47:08 ssuominen Exp $

EAPI=4
inherit autotools eutils

DESCRIPTION="A program for reading and manipulating raw images from digital cameras"
HOMEPAGE="http://rawstudio.org/"
SRC_URI="http://${PN}.org/files/release/${P}.tar.gz"

LICENSE="GPL-2 CCPL-Attribution-ShareAlike-3.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="dev-db/sqlite:3
	dev-libs/libxml2
	>=dev-libs/openssl-1
	>=gnome-base/gconf-2
	media-libs/flickcurl
	=media-libs/lcms-1*
	media-libs/lensfun
	media-libs/libgphoto2
	media-libs/tiff
	media-gfx/exiv2
	net-misc/curl
	sci-libs/fftw:3.0
	sys-apps/dbus
	sys-libs/zlib
	virtual/jpeg
	x11-libs/gtk+:2
	x11-libs/libX11"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	sys-devel/gettext"

DOCS=( AUTHORS NEWS README TODO )

src_prepare() {
	find . -name Makefile.am -exec sed -i -e 's:-O4:-Wall:' {} +
	sed -i -e '/^icondir/s:icons:pixmaps:' pixmaps/Makefile.am || die
	epatch "${FILESDIR}"/${P}-libpng15.patch
	eautoreconf
}

src_configure() {
	econf --disable-static
}

src_install() {
	default
	find "${ED}"usr -name '*.la' -exec rm -f {} +
}
