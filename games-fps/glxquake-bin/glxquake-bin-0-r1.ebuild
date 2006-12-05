# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-fps/glxquake-bin/glxquake-bin-0-r1.ebuild,v 1.3 2006/12/05 15:11:49 wolf31o2 Exp $

inherit games

DESCRIPTION="a binary that works with every 3D-graphics-card that supports the glx X-extension"
HOMEPAGE="http://mfcn.ilo.de/glxquake/"
SRC_URI="http://www.wh-hms.uni-ulm.de/~mfcn/shared/glxquake/glxquake.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="-* amd64 x86"
RESTRICT="strip"
IUSE=""

RDEPEND="sys-libs/glibc
	virtual/opengl
	x86? (
		x11-libs/libX11
		x11-libs/libXext
		x11-libs/libXxf86vm
		x11-libs/libdrm
		x11-libs/libXau
		x11-libs/libXdmcp )
	amd64? ( app-emulation/emul-linux-x86-xlibs )"

S=${WORKDIR}/glxquake

src_install() {
	dogamesbin glquake || die "dogamesbin failed"
	dodoc README
	prepgamesdirs
}

pkg_postinst() {
	games_pkg_postinst
	einfo "To play with it, create a subdirectory called id1"
	einfo "Copy the pak0.pak, and eventually pak1.pak into this subdirectory"
	einfo "You can eventually get pak0.pak emerging games-fps/quake1-demodata"
	einfo "The file pak0.pak will be on the ${GAMES_DATADIR}/quake1/demo/"
	einfo "You can now run glxquake by executing glquake"
}
