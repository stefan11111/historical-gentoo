# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-util/gamepick/gamepick-0.35.ebuild,v 1.3 2006/09/27 12:14:16 nyhm Exp $

inherit eutils games

DESCRIPTION="Launch opengl games with custom graphic settings"
HOMEPAGE="http://www.rillion.net/gamepick/index.html"
SRC_URI="http://www.rillion.net/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

DEPEND="=x11-libs/gtk+-2*"

src_unpack() {
	unpack ${A}
	cd "${S}"

	sed -i "s:/etc:${GAMES_SYSCONFDIR}:" src/gamepick.h \
		|| die "sed gamepick.h failed"

	sed -i 's/-O2//' src/Makefile.in \
		|| die "sed Makefile.in failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"

	dodir "${GAMES_SYSCONFDIR}"
	touch "${D}/${GAMES_SYSCONFDIR}"/${PN}.conf

	newicon gamepick-48x48.xpm ${PN}.xpm
	make_desktop_entry ${PN} ${PN} ${PN}.xpm

	dodoc AUTHORS ChangeLog README
	prepgamesdirs
}
