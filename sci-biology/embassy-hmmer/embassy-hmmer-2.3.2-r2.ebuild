# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-biology/embassy-hmmer/embassy-hmmer-2.3.2-r2.ebuild,v 1.3 2009/09/01 18:28:53 ribosome Exp $

EBOV="6.0.1"

inherit embassy

DESCRIPTION="EMBOSS wrappers for HMMER - Biological sequence analysis with profile HMMs"
SRC_URI="ftp://emboss.open-bio.org/pub/EMBOSS/EMBOSS-${EBOV}.tar.gz
	mirror://gentoo/embassy-${EBOV}-${PN:8}-${PV}.tar.gz"

KEYWORDS="amd64 ~ppc ~sparc x86"

RDEPEND="~sci-biology/hmmer-2.3.2"

src_install() {
	embassy_src_install
	insinto /usr/include/emboss/hmmer
	doins src/*.h
}
