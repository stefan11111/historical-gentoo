# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-haskell/ansi-terminal/ansi-terminal-0.5.5.ebuild,v 1.1 2011/08/01 07:45:31 slyfox Exp $

# ebuild generated by hackport 0.2.13

EAPI="3"

CABAL_FEATURES="bin lib profile haddock hscolour"
inherit haskell-cabal

DESCRIPTION="Simple ANSI terminal support, with Windows compatibility"
HOMEPAGE="http://batterseapower.github.com/ansi-terminal"
SRC_URI="http://hackage.haskell.org/packages/archive/${PN}/${PV}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~ia64 ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd"
IUSE=""

RDEPEND=">=dev-lang/ghc-6.8.2"
DEPEND="${RDEPEND}
		>=dev-haskell/cabal-1.2"
