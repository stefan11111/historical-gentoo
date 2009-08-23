# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-misc/apertium/apertium-3.1.0.ebuild,v 1.3 2009/08/23 12:25:51 flameeyes Exp $

DESCRIPTION="Apertium - An open-source shallow-transfer machine Translation engine and toolbox"
HOMEPAGE="http://apertium.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""
DEPEND="virtual/libiconv
		sci-misc/lttoolbox"
RDEPEND="$DEPEND"

src_compile() {
	econf || die "econf failed"
	emake -j1 || die "emake failed"
}

src_install() {
	emake install DESTDIR="${D}" || die "emake install failed"
	dodoc README-MODES README AUTHORS ChangeLog || die "failed"
}
