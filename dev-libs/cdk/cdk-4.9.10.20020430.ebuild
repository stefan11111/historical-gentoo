# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/cdk/cdk-4.9.10.20020430.ebuild,v 1.9 2003/09/06 22:29:24 msterret Exp $


MY_P=${P/.2002/-2002}

S=${WORKDIR}/${MY_P}
DESCRIPTION="A library of curses widgets"
SRC_URI="ftp://invisible-island.net/cdk/${MY_P}.tgz"
HOMEPAGE="http://dickey.his.com/cdk/cdk.html"

SLOT="0"
LICENSE="BSD"
KEYWORDS="ppc x86 sparc alpha"

DEPEND=">=sys-libs/ncurses-5.2"

src_compile()
{
	econf \
		--with-ncurses \
		|| die "configure failed"

	emake || die "make failed!"
}


src_install()
{
	make \
		DESTDIR=${D} \
		DOCUMENT_DIR=${D}/usr/share/doc/${MY_P} install \
		|| die "make install failed"
}
