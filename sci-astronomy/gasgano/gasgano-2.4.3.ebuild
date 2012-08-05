# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-astronomy/gasgano/gasgano-2.4.3.ebuild,v 1.2 2012/08/05 17:59:37 bicatali Exp $

EAPI=4
inherit eutils java-pkg-2

PDOC=VLT-PRO-ESO-19000-1932-V4

DESCRIPTION="ESO astronomical data file organizer"
HOMEPAGE="http://www.eso.org/sci/software/gasgano/"
SRC_URI="ftp://ftp.eso.org/pub/dfs/${PN}/${P}.tar.gz
	doc? ( ${HOMEPAGE}/${PDOC}.pdf )"

LICENSE="Apache-1.1"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~amd64-linux ~x86-linux"
IUSE="doc"

DEPEND=">=virtual/jdk-1.6"
RDEPEND=">=virtual/jre-1.6
	dev-java/gnu-regexp
	dev-java/junit
	dev-java/jal"

src_prepare() {
	sed -i \
		-e "s:BASE.*=.*:BASE=${EPREFIX}/usr/share/${PN}:" \
		-e "s:/share/:/lib/:g" \
		bin/gasgano || die
}

src_install() {
	dobin bin/*
	java-pkg_dojar share/*.jar
	insinto /usr/share/${PN}
	doins -r config
	make_desktop_entry gasgano "Gasgano FITS Organizer"
	if use doc; then
		insinto /usr/share/doc/${PF}
		newins "${DISTDIR}"/${PDOC}.pdf user-manual.pdf
	fi
}
