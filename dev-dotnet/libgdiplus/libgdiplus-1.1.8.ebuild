# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-dotnet/libgdiplus/libgdiplus-1.1.8.ebuild,v 1.7 2006/02/20 02:28:47 latexer Exp $

inherit libtool eutils

DESCRIPTION="Library for using System.Drawing with Mono"

HOMEPAGE="http://www.go-mono.com/"

SRC_URI="http://www.go-mono.com/sources/${PN}-${PV:0:3}/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ppc x86"

IUSE="tiff gif jpeg png"

DEPEND="sys-devel/libtool
	sys-devel/automake
	sys-devel/autoconf
	|| ( (	x11-libs/libXrender
		x11-libs/libX11
		x11-libs/libXt )
		virtual/x11 )
	tiff? ( media-libs/tiff )
	gif? ( >=media-libs/giflib-4.1.3 )
	jpeg? ( media-libs/jpeg )
	png? ( media-libs/libpng )"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${PN}-1.1.4-included-cairo-fix.diff || die
	epatch ${FILESDIR}/${PN}-1.1.8-giflib.diff || die
	libtoolize --copy --force || die "libtoolize failed"
	autoheader || die "autoheader failed"
	aclocal || die "aclocal failed"
	autoconf || die "autoconf failed"
	automake || die "automake failed"
}

src_compile() {
	local myconf="--with-cairo=included --disable-glitz"
	use tiff ||  myconf="--without-libtiff ${myconf}"
	use gif ||  myconf="--without-libgif ${myconf}"
	use jpeg ||  myconf="--without-libjpeg ${myconf}"
	use png ||  myconf="--without-libpng ${myconf}"

	econf ${myconf} || die
	# attribute((__stdcall__)) generate warnings on ppc
	use ppc && sed -i -e 's:-Werror::g' src/Makefile
	emake || die
}

src_install() {
	make DESTDIR=${D} install || die
	#einstall || die

	dodoc AUTHORS ChangeLog NEWS README
}
