# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/sys-apps/less/less-376.ebuild,v 1.6 2002/09/14 15:51:25 bjb Exp $

DESCRIPTION="Excellent text file viewer"
HOMEPAGE="http://www.greenwoodsoftware.com"
KEYWORDS="x86 ppc sparc sparc64 alpha"
SLOT="0"
LICENSE="GPL-2"
S=${WORKDIR}/${P}
SRC_URI="http://www.greenwoodsoftware.com/less/${P}.tar.gz"

DEPEND="virtual/glibc >=sys-libs/ncurses-5.2"

src_compile() {
	./configure --host=${CHOST} --prefix=/usr || die
	emake || die
}

src_install() {
	dobin less lessecho lesskey
	exeinto /usr/bin ; newexe ${FILESDIR}/lesspipe.sh-r1 lesspipe.sh
	dodoc COPYING NEWS README LICENSE
	newman lesskey.nro lesskey.1
	newman less.nro less.1
}
