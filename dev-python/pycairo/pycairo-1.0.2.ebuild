# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pycairo/pycairo-1.0.2.ebuild,v 1.16 2007/01/06 15:57:34 dev-zero Exp $

DESCRIPTION="Python wrapper for cairo vector graphics library"
HOMEPAGE="http://cairographics.org/pycairo"
SRC_URI="http://cairographics.org/releases/${P}.tar.gz"

LICENSE="|| ( LGPL-2.1 MPL-1.1 )"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 mips ppc ppc64 sh sparc x86"
IUSE="examples gtk numeric svg"

RDEPEND=">=dev-lang/python-2.3
	=x11-libs/cairo-1.0*
	gtk? ( >=dev-python/pygtk-2.2 )
	svg? ( >=x11-libs/libsvg-cairo-0.1.6 )
	numeric? ( dev-python/numeric )"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

src_compile() {
	# dev-python/numeric and libsvg-cairo are automatically 
	# detected by the ./configure script, so don't need to force
	econf $(use_with gtk pygtk)
	emake || die "emake failed"
}

src_install() {
	einstall || die "install failed"

	if use examples ; then
		insinto /usr/share/doc/${PF}/examples
		doins -r examples/*
		rm "${D}"/usr/share/doc/${PF}/examples/Makefile*
	fi

	dodoc AUTHORS NOTES README NEWS ChangeLog
}
