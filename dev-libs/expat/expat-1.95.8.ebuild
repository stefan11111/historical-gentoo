# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/expat/expat-1.95.8.ebuild,v 1.14 2005/02/21 04:55:59 vapier Exp $

inherit libtool

DESCRIPTION="XML parsing libraries"
HOMEPAGE="http://expat.sourceforge.net/"
SRC_URI="mirror://sourceforge/expat/${P}.tar.gz"

LICENSE="as-is"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 mips ppc ppc64 ppc-macos s390 sh sparc x86"
IUSE="test"

DEPEND="virtual/libc
	test? ( >=dev-libs/check-0.8 )"
RDEPEND="virtual/libc"

src_unpack() {
	unpack ${A}
	cd "${S}"
	uclibctoolize
}

src_test() {
	if ! use test && [[ -z $(best_version dev-libs/check) ]] ; then
		ewarn "You dont have USE=test and dev-libs/check is not installed."
		ewarn "src_test will be skipped."
		return 0
	fi
	make check || die "make check failed"
}

src_install() {
	einstall man1dir="${D}/usr/share/man/man1" || die "einstall failed"
	dosed /usr/$(get_libdir)/libexpat.la #81568
	dodoc Changes README
	dohtml doc/*
}
