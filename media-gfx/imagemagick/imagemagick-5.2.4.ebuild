# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/media-gfx/imagemagick/imagemagick-5.2.4.ebuild,v 1.1 2000/09/20 19:57:21 achim Exp $

P=ImageMagick-5.2.4
A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="A collection of tools and libraries for many image formats"
SRC_URI="ftp://ftp.cdrom.com/pub/ImageMagick/${A}"
HOMEPAGE="http://www.imagemagick.org"


src_compile() {

    cd ${S}
    ./configure --prefix=/usr/X11R6 --host=${CHOST} \
		--without-perl --enable-lzw \
		--enable-shared --with-threads 
    make

}

src_install () {

    cd ${S}
    make prefix=${D}/usr/X11R6 install

}

