# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-pda/gtkpod/gtkpod-0.70.ebuild,v 1.5 2004/07/14 01:37:38 agriffis Exp $

DESCRIPTION="GUI for iPod using GTK2"

HOMEPAGE="http://gtkpod.sourceforge.net/"

SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"

SLOT="0"

KEYWORDS="x86"

IUSE="mpeg4"

DEPEND=">=x11-libs/gtk+-2.0.0
		>=x11-libs/pango-1.2.1
		media-libs/id3lib
		mpeg4? ( media-video/mpeg4ip )"

# Run-time dependencies, same as DEPEND if RDEPEND isn't defined:
#RDEPEND=""


src_compile() {
	econf || die
	emake || die
}

src_install() {
	einstall || die
	dodoc README
}
