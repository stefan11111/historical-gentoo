# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/media-libs/freetype/freetype-1.3.1-r1.ebuild,v 1.4 2000/11/01 04:44:16 achim Exp $

P=freetype-1.3.1
A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="TTF-Library"
SRC_URI="ftp://ftp.freetype.org/pub/freetype1/"${A}
HOMEPAGE="http://www.freetype.org/"

DEPEND=">=sys-libs/glibc-2.1.3
	>=x11-base/xfree-4.0.1"

src_compile() {                           
  cd ${S}
  try ./configure --host=${CHOST} --prefix=/usr
  try make
}

src_install() {                               
  cd ${S}
  try make prefix=${D}/usr install
  dodoc announce PATENTS README readme.1st
  dodoc docs/*.txt docs/FAQ docs/TODO
  docinto html
  dodoc docs/*.htm
  docinto html/image
  dodoc docs/image/*.gif docs/image/*.png
}




