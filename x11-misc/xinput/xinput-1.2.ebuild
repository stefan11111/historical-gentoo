# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/xinput/xinput-1.2.ebuild,v 1.8 2006/11/29 19:02:13 genstef Exp $

DESCRIPTION="An utility to set XInput device parameters"
HOMEPAGE="ftp://ftp.x.org/contrib/utilities/xinput.README"
SRC_URI="ftp://ftp.x.org/contrib/utilities/${P}.tar.gz"
LICENSE="as-is"

SLOT="0"
KEYWORDS="x86 ppc ~amd64"
IUSE=""

RDEPEND="x11-libs/libX11
	x11-libs/libXext
	x11-libs/libXi"
DEPEND="${RDEPEND}
	x11-misc/imake
	app-text/rman
	x11-proto/inputproto
	x11-misc/gccmakedep"

src_compile() {
	xmkmf -a || die
	emake CDEBUGFLAGS="${CDEBUGFLAGS}" || die
}

src_install() {
	make DESTDIR=${D} install install.man

	dodoc ChangeLog README
}
