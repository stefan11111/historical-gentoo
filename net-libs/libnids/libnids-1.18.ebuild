# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-libs/libnids/libnids-1.18.ebuild,v 1.7 2005/02/25 00:43:39 ka0ttic Exp $

inherit eutils

DESCRIPTION="emulates the IP stack of Linux 2.0.x and offers IP defragmentation, TCP stream assembly and TCP port scan detection."
HOMEPAGE="http://www.packetfactory.net/Projects/libnids/"
SRC_URI="http://www.packetfactory.net/Projects/libnids/dist/${P/_}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="1.1"
KEYWORDS="x86 ~ppc ~sparc ~alpha"
IUSE=""

DEPEND="virtual/libpcap
	>=net-libs/libnet-1.1.0-r3"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${P}-chksum.c-ebx.patch
}

src_compile() {
	econf --enable-shared || die "econf failed"
	make || die "emake failed"
}

src_install() {
	einstall || die "make install failed"
	dodoc CHANGES COPYING CREDITS MISC README
}
