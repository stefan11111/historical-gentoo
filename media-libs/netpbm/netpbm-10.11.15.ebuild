# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/netpbm/netpbm-10.11.15.ebuild,v 1.7 2004/06/25 03:07:32 agriffis Exp $

inherit flag-o-matic gcc

DESCRIPTION="A set of utilities for converting to/from the netpbm (and related) formats"
HOMEPAGE="http://netpbm.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc ~sparc ~mips ~alpha ~hppa amd64 ~ia64"
IUSE="svga jpeg tiff png zlib"

DEPEND="jpeg? ( >=media-libs/jpeg-6b )
	tiff? ( >=media-libs/tiff-3.5.5 )
	png? ( >=media-libs/libpng-1.2.1 )
	zlib? ( sys-libs/zlib )
	svga? ( media-libs/svgalib )"

src_unpack() {
	unpack ${A}
	cd ${S}
	cp Makefile.config.in Makefile.config

	if use svga ; then
		echo "LINUXSVGAHDR_DIR = /usr/include" >> Makefile.config
		echo "LINUXSVGALIB = /usr/lib/libvga.so" >> Makefile.config
	fi

	if use jpeg ; then
		echo "JPEGLIB = libjpeg.so" >> Makefile.config
	fi

	if use png ; then
		echo "PNGLIB = libpng.so" >> Makefile.config
	fi

	if use tiff ; then
		echo "TIFFLIB = libtiff.so" >> Makefile.config
	fi

	if use zlib ; then
		echo "ZLIB = libz.so" >> Makefile.config
	fi

	# Sparc support ...
	replace-flags "-mcpu=ultrasparc" "-mcpu=v8 -mtune=ultrasparc"
	replace-flags "-mcpu=v9" "-mcpu=v8 -mtune=v9"

	sed -i -e "s:-O3:${CFLAGS} -fPIC:" Makefile.config || die " sed failed"
}

src_compile() {
	emake -j1 CC="$(gcc-getCC)" CXX="$(gcc-getCXX)" || die "emake failed"
}

src_install() {
	make package pkgdir=${D}/usr/ || die "make package failed"

	# Fix symlink not being created.
	dosym `basename ${D}/usr/lib/libnetpbm.so.*` /usr/lib/libnetpbm.so

	dodir /usr/share
	rm -rf ${D}/usr/bin/doc.url
	rm -rf ${D}/usr/man/web
	rm -rf ${D}/usr/link
	rm -rf ${D}/usr/README
	rm -rf ${D}/usr/pkginfo
	mv ${D}/usr/man/ ${D}/usr/share/man

	dodoc README
	export GLOBIGNORE='*.html:.*'
	cd doc && \
		dodoc * && \
		dohtml -r . || die "doc install failed"
}
