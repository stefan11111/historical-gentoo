# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-db/m17n-db/m17n-db-1.1.0.ebuild,v 1.4 2004/12/12 03:45:09 weeve Exp $

DESCRIPTION="Database for the m17n library"
HOMEPAGE="http://www.m17n.org/m17n-lib/"
SRC_URI="http://www.m17n.org/m17n-lib/download/${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="x86 alpha ppc amd64 ~ppc64 sparc"

IUSE=""

DEPEND=""

src_install() {
	make DESTDIR=${D} install || die

	dodoc AUTHORS ChangeLog NEWS README
	docinto FORMATS; dodoc FORMATS/*
	docinto UNIDATA; dodoc UNIDATA/*
}
