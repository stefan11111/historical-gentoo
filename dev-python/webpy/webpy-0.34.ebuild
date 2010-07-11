# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/webpy/webpy-0.34.ebuild,v 1.4 2010/07/11 13:35:23 maekke Exp $

EAPI="3"
PYTHON_DEPEND="2"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="3.*"

inherit distutils

MY_PN="web.py"

DESCRIPTION="A small and simple web framework for Python"
HOMEPAGE="http://www.webpy.org http://pypi.python.org/pypi/web.py"
SRC_URI="http://www.webpy.org/static/${MY_PN}-${PV}.tar.gz"

LICENSE="public-domain"
SLOT="0"
KEYWORDS="amd64 ~hppa x86 ~amd64-linux ~x86-linux"
IUSE=""

DEPEND=""
RDEPEND=""

S="${WORKDIR}/web.py-${PV}"

PYTHON_MODNAME="web"

src_test() {
	testing() {
		local return_status="0" test tests="db http net template utils"
		for test in ${tests}; do
			echo "Running doctests in ${test}.py..."
			"$(PYTHON)" web/${test}.py || return_status="$?"
		done

		return "${return_status}"
	}
	python_execute_function testing
}
