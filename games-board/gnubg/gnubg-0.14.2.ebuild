# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-board/gnubg/gnubg-0.14.2.ebuild,v 1.11 2004/12/28 16:04:05 vapier Exp $

inherit gnuconfig flag-o-matic games

WPV="0.14"
DESCRIPTION="GNU BackGammon"
HOMEPAGE="http://www.gnu.org/software/gnubg/gnubg.html"
SRC_URI="ftp://alpha.gnu.org/gnu/gnubg/${P}.tar.gz
	ftp://alpha.gnu.org/gnu/gnubg/${PN}.weights-${WPV}.gz
	ftp://alpha.gnu.org/gnu/gnubg/gnubg_os0.bd.gz
	ftp://alpha.gnu.org/gnu/gnubg/gnubg_ts0.bd.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="-amd64 ~ppc ~sparc x86"
IUSE="gtk gtk2 readline python guile X gdbm truetype nls png esd arts nas opengl"

# FIXME does this need to DEPEND on netpbm?
RDEPEND="guile? ( dev-util/guile )
	python? ( dev-lang/python )
	truetype? ( =media-libs/freetype-1* )
	gtk? (
		gtk2? (
			=x11-libs/gtk+-2*
			=dev-libs/glib-2*
		)
		!gtk2? (
			=x11-libs/gtk+-1.2*
			=dev-libs/glib-1*
		)
		opengl? ( x11-libs/gtkglext media-libs/ftgl )
	)
	readline? ( sys-libs/readline )
	X? ( virtual/x11 )
	gdbm? ( sys-libs/gdbm )
	esd? ( media-sound/esound )
	arts? ( kde-base/arts )
	nas? ( media-libs/nas )
	png? ( media-libs/libpng )"
DEPEND="${RDEPEND}
	nas? ( >=sys-apps/sed-4 )"

src_unpack() {
	unpack ${A}
	cd ${S}
	mv ../${PN}.weights-${WPV} ${S}/${PN}.weights
	mv ../*bd .
	if  use nas ; then
		# couldn't find -laudio without this.  Very odd.
		sed -i \
			-e "s:-laudio:-L/usr/X11R6/lib/ -laudio:" configure.in \
			|| die "sed configure.in failed"
	fi
	gnuconfig_update
}

src_compile() {
	local myconf=
	if use gtk ; then
		# doesn't make any sense to add this without gtk or gtk2
		if has_version x11-libs/gtk+extra ; then
			myconf="--with-gtkextra"
		else
			myconf="--without-gtkextra"
		fi
		# --with-gtk doesn't mean what you think it means for configuring gnubg.
		if use gtk2 ; then
			myconf="${myconf} --with-gtk --with-gtk2"
		else
			myconf="${myconf} --with-gtk --without-gtk2"
		fi
		if use opengl ; then
			myconf="${myconf} --with-board3d"
			append-flags $(pkg-config ftgl --cflags)
		fi
	else
		myconf="${myconf} --disable-gtktest --without-board3d"
	fi
	if use esd || use arts ; then
		myconf="${myconf} --with-sound"
	else
		myconf="${myconf} --without-sound --disable-esdtest --disable-artsc-test"
	fi

	filter-flags -ffast-math #bug #67929

	# configure script doesn't handle this option correctly.
	#       `use_with guile` \
	egamesconf \
		$(use_with python) \
		$(use_enable esd) \
		$(use_enable arts artsc) \
		$(use_enable nas) \
		$(use_with readline) \
		$(use_with X x) \
		$(use_with gdbm) \
		$(use_with truetype freetype) \
		$(use_enable nls) \
		${myconf} \
		|| die
	emake || die "emake failed"
}

src_install() {
	make DESTDIR="${D}" install || die "make install failed"
	insinto "${GAMES_DATADIR}/${PN}"
	doins ${PN}.weights
	doins *bd
	dodoc AUTHORS README NEWS
	prepgamesdirs
}
