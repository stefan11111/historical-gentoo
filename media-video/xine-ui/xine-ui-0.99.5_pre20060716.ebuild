# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/xine-ui/xine-ui-0.99.5_pre20060716.ebuild,v 1.8 2007/01/11 22:07:50 opfer Exp $

# WANT_AUTOCONF=latest
# WANT_AUTOMAKE=latest

inherit eutils toolchain-funcs flag-o-matic # autotools

#PATCHLEVEL="11"
DESCRIPTION="Xine movie player"
HOMEPAGE="http://xine.sourceforge.net/"
SRC_URI="mirror://gentoo/${P}.tar.bz2"
#	mirror://gentoo/${PN}-patches-${PATCHLEVEL}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha amd64 ~hppa ppc ppc64 sparc x86 ~x86-fbsd"
IUSE="X nls lirc aalib libcaca readline curl ncurses vdr xinerama debug"

RDEPEND=">=media-libs/libpng-1.2.8
	>=media-libs/xine-lib-1.1.0
	lirc? ( app-misc/lirc )
	aalib? ( media-libs/aalib )
	libcaca? ( media-libs/libcaca )
	curl? ( >=net-misc/curl-7.10.2 )
	ncurses? ( sys-libs/ncurses )
	X? ( || ( (
			x11-libs/libX11
			x11-libs/libXrender
			x11-libs/libICE
			x11-libs/libSM
			x11-libs/libXext
			x11-libs/libXxf86vm
			x11-libs/libXv
			x11-libs/libXtst
			x11-libs/libXft
			xinerama? ( x11-libs/libXinerama )
		) <virtual/x11-7 ) )
	nls? ( virtual/libintl )"
DEPEND="${RDEPEND}
	nls? ( sys-devel/gettext )
	X? ( || ( (
			x11-libs/libXt
			x11-proto/xf86vidmodeproto
			xinerama? ( x11-proto/xineramaproto )
		) <virtual/x11-7 ) )
	dev-util/pkgconfig"

src_compile() {
	rm misc/xine-bugreport

	econf \
		$(use_enable lirc) \
		$(use_enable nls) \
		$(use_enable vdr vdr-keys) \
		$(use_enable xinerama) \
		$(use_enable debug) \
		$(use_with X x) \
		$(use_with aalib) \
		$(use_with libcaca) \
		$(use_with curl) \
		$(use_with readline) \
		$(use_with ncurses) \
		|| die "econf failed"
	emake || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" docdir="/usr/share/doc/${PF}" docsdir="/usr/share/doc/${PF}" install || die

	dodoc AUTHORS ChangeLog NEWS README
}
