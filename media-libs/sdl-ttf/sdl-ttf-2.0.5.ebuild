# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/media-libs/sdl-ttf/sdl-ttf-2.0.5.ebuild,v 1.2 2002/07/11 06:30:39 drobbins Exp $

MY_P="${P/sdl-/SDL_}"
S="${WORKDIR}/${MY_P}"
DESCRIPTION="library that allows you to use TrueType fonts in SDL applications"
SRC_URI="http://www.libsdl.org/projects/SDL_ttf/release/${MY_P}.tar.gz"
HOMEPAGE="http://www.libsdl.org/projects/SDL_ttf/"

DEPEND=">=media-libs/libsdl-1.2.4
	>=media-libs/freetype-2.0.1"


src_compile() {

	./configure --infodir=/usr/share/info \
		--mandir=/usr/share/man \
		--prefix=/usr \
		--host=${CHOST} || die
		
	emake || die
}

src_install() {

	make prefix=${D}/usr install || die

	dodoc CHANGES COPYING README
}
