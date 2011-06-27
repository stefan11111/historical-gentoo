# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/wavplay/wavplay-2.0.ebuild,v 1.1 2011/06/27 06:06:51 radhermit Exp $

EAPI=4

inherit autotools

DESCRIPTION="A command line player/recorder for wav files"
HOMEPAGE="http://sourceforge.net/projects/wavplay/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

src_prepare() {
	sed -i -e "/dist_pkgdata/d" src/Makefile.am
	eautoreconf
}

src_configure() {
	econf --enable-nox
}
