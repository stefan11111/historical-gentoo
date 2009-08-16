# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/wmfrog/wmfrog-0.2.0.ebuild,v 1.2 2009/08/16 17:22:38 gentoofan23 Exp $

inherit toolchain-funcs

DESCRIPTION="a weather application, it shows the weather in a graphical way."
HOMEPAGE="http://wiki.colar.net/wmfrog_dockapp"
SRC_URI="mirror://sourceforge/${PN}/${P}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~ppc ~sparc ~x86"
IUSE=""

RDEPEND="x11-libs/libXext
	x11-libs/libXpm
	x11-libs/libX11"
DEPEND="${RDEPEND}
	x11-proto/xextproto"

S=${WORKDIR}/Src

src_compile() {
	emake CC="$(tc-getCC)" CFLAGS="${CFLAGS}" INCDIR="" \
		LIBDIR="" || die "emake failed."
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed."
	dodoc ../{CHANGES,HINTS}
}
