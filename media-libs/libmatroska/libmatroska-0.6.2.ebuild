# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/libmatroska/libmatroska-0.6.2.ebuild,v 1.2 2004/01/17 05:14:17 darkspecter Exp $

IUSE=""

S=${WORKDIR}/${P}

DESCRIPTION="Extensible multimedia container format based on EBML."
SRC_URI="http://matroska.free.fr/downloads/${PN}/${P}.tar.gz"
HOMEPAGE="http://www.matroska.org"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ppc ~amd64"

DEPEND="virtual/glibc
	~media-libs/libebml-0.6.3"

src_compile() {
	cd ${S}/make/linux
	sed -i -e 's/CXXFLAGS=/CXXFLAGS+=/g' Makefile
	make PREFIX=/usr \
		LIBEBML_INCLUDE_DIR=/usr/include/ebml \
		LIBEBML_LIB_DIR=/usr/lib || die "make failed"
}

src_install () {
	cd ${S}/make/linux
	einstall || die "make install failed"
	dodoc ${S}/LICENSE.*
}
