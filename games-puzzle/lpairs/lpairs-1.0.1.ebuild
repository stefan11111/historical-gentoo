# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-puzzle/lpairs/lpairs-1.0.1.ebuild,v 1.5 2004/06/04 20:42:34 jhuebel Exp $

inherit games

DESCRIPTION="Kids card/puzzle game"
SRC_URI="mirror://sourceforge/lgames/${P}.tar.gz"
HOMEPAGE="http://lgames.sourceforge.net/index.php?project=LPairs"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~ppc ~amd64"
IUSE=""

DEPEND="virtual/x11
	media-libs/libsdl"

src_compile() {
	egamesconf \
		--datadir="${GAMES_DATADIR_BASE}" \
		|| die
	emake || die "emake failed"
}

src_install() {
	make install DESTDIR="${D}" || die
	dodoc README AUTHORS TODO ChangeLog
	prepgamesdirs
}
