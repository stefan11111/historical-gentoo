# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/banner/banner-1.2.1.ebuild,v 1.4 2004/03/14 10:48:48 mr_bones_ Exp $

DESCRIPTION="The well known banner program for linux"
HOMEPAGE="http://cedar-solutions.com"
SRC_URI="http://cedar-solutions.com/software/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~ppc amd64"
IUSE=""

DEPEND="virtual/glibc"

src_compile() {
	econf
	emake || die
}

src_install() {
	einstall
	dodoc README AUTHORS COPYING INSTALL
}
