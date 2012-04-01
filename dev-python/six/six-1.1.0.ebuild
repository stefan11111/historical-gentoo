# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/six/six-1.1.0.ebuild,v 1.1 2012/04/01 04:09:09 floppym Exp $

EAPI="4"
SUPPORT_PYTHON_ABIS="1"

inherit distutils

DESCRIPTION="Python 2 and 3 compatibility library"
HOMEPAGE="http://pypi.python.org/pypi/six"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc"

DEPEND="doc? ( dev-python/sphinx )"
RDEPEND=""

PYTHON_MODNAME="${PN}.py"

src_compile() {
	distutils_src_compile
	if use doc; then
		cd documentation || die
		emake html
	fi
}

src_install() {
	distutils_src_install
	if use doc; then
		dohtml -r documentation/_build/html/*
	fi
}
