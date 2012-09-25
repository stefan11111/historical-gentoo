# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-haskell/test-framework-quickcheck2/test-framework-quickcheck2-0.2.12.2.ebuild,v 1.3 2012/09/25 14:17:53 nativemad Exp $

# ebuild generated by hackport 0.2.17

EAPI=4

CABAL_FEATURES="lib profile haddock hoogle hscolour"
inherit haskell-cabal

DESCRIPTION="QuickCheck2 support for the test-framework package."
HOMEPAGE="http://batterseapower.github.com/test-framework/"
SRC_URI="mirror://hackage/packages/archive/${PN}/${PV}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~ia64 ~ppc ~ppc64 ~sparc x86 ~x86-fbsd"
IUSE=""

RDEPEND="=dev-haskell/quickcheck-2.4*[profile?]
		>=dev-haskell/test-framework-0.6[profile?]
		>=dev-lang/ghc-6.10.4"
DEPEND="${RDEPEND}
		>=dev-haskell/cabal-1.2.3"
