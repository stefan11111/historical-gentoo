# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-i18n/libguess/libguess-1.0.ebuild,v 1.2 2011/01/12 15:14:17 xarthisius Exp $

EAPI=2

DESCRIPTION="A high-speed character set detection library."
HOMEPAGE="http://www.atheme.org/project/libguess"
SRC_URI="http://distfiles.atheme.org/${P}.tbz2"

LICENSE="BSD-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64"
IUSE="examples"

RDEPEND="
	>=dev-libs/libmowgli-0.7.0"

DEPEND="${RDEPEND}
	>=dev-util/pkgconfig-0.9.0"

src_configure() {
	econf $(use_enable examples) \
		|| die "econf failed"
}

src_test() {
	cd src/tests
	make || die "test failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc README
}
