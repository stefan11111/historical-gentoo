# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-strategy/freeciv/freeciv-2.0.1.ebuild,v 1.6 2005/06/08 14:31:25 gustavoz Exp $

inherit games

MY_P=${PN}-${PV/_/-}
DESCRIPTION="multiplayer strategy game (Civilization Clone)"
HOMEPAGE="http://www.freeciv.org/"
SRC_URI="ftp://ftp.freeciv.org/pub/freeciv/stable/${MY_P}.tar.bz2
	!dedicated? (
		alsa? ( http://www.freeciv.org/ftp/contrib/sounds/sets/stdsounds2.tar.gz )
		esd? ( http://www.freeciv.org/ftp/contrib/sounds/sets/stdsounds2.tar.gz )
		sdl? ( http://www.freeciv.org/ftp/contrib/sounds/sets/stdsounds2.tar.gz )
	)"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha amd64 ~ppc sparc x86"
IUSE="alsa dedicated esd gtk gtk2 nls readline sdl Xaw3d"

RDEPEND="sys-libs/zlib
	readline? ( sys-libs/readline )
	!dedicated? (
		virtual/x11
		gtk? (
			gtk2? (
				>=x11-libs/gtk+-2.0.0
				>=dev-libs/glib-2.0.0
				>=dev-libs/atk-1.0.3
				>=x11-libs/pango-1.0.5
			)
			!gtk2? (
				=x11-libs/gtk+-1*
				>=dev-libs/glib-1.2.5
				>=media-libs/imlib-1.9.2
			)
		)
		!gtk? ( Xaw3d? ( x11-libs/Xaw3d ) )
		alsa? (
			>=media-libs/alsa-lib-1.0
			>=media-libs/audiofile-0.2
		)
		esd? ( >=media-sound/esound-0.2 )
		sdl? (
			>=media-libs/sdl-mixer-1.2
			>=media-libs/libsdl-1.2
		)
	)"
DEPEND="${RDEPEND}
	nls? ( sys-devel/gettext )"

S=${WORKDIR}/${MY_P}

pkg_setup() {
	games_pkg_setup
	if ! use dedicated ; then
		if use gtk ; then
			if use gtk2 ; then
				einfo "The Freeciv Client will be built with the GTK+-2 toolkit"
			else
				einfo "The Freeciv Client will be built with the GTK+-1.2 toolkit"
			fi
		elif use Xaw3d ; then
			einfo "The Freeciv Client will be built with the Xaw3d toolkit"
		else
			einfo "The Freeciv Client will be built with the Xaw toolkit"
		fi
		if ! use esd && ! use alsa && ! use sdl ; then
			ewarn
			ewarn "To enable sound support in civclient, you must enable"
			ewarn "at least one of this USE flags: alsa, esd, sdl"
			ewarn
		fi
	fi
}

src_unpack() {
	unpack ${A}
	cd "${S}"

	# install locales in /usr/share/locale
	sed -i \
		-e 's:^\(localedir = \).*:\1/usr/share/locale:' \
		intl/Makefile.in po/Makefile.in.in \
		|| die "sed failed"
	sed -i \
		-e '/^#define LOCALEDIR/s:".*":"/usr/share/locale":' \
		configure \
		|| die "sed failed"

	# install the .desktop in /usr/share/applications
	sed -i \
		-e 's:^\(desktopfiledir = \).*:\1/usr/share/applications:' \
		client/Makefile.in \
		|| die "sed failed"

	# remove civclient manpage if dedicated server
	if use dedicated ; then
		sed -i \
			-e '/man_MANS = /s:civclient.6::' \
			doc/man/Makefile.in \
			|| die "sed failed"
	fi
}

src_compile() {
	local mysoundconf
	local myclient

	if use dedicated ; then
		mysoundconf="--disable-alsa --disable-esd --disable-sdl-mixer"
		myclient="no"
	else
		myclient="xaw"
		use Xaw3d && myclient="xaw3d"
		if use gtk ; then
			use gtk2 \
				&& myclient="gtk-2.0" \
				|| myclient="gtk"
		fi
		#FIXME --enable-{alsa,esd,sdl-mixer} actually disable them...
		#FIXME   ==> use --disable-* only, and autodetect to enable.
		use alsa || mysoundconf="${mysoundconf} --disable-alsa"
		use esd || mysoundconf="${mysoundconf} --disable-esd"
		use sdl || mysoundconf="${mysoundconf} --disable-sdl-mixer"
	fi

	egamesconf \
		--disable-dependency-tracking \
		--with-zlib \
		$(use_enable nls) \
		$(use_with readline) \
		--enable-client=${myclient} \
		${mysoundconf} \
		|| die "egamesconf failed"

	emake || die "emake failed"
}

src_install() {
	make DESTDIR="${D}" install || die "make install failed"

	if ! use dedicated ; then
		# Install the app-defaults if Xaw/Xaw3d toolkit
		if ! use gtk ; then
			insinto /etc/X11/app-defaults
			doins data/Freeciv || die "doins failed"
		fi
		# Install sounds if at least one sound plugin was built
		if use alsa || use esd || use sdl ; then
			cp -R ../stdsounds* "${D}${GAMES_DATADIR}/${PN}" \
				|| die "failed to install sounds"
		fi
		# Create and install the html manual. It can't be done for dedicated
		# servers, because the 'civmanual' tool is then not built. Also
		# delete civmanual from the GAMES_BINDIR, because it's then useless.
		# Note: to have it localized, it should be ran from _postinst, or
		# something like that, but then it's a PITA to avoid orphan files...
		./manual/civmanual || die "civmanual failed"
		dohtml manual*.html || die "dohtml failed"
		rm -f "${D}/${GAMES_BINDIR}/civmanual"
	fi

	dodoc ChangeLog INSTALL NEWS \
		doc/{BUGS,CodingStyle,HACKING,HOWTOPLAY,PEOPLE,README*,TODO}

	prepgamesdirs
}
