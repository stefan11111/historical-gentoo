# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/athcool/athcool-0.3.0.ebuild,v 1.2 2003/08/10 07:39:52 vapier Exp $

DESCRIPTION="small utility to toggle Powersaving mode for AMD Athlon/Duron processors"
HOMEPAGE="http://members.jcom.home.ne.jp/jacobi/linux/softwares.html#athcool"
SRC_URI="http://members.jcom.home.ne.jp/jacobi/linux/files/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="-* ~x86"

DEPEND="sys-apps/pciutils"

src_compile() {
	emake || die
}

src_install() {
	einstall || die
	exeinto /etc/init.d
	doexe ${FILESDIR}/athcool
}
