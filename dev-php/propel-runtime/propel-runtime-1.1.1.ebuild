# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php/propel-runtime/propel-runtime-1.1.1.ebuild,v 1.2 2005/10/12 11:15:05 humpback Exp $

inherit php-pear-r1 depend.php

DESCRIPTION="Object Persistence Layer for PHP 5 (Runtime)."
HOMEPAGE="http://propel.phpdb.org/wiki/"
LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""
SRC_URI="http://propel.phpdb.org/pear/propel_runtime-${PV}.tgz"
RDEPEND=">=dev-php/creole-1.0.1"
S="${WORKDIR}/propel_runtime-${PV}"

need_php5
