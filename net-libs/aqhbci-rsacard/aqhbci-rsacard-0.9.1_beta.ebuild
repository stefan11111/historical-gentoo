# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-libs/aqhbci-rsacard/aqhbci-rsacard-0.9.1_beta.ebuild,v 1.2 2005/02/01 23:51:52 hanno Exp $

DESCRIPTION="RSA-Card plugin for aqhbci"
HOMEPAGE="http://www.aquamaniac.de/aqbanking/"
SRC_URI="mirror://sourceforge/aqhbci/${P/_/}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE="debug"
DEPEND=">=net-libs/aqhbci-0.9.6_beta
	>=sys-libs/libchipcard-0.9.9_beta"
S=${WORKDIR}/${P/_/}

src_compile() {
	econf `use_enable debug` || die
	emake || die
}

src_install() {
	make DESTDIR=${D} install || die
	dodoc AUTHORS ChangeLog
}
