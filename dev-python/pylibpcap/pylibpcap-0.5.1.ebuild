# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pylibpcap/pylibpcap-0.5.1.ebuild,v 1.8 2007/07/09 13:15:51 hawking Exp $

inherit distutils eutils

DESCRIPTION="Python interface to libpcap"
HOMEPAGE="http://sourceforge.net/projects/pylibpcap/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 ia64 x86"
IUSE="examples"

RDEPEND="virtual/libpcap"
DEPEND="${RDEPEND}
	>=dev-lang/swig-1.3.29"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}/${PN}-swig-1.3.29.patch"
	epatch "${FILESDIR}/${PN}-unknown_addr.patch"
}

src_install() {
	distutils_src_install
	if use examples ; then
		insinto /usr/share/doc/${PF}
		doins -r examples
	fi
}
