# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/vlorb/vlorb-1.2.ebuild,v 1.3 2004/12/19 06:50:31 eradicator Exp $

IUSE="oggvorbis"

DESCRIPTION="a high quality Audio CD to audio file encoder"
HOMEPAGE="http://jk.yazzy.org/projects/vlorb/"
SRC_URI="http://jk.yazzy.org/projects/vlorb/releases/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc sparc x86"

DEPEND=">=media-sound/cdparanoia-3.9.8
	>=dev-perl/CDDB-1.12
	oggvorbis? ( >=media-sound/vorbis-tools-1.0.1 )"

src_compile() {
	einfo "Nothing to compile"
}

src_install() {
	dodoc ChangeLog README
	dobin vlorb
	doman vlorb.1
}
