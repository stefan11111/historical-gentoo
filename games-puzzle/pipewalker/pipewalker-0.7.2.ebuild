# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-puzzle/pipewalker/pipewalker-0.7.2.ebuild,v 1.1 2009/08/26 10:53:06 nyhm Exp $

EAPI=2
inherit eutils games

DESCRIPTION="Rotating pieces puzzle game"
HOMEPAGE="http://pipewalker.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}-src.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="media-libs/libsdl[opengl]
	virtual/opengl
	virtual/glu"

src_configure() {
	egamesconf \
		--disable-dependency-tracking \
		--datadir="${GAMES_DATADIR_BASE}"
}

src_install() {
	emake -C data DESTDIR="${D}" install || die "emake install failed"
	dogamesbin src/${PN} || die "dogamesbin failed"
	doicon extra/${PN}.xpm
	make_desktop_entry ${PN} PipeWalker
	dodoc AUTHORS ChangeLog README
	prepgamesdirs
}
