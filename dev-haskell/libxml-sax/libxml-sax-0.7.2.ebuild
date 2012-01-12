# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-haskell/libxml-sax/libxml-sax-0.7.2.ebuild,v 1.1 2012/01/12 16:44:25 slyfox Exp $

# ebuild generated by hackport 0.2.13

EAPI="3"

CABAL_FEATURES="lib profile haddock hscolour hoogle"
inherit haskell-cabal

DESCRIPTION="Bindings for the libXML2 SAX interface"
HOMEPAGE="http://john-millikin.com/software/bindings/libxml-sax/"
SRC_URI="http://hackage.haskell.org/packages/archive/${PN}/${PV}/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="<dev-haskell/text-0.12
		=dev-haskell/xml-types-0.3*
		>=dev-lang/ghc-6.10.1
		dev-libs/libxml2"
DEPEND="${RDEPEND}
		dev-haskell/c2hs
		>=dev-haskell/cabal-1.6"
