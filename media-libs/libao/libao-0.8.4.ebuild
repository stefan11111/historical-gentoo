# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/libao/libao-0.8.4.ebuild,v 1.2 2003/10/18 22:54:00 brad_mssw Exp $

IUSE="esd"

S=${WORKDIR}/${P}
DESCRIPTION="the audio output library"
SRC_URI="http://www.xiph.org/ao/src/${P}.tar.gz"
HOMEPAGE="http://www.xiph.org/ogg/vorbis/index.html"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~ppc ~sparc ~alpha ~hppa amd64"

DEPEND="virtual/glibc
	esd? ( >=media-sound/esound-0.2.22 )"

src_compile() {
	econf \
		--enable-shared \
		--enable-static || die

	emake || die
}

src_install () {
	make DESTDIR=${D} install || die

	rm -rf ${D}/usr/share/doc
	dodoc AUTHORS CHANGES COPYING README TODO
	dodoc doc/API doc/DRIVERS doc/USAGE doc/WANTED
}
