# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-haskell/hdbc-odbc/hdbc-odbc-2.2.3.2.ebuild,v 1.1 2011/06/12 19:51:22 slyfox Exp $

# ebuild generated by hackport 0.2.13

EAPI="3"

CABAL_FEATURES="bin lib profile haddock hscolour"
inherit haskell-cabal

MY_PN="HDBC-odbc"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="ODBC driver for HDBC"
HOMEPAGE="http://software.complete.org/hdbc-odbc"
SRC_URI="http://hackage.haskell.org/packages/archive/${MY_PN}/${PV}/${MY_P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="2"
KEYWORDS="~amd64 ~x86"
IUSE="test"
RESTRICT="test" # requires configured ODBC

hdbc_PV=$(get_version_component_range 1-2)

RDEPEND=">=dev-lang/ghc-6.10
		=dev-haskell/hdbc-${hdbc_PV}*
		dev-haskell/mtl
		dev-haskell/utf8-string
		>=dev-db/unixODBC-2.2
	"
DEPEND="${RDEPEND}
		>=dev-haskell/cabal-1.2.3
		test? ( dev-haskell/convertible
			dev-haskell/hunit
			dev-haskell/quickcheck
			dev-haskell/testpack
			dev-haskell/time
		)
	"

S="${WORKDIR}/${MY_P}"
src_configure() {
	cabal_src_configure $(cabal_flag test buildtests)
}

src_test() {
	# default tests
	haskell-cabal_src_test || die "cabal test failed"

	# built custom tests
	"${S}/dist/build/runtests/runtests" || die "unit tests failed"
}

src_install() {
	cabal_src_install

	# if tests were enabled, make sure the unit test driver is deleted
	rm -f "${ED}/usr/bin/runtests"
}
