# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-action/moon-buggy/moon-buggy-1.0.ebuild,v 1.4 2005/09/02 19:39:35 hansmi Exp $

inherit eutils games

DESCRIPTION="A simple console game, where you drive a car across the moon's surface"
HOMEPAGE="http://www.seehuhn.de/comp/moon-buggy.html"
SRC_URI="http://www.seehuhn.de/data/${P}.tar.gz
	esd? ( http://www.seehuhn.de/data/${PN}-sound-${PV}.tar.gz )"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc x86"
IUSE="esd"

DEPEND=">=sys-libs/ncurses-5
	esd? ( media-sound/esound )"

src_unpack() {
	unpack ${A}
	cd "${S}"
	sed -i \
		-e '/$(DESTDIR)$(bindir)\/moon-buggy -c/d' \
		Makefile.am \
		|| die "sed Makefile.in failed"
	use esd && epatch sound.patch
	rm -f missing
	autoreconf -i || die "autoreconf failed"
}

src_compile() {
	egamesconf --sharedstatedir="${GAMES_STATEDIR}" || die
	emake || die "emake failed"
}

src_install() {
	make install DESTDIR="${D}" || die "make install failed"
	dodoc ANNOUNCE AUTHORS ChangeLog NEWS README* TODO
	touch "${D}${GAMES_STATEDIR}"/${PN}/mbscore
	fperms 664 "${GAMES_STATEDIR}"/${PN}/mbscore
	prepgamesdirs
}
