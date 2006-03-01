# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-haskell/hdbc-sqlite/hdbc-sqlite-0.99.0.0.ebuild,v 1.4 2006/03/01 19:39:01 hansmi Exp $

CABAL_FEATURES="lib haddock"
inherit haskell-cabal versionator

DESCRIPTION="Sqlite v3 database driver for HDBC"
HOMEPAGE="http://quux.org/devel/hdbc/"
SRC_URI="http://quux.org/devel/hdbc/${PN}3_${PV}.tar.gz"
LICENSE="LGPL-2.1"
SLOT="0"

#if possible try testing with "~ppc" and "~sparc"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86"
IUSE=""

hdbc_PV=$(get_version_component_range 1-3)

DEPEND=">=virtual/ghc-6.4.1
	~dev-haskell/hdbc-${hdbc_PV}
	>=dev-db/sqlite-3.2"

S="${WORKDIR}/${PN}3"
