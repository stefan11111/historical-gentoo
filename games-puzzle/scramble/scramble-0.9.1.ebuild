# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-puzzle/scramble/scramble-0.9.1.ebuild,v 1.3 2004/11/11 12:43:25 wolf31o2 Exp $

inherit games

DESCRIPTION="Create as many words as you can before the time runs out"
HOMEPAGE="http://www.shiftygames.com/scramble/scramble.html"
SRC_URI="http://www.shiftygames.com/scramble/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~ppc ~amd64"
IUSE=""

DEPEND=">=media-libs/libsdl-1.2
	>=media-libs/sdl-mixer-1.2
	>=media-libs/sdl-image-1.2
	media-libs/sdl-ttf"
RDEPEND="${DEPEND}
	sys-apps/miscfiles"

src_install() {
	make DESTDIR="${D}" install || die "make install failed"
	prepgamesdirs
}
