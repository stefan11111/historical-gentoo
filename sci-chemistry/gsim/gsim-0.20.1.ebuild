# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-chemistry/gsim/gsim-0.20.1.ebuild,v 1.2 2012/05/21 15:08:27 jlec Exp $

EAPI=4

inherit eutils qt4-r2

DESCRIPTION="Programm for visualisation and processing of experimental and simulated NMR spectra"
HOMEPAGE="http://sourceforge.net/projects/gsim/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~amd64-linux ~x86-linux"
IUSE="emf opengl"

RDEPEND="
	dev-cpp/muParser
	media-libs/freetype
	sci-libs/libcmatrix
	sci-libs/minuit
	virtual/blas
	x11-libs/qt-svg:4
	emf? ( media-libs/libemf )
	opengl? ( x11-libs/qt-opengl:4 )"
DEPEND="${RDEPEND}"

PATCHES=( "${FILESDIR}"/${PV}-build.conf.patch )
DOCS="release.txt README_GSIM.* quickstart.* changes.log programming.*"

src_prepare() {
	edos2unix ${PN}.pro

	qt4-r2_src_prepare

	cat >> build.conf <<- EOF
	INCLUDEPATH += "${EPREFIX}/usr/include/libcmatrixR3/" \
		"${EPREFIX}/usr/include/Minuit2" \
		"${EPREFIX}/usr/include"
	LIBS += -lcmatrix  -lMinuit2 -lmuparser $(pkg-config --libs cblas)
	EOF

	use opengl && echo "CONFIG+=use_opengl" >> build.conf

	if use emf; then
		cat >> build.conf <<- EOF
		CONFIG+=use_emf
		DEFINES+=USE_EMF_OUTPUT
		LIBS += -L\"${EPREFIX}/usr/include/libEMF\" -lEMF
		EOF
	fi
	sed \
		-e "s:quickstart.pdf:../share/doc/${PF}/quickstart.pdf:g" \
		-e "s:README_GSIM.pdf:../share/doc/${PF}/README_GSIM.pdf:g" \
		-i mainform.h || die
}

src_install() {
	qt4-r2_src_install
	dobin ${PN}
	insinto /usr/share/${PN}
	doins -r images ${PN}.ico
	insinto /usr/share/${PN}/ui
	doins *.ui
}
