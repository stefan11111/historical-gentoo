# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/gmpy/gmpy-1.14.ebuild,v 1.5 2012/02/20 15:03:17 patrick Exp $

EAPI="3"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="*-jython 2.7-pypy-*"

inherit distutils

DESCRIPTION="Python bindings for GMP library"
HOMEPAGE="http://www.aleax.it/gmpy.html http://code.google.com/p/gmpy/ http://pypi.python.org/pypi/gmpy"
SRC_URI="http://${PN}.googlecode.com/files/${P}.zip"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="amd64 ~ia64 x86 ~x86-linux ~ppc-macos"
IUSE=""

RDEPEND="dev-libs/gmp"
DEPEND="${RDEPEND}
	app-arch/unzip"

PYTHON_CFLAGS=("2.* + -fno-strict-aliasing")

DOCS="doc/gmpydoc.txt"

src_test() {
	testing() {
		if [[ "${PYTHON_ABI}" == 3.* ]]; then
			pushd test3 > /dev/null
		else
			pushd test > /dev/null
		fi
		PYTHONPATH="$(ls -d ../build-${PYTHON_ABI}/lib.*)" "$(PYTHON)" gmpy_test.py || return 1
		popd > /dev/null
	}
	python_execute_function testing
}

src_install() {
	distutils_src_install
	dohtml doc/index.html || die "dohtml failed"
}
