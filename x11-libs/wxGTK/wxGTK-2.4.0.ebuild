# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-libs/wxGTK/wxGTK-2.4.0.ebuild,v 1.17 2004/06/24 00:19:16 agriffis Exp $

DESCRIPTION="GTK+ version of wxWindows, a cross-platform C++ GUI toolkit."
SRC_URI="mirror://sourceforge/wxwindows/${P}.tar.bz2"
HOMEPAGE="http://www.wxwindows.org/"

LICENSE="wxWinLL-3"
SLOT="0"
KEYWORDS="x86 ~ppc ~sparc ~alpha"
IUSE="nls odbc opengl gtk2"

DEPEND="virtual/glibc
	virtual/x11
	media-libs/netpbm
	media-libs/giflib
	media-libs/libpng
	media-libs/jpeg
	media-libs/tiff
	sys-libs/zlib
	odbc? ( dev-db/unixODBC  )
	opengl? ( virtual/opengl )
	gtk2? (
		>=x11-libs/gtk+-2.0*
		dev-libs/libunicode
	)
	!gtk2? ( =x11-libs/gtk+-1.2* )"

RDEPEND="nls? ( sys-devel/gettext )"

pkg_setup() {
	# xfree should not install these, remove until the fixed
	# xfree is in main use.
	rm -f /usr/X11R6/include/{zconf.h,zlib.h}
}

src_compile() {
	local myconf
	myconf="--enable-gif --with-libtiff --with-zlib --with-libpng \
		--enable-png --with-libjpeg"

	#Note: pcx image support enabled by default if found.
	#Also, all wxWindows gui features are enabled by default. If you
	#want to build a smaller library you can disable features by adding
	#the appropriate flags to myconf (see INSTALL.txt).

	#The build tools include a --with-freetype option, however it doesn't
	#seem to be implemented in the source yet.

	#confiure options that have corresponding USE variable.

	use static \
		&& myconf="${myconf} --enable-static" \
		|| myconf="${myconf} --disable-static"

	# Note: ODBC support does not work with --enable-unicode
	#       We only use --enable-unicode (if at all) when we use
	#       gtk2.

	if use odbc && ! use gtk2; then
		myconf="${myconf} --with-odbc"
	elif use odbc && use gtk2; then
		ewarn ""
		einfo "you cannot specify both odbc and gtk2"
		einfo "Choosing gtk2 over odbc"
		einfo "re-run with USE=\"-gtk2\" to enable odbc"
		ewarn ""
		sleep 5
		myconf="${myconf} --without-odbc"
	else
		myconf="${myconf} --without-odbc"
	fi

	use opengl \
		&& myconf="${myconf} --with-opengl" \
		|| myconf="${myconf} --without-opengl"

	myconf="${myconf} --with-x --with-gtk"

	# here we disable unicode support even thought gtk2 supports it
	# because too many apps just don't follow the wxWindows guidelines
	# for unicode support.
	#
	# http://www.wxwindows.org/manuals/2.4.0/wx458.htm#unicode
	#
	# ref #20116 - liquidx@gentoo.org (07 May 2003)

	#use gtk2 && myconf="${myconf} --enable-gtk2 --enable-unicode"
	use gtk2 && myconf="${myconf} --enable-gtk2"

	econf ${myconf} || die "econf failed"
	emake || die "make failed"
}

src_install() {
	einstall
	dodoc *.txt
}
