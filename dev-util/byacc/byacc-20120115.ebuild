# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/byacc/byacc-20120115.ebuild,v 1.4 2012/03/03 14:47:11 maekke Exp $

EAPI=4

DESCRIPTION="the best variant of the Yacc parser generator"
HOMEPAGE="http://invisible-island.net/byacc/byacc.html"
SRC_URI="ftp://invisible-island.net/byacc/${P}.tgz"

LICENSE="public-domain"
SLOT="0"
KEYWORDS="~alpha ~amd64 arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~s390 ~sparc ~x86 ~amd64-linux ~x86-linux ~ppc-macos ~x86-macos ~sparc-solaris ~x64-solaris ~x86-solaris"
IUSE=""

DOCS=( ACKNOWLEDGEMENTS AUTHORS CHANGES NEW_FEATURES NOTES README )

src_configure() {
	econf --program-prefix=b
}
