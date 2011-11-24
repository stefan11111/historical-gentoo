# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-auth/pam_mysql/pam_mysql-0.7_rc1-r4.ebuild,v 1.1 2011/11/24 18:27:15 hanno Exp $

EAPI=2
inherit autotools libtool pam

DESCRIPTION="pam_mysql is a module for pam to authenticate users with mysql"
HOMEPAGE="http://pam-mysql.sourceforge.net/"

SRC_URI="mirror://sourceforge/pam-mysql/${P/_rc/RC}.tar.gz"
DEPEND=">=sys-libs/pam-0.72 virtual/mysql"
RDEPEND="${DEPEND}"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~ppc ~sparc ~x86"
IUSE="openssl"
S="${WORKDIR}/${P/_rc/RC}"

src_prepare() {
	epatch "${FILESDIR}/${P}-link-to-pam.diff"
	epatch "${FILESDIR}/${P}-memleak.diff"
	eautoreconf
	elibtoolize
}

src_configure() {
	econf $(use_with openssl)
}

src_compile() {
	emake || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" libdir="$(getpam_mod_dir)" install || die "install failed"
	rm "${D}/$(getpam_mod_dir)/pam_mysql.la" || die "Failed to remove pam_mysql.la"
	dodoc CREDITS ChangeLog NEWS README
}
