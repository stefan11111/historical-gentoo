# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/media-libs/mpeg-lib/mpeg-lib-1.3.1-r1.ebuild,v 1.6 2002/07/11 06:30:39 drobbins Exp $

MY_P=${P/-/_}
S=${WORKDIR}/${MY_P}
DESCRIPTION="A lib for MPEG-1 video"
SRC_URI="ftp://ftp.mni.mcgill.ca/pub/mpeg/${MY_P}.tar.gz"
HOMEPAGE="http://"

DEPEND="virtual/glibc"

src_compile() {

	./configure --prefix=/usr --host=${CHOST} --disable-dither || die

	# Doesn't work with -j 4 (hallski)
	make OPTIMIZE="$CFLAGS" || die

}

src_install () {

	make prefix=${D}/usr install || die
	dodoc CHANGES README
	docinto txt
	dodoc doc/image_format.eps doc/mpeg_lib.*

}
