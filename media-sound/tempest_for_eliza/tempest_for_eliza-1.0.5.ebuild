# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/tempest_for_eliza/tempest_for_eliza-1.0.5.ebuild,v 1.1 2003/07/11 20:15:48 vapier Exp $

DESCRIPTION=""
HOMEPAGE="http://www.erikyyy.de/tempest/"
SRC_URI="http://www.erikyyy.de/tempest/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND="media-libs/libsdl"

src_install() {
	make install DESTDIR=${D} || die

	rm songs/Makefile*
	insinto /usr/share/${PN}
	doins songs/*

	dodoc AUTHORS ChangeLog NEWS README
}
