# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/libmatroska/libmatroska-1.3.0.ebuild,v 1.3 2012/06/09 00:07:40 zmedico Exp $

EAPI="4"

inherit flag-o-matic eutils multilib toolchain-funcs

DESCRIPTION="Extensible multimedia container format based on EBML"
HOMEPAGE="http://www.matroska.org/"
SRC_URI="http://www.bunkus.org/videotools/mkvtoolnix/sources/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~ia64 ~ppc ~ppc64 ~sparc ~x86 ~amd64-fbsd ~x86-fbsd"
IUSE="static-libs"
RESTRICT="test"

DEPEND=">=dev-libs/libebml-1.2.1"
RDEPEND="${DEPEND}"

S="${WORKDIR}/${P}/make/linux"

src_prepare() {
	epatch "${FILESDIR}/${PN}-1.0.0-respectflags.patch"
}

src_compile() {
	local targets="sharedlib"
	use static-libs && targets+=" staticlib"

	#fixes locale for gcc3.4.0 to close bug 52385
	append-flags $(test-flags -finput-charset=ISO8859-15)

	emake PREFIX=/usr \
		LIBEBML_INCLUDE_DIR=/usr/include/ebml \
		LIBEBML_LIB_DIR=/usr/$(get_libdir) \
		CXX="$(tc-getCXX)" \
		AR="$(tc-getAR)" \
		${targets}
}

src_install() {
	local targets="install_sharedlib install_headers"
	use static-libs && targets+=" install_staticlib"

	emake prefix="${D}/usr" libdir="${D}/usr/$(get_libdir)" ${targets}
	dodoc "${WORKDIR}/${P}/ChangeLog"
}
