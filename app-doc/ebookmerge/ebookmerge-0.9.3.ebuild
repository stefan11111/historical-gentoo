# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-doc/ebookmerge/ebookmerge-0.9.3.ebuild,v 1.6 2006/11/12 05:14:11 vapier Exp $

DESCRIPTION="Script to manage eBooks in Gentoo"
HOMEPAGE="http://www.josealberto.org/blog/2005/11/28/ebookmerge/"
SRC_URI="mirror://gentoo/${P}.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ia64 ~ppc ~ppc64 ~s390 ~sh ~x86"
IUSE=""

DEPEND="app-shells/bash"
RDEPEND="${DEPEND}"

S=${WORKDIR}

src_install() {
	newbin ${P} ebookmerge.sh || die
}

pkg_postinst() {
	echo
	einfo "Need help?  Just run:"
	einfo "ebookmerge.sh -h"
	echo
	einfo "You first must run:"
	einfo "ebookmerge.sh -r"
	echo
	einfo "Use -m for an alternative mirror."
	echo
}
