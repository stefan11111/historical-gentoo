# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libhome/libhome-0.10.1.ebuild,v 1.2 2008/05/14 21:14:30 flameeyes Exp $

inherit autotools db-use eutils

DESCRIPTION="libhome is a library providing a getpwnam() emulation"
HOMEPAGE="http://pll.sourceforge.net"
SRC_URI="mirror://sourceforge/pll/${P}.tar.gz"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="berkdb ldap mysql pam postgres"

DEPEND="berkdb? ( =sys-libs/db-4* )
	ldap? ( net-nds/openldap )
	mysql? ( virtual/mysql )
	pam? ( virtual/pam )
	postgres? ( dev-db/postgresql )"
RDEPEND="${DEPEND}"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${P}-Makefile.patch
	eautoreconf
}

src_compile() {
	econf --without-db3 \
		$(use_with berkdb db4 $(db_includedir)) \
		$(use_with ldap) \
		$(use_with mysql) \
		$(use_with pam) \
		$(use_with postgres pgsql) \
	|| die "econf failed"
	emake || die "emake failed"
}

src_install() {
	make DESTDIR="${D}" install || die "make install failed"
}
