# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-libs/liborigin/liborigin-20100903.ebuild,v 1.2 2010/10/12 12:09:21 jlec Exp $

EAPI="3"

inherit eutils qt4

DESCRIPTION="Library for reading OriginLab OPJ project files"
HOMEPAGE="http://soft.proindependent.com/liborigin2/"
SRC_URI="mirror://gentoo/${P}.tar.bz2"

LICENSE="GPL-3"
SLOT="2"
KEYWORDS="~amd64 ~x86 ~amd64-linux ~x86-linux"
IUSE="doc"

RDEPEND="dev-libs/boost"
DEPEND="${RDEPEND}
	x11-libs/qt-gui:4
	dev-cpp/tree
	doc? ( app-doc/doxygen )"

src_prepare() {
	epatch "${FILESDIR}/liborigin-20100420-build-parsers.patch"
	cat >> liborigin.pro <<-EOF
		INCLUDEPATH += "${EPREFIX}/usr/include/tree"
		headers.files = \$\$HEADERS
		headers.path = "${EPREFIX}/usr/include/liborigin2"
		target.path = "${EPREFIX}/usr/$(get_libdir)"
		INSTALLS = target headers
	EOF
	# use system one
	rm -f tree.hh || die
}

src_configure() {
	eqmake4
}

src_compile() {
	emake || die "emake failed"
	if use doc; then
		cd doc
		doxygen Doxyfile || die "doc generation failed"
	fi
}

src_install() {
	emake INSTALL_ROOT="${D}" install || die "emake install failed"
	dodoc readme FORMAT || die
	if use doc; then
		insinto /usr/share/doc/${PF}
		doins -r doc/html || die "doc install failed"
	fi
}
