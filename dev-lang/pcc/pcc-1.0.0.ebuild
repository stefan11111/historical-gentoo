# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lang/pcc/pcc-1.0.0.ebuild,v 1.1 2011/04/04 10:21:36 patrick Exp $

EAPI=2

inherit eutils versionator autotools

DESCRIPTION="pcc portable c compiler"
HOMEPAGE="http://pcc.ludd.ltu.se"

SRC_URI="ftp://pcc.ludd.ltu.se/pub/pcc-releases/${P}.tgz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""
DEPEND=">=dev-libs/pcc-libs-${PV}"
RDEPEND="${DEPEND}"

src_prepare() {
	sed -i -e 's/AC_CHECK_PROG(strip,strip,yes,no)//' configure.ac || die "Failed to fix configure.ac"
	sed -i -e 's/AC_SUBST(strip)//' configure.ac || die "Failed to fix configure.ac more"
	eautoreconf
}

src_compile() {
	# not parallel-safe yet
	emake -j1 || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
}
