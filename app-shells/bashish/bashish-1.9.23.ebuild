# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-shells/bashish/bashish-1.9.23.ebuild,v 1.2 2005/01/01 15:57:13 eradicator Exp $

inherit eutils

DESCRIPTION="Text console theme engine"
HOMEPAGE="http://bashish.sourceforge.net/"
SRC_URI="mirror://sourceforge/bashish/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc ~sparc ~alpha"
IUSE=""

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${PV}-fix-install.patch
}

src_install() {
	./InstallBashish \
		${D}/usr/share/bashish \
		${D}/usr/bin \
		${D}/usr/share/bashish/doc \
		|| die
	dobin bashish
	dosed /usr/bin/bashish
	insinto /usr/share/bashish/modules/sh/conf
	doins ${FILESDIR}/bashish.conf
}
