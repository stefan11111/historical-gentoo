# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-sci/orsa/orsa-0.3.0_rc1.ebuild,v 1.5 2003/09/08 07:26:06 msterret Exp $

inherit base flag-o-matic

DESCRIPTION="Orbital Reconstruction, Simulation and Analysis"
HOMEPAGE="http://orsa.sourceforge.net/"
SRC_URI="mirror://sourceforge/orsa/${PN}-${PV/_/-}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"

DEPEND="virtual/glibc
	dev-libs/fftw
	dev-libs/gsl
	x11-libs/qt
	sys-libs/readline"

S=${WORKDIR}/${PN}-${PV/_/-}

replace-flags k6-3 i586
replace-flags k6-2 i586
replace-flags k6 i586

src_compile() {
	econf || die
	emake || die

	#Uncomment the 'make check ...' line if you want to run the test suite.
	#Note that the check.log file will be several megabytes in size.
	#make check > ${WORKDIR}/check.log 2>&1 || die
}

src_install () {
	einstall || die
	dodoc AUTHORS ChangeLog INSTALL NEWS README THANKS
}
