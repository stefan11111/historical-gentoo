# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-tcltk/tkdnd/tkdnd-2.2.ebuild,v 1.1 2012/01/06 17:49:33 jlec Exp $

EAPI=4

inherit autotools-utils eutils

MY_PN="TkDND"

DESCRIPTION="Extension that adds native drag & drop capabilities to the tk toolkit"
HOMEPAGE="http://www.ellogon.org/petasis/tcltk-projects/tkdnd/"
SRC_URI="mirror://sourceforge/${PN}/${MY_PN}/${MY_PN}%20${PV}/${P/-/}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~x86"
IUSE="debug threads X"

RESTRICT="test"

DEPEND="dev-lang/tk"
RDEPEND=${DEPEND}

S=${WORKDIR}/${P/-/}

src_prepare() {
	sed \
		-e 's:-O2::g' \
		-e 's:-fomit-frame-pointer::g' \
		-e 's:-pipe::g' \
		-i configure tclconfig/tcl.m4 || die
}

src_configure() {
	local myeconfargs
	use X && myeconfargs+=( --with-x )
	use debug && myeconfargs+=( --with-symbols )
	use threads && myeconfargs+=( --enable-threads )
	autotools-utils_src_configure
}
