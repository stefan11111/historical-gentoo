# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/gramofile/gramofile-1.6-r1.ebuild,v 1.6 2009/06/11 14:06:13 fauli Exp $

EAPI=2
PATCH_LEVEL=8
inherit eutils multilib toolchain-funcs

DESCRIPTION="Transfer sound from gramophone records to CD"
HOMEPAGE="http://www.opensourcepartners.nl/~costar/gramofile"
SRC_URI="mirror://debian/pool/main/g/${PN}/${PN}_${PV}.orig.tar.gz
	mirror://debian/pool/main/g/${PN}/${PN}_${PV}-${PATCH_LEVEL}.diff.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc x86"
IUSE=""

RDEPEND="sys-libs/ncurses
	sci-libs/fftw:2.1"
DEPEND="${RDEPEND}"

src_prepare() {
	epatch "${WORKDIR}"/${PN}_${PV}-${PATCH_LEVEL}.diff
	EPATCH_SUFFIX="dpatch" EPATCH_FORCE="yes" epatch ${P}/debian
	epatch "${FILESDIR}"/${P}-strlen_and_exit.patch
}

src_compile() {
	tc-export CC
	emake || die "emake failed"
}

src_install() {
	dobin ${PN} || die "dobin failed"
	exeinto /usr/$(get_libdir)/${PN}
	doexe bplay_gramo brec_gramo || die "doexe failed"
	dodoc ChangeLog README TODO *.txt
	newdoc ${P}/debian/changelog ChangeLog.debian
}
