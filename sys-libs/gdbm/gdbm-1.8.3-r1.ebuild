# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-libs/gdbm/gdbm-1.8.3-r1.ebuild,v 1.13 2005/04/02 00:57:02 vapier Exp $

inherit flag-o-matic eutils libtool

DESCRIPTION="Standard GNU database libraries included for compatibility with Perl"
HOMEPAGE="http://www.gnu.org/software/gdbm/gdbm.html"
SRC_URI="mirror://gnu/gdbm/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 m68k mips ppc ppc64 s390 sh sparc x86"
IUSE="berkdb"

DEPEND="berkdb? ( sys-libs/db )"

src_unpack() {
	unpack ${A}
	cd "${S}"
	append-flags -fomit-frame-pointer
	uclibctoolize
}

src_compile() {
	econf || die
	use berkdb || sed -i '/HAVE_LIBNDBM/s:.*::' autoconf.h
	emake || die
}

src_install() {
	make INSTALL_ROOT="${D}" install || die

	make \
		includedir=/usr/include/gdbm \
		INSTALL_ROOT="${D}" \
		install-compat || die

	dodoc ChangeLog NEWS README

	# temp backwards support #32510
	if [[ -e ${ROOT}/usr/$(get_libdir)/libgdbm.so.2 ]] ; then
		cp ${ROOT}/usr/$(get_libdir)/libgdbm.so.2 ${D}/usr/$(get_libdir)/
		touch ${D}/usr/$(get_libdir)/libgdbm.so.2
	fi
}

pkg_postinst() {
	if [ -e ${ROOT}/usr/$(get_libdir)/libgdbm.so.2 ] ; then
		ewarn "Please run revdep-rebuild --soname libgdbm.so.2"
		ewarn "After that completes, it will be safe to remove the old"
		ewarn "library (${ROOT}/usr/$(get_libdir)/libgdbm.so.2)."
	fi
}
