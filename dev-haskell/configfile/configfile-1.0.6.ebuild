# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-haskell/configfile/configfile-1.0.6.ebuild,v 1.1 2010/11/07 14:01:55 slyfox Exp $

# ebuild generated by hackport 0.2.9

CABAL_FEATURES="lib profile haddock"
inherit haskell-cabal

MY_PN="ConfigFile"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="Configuration file reading & writing"
HOMEPAGE="http://software.complete.org/configfile"
SRC_URI="http://hackage.haskell.org/packages/archive/${MY_PN}/${PV}/${MY_P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=">=dev-haskell/missingh-1.0.0
		<dev-haskell/mtl-2.0.0.0
		dev-haskell/parsec
		>=dev-lang/ghc-6.8.2"
DEPEND="${RDEPEND}
		>=dev-haskell/cabal-1.2.3"

S="${WORKDIR}/${MY_P}"
