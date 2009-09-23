# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/poink/poink-2.03.ebuild,v 1.8 2009/09/23 18:23:09 patrick Exp $

inherit eutils toolchain-funcs

DESCRIPTION="TCP/IP-based ping implementation"
HOMEPAGE="http://directory.fsf.org/security/system/poink.html"
SRC_URI="http://ep09.pld-linux.org/~mmazur/poink/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~ppc x86"
IUSE=""
DEPEND=""

src_unpack() {
	unpack ${A}
	epatch ${FILESDIR}/${PN}-2.03-signed-char-fixup.patch
}

src_compile() {
	emake CFLAGS="${CFLAGS}" CC="$(tc-getCC)" || die
}

src_install() {
	dobin poink poink6
	newman ping.1 poink.1
	dodoc README* ChangeLog COPYING
}
