# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php/Horde_Secret/Horde_Secret-1.0.0.ebuild,v 1.1 2011/06/04 19:54:43 a3li Exp $

EAPI=4

inherit php-pear-r1

KEYWORDS="~amd64"
SLOT="0"
DESCRIPTION="Secret Encryption API"
LICENSE="LGPL-2"
HOMEPAGE="http://www.horde.org/"
SRC_URI="http://pear.horde.org/${P}.tgz"

DEPEND="dev-lang/php[hash]
	>=dev-lang/php-5.2.0
	>=dev-php/PEAR-PEAR-1.7.0
	>=dev-php/PEAR-Crypt_Blowfish-1.0.1
	=dev-php/Horde_Exception-1*"
RDEPEND="${DEPEND}"
