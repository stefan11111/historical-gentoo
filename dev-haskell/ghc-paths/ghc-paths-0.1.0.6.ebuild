# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-haskell/ghc-paths/ghc-paths-0.1.0.6.ebuild,v 1.1 2010/06/14 17:25:46 kolmodin Exp $

CABAL_FEATURES="lib profile haddock"
inherit haskell-cabal

DESCRIPTION="Knowledge of GHC's installation directories"
HOMEPAGE="http://hackage.haskell.org/cgi-bin/hackage-scripts/package/ghc-paths"
SRC_URI="http://hackage.haskell.org/packages/archive/${PN}/${PV}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=">=dev-lang/ghc-6.8"
DEPEND="${RDEPEND}
		>=dev-haskell/cabal-1.6"
