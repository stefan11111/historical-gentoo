# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/openrdate/openrdate-1.2.ebuild,v 1.1 2008/11/27 10:51:26 robbat2 Exp $

inherit autotools

DESCRIPTION="use TCP or UDP to retrieve the current time of another machine"
HOMEPAGE="http://sourceforge.net/projects/openrdate/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64 ~ppc"
IUSE=""

DEPEND="virtual/libc"
RDEPEND="${DEPEND}"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${PN}-1.1.3-rename.patch
	eautomake
	mv docs/{,open}rdate.8
}

src_install(){
	emake -j1 DESTDIR="${D}" install || die "make install failed"
	newinitd "${FILESDIR}"/openrdate-initd openrdate
	newconfd "${FILESDIR}"/openrdate-confd openrdate
}
