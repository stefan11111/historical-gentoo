# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/kaffe/kaffe-1.1.0.ebuild,v 1.3 2003/10/05 15:52:33 dholm Exp $

inherit java

S=${WORKDIR}/${P/_/-}
DESCRIPTION="A cleanroom, open source Java VM and class libraries"
SRC_URI="http://www.kaffe.org/ftp/pub/kaffe/v1.1.x-development/${P/_/-}.tar.gz"
HOMEPAGE="http://www.kaffe.org/"
DEPEND=">=dev-libs/gmp-3.1
	>=media-libs/jpeg-6b
	>=media-libs/libpng-1.2.1
	virtual/glibc
	virtual/x11
	>=dev-java/java-config-0.2.4"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc"

src_unpack() {
	unpack ${A}
}

src_compile() {
	./configure --host=${CHOST} \
		    --prefix=/opt/${P}
	make || die
}

src_install () {
	make DESTDIR=${D} install || die

	set_java_env ${FILESDIR}/${VMHANDLE} || die
}
