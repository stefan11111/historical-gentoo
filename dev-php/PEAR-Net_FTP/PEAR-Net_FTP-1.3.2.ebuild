# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php/PEAR-Net_FTP/PEAR-Net_FTP-1.3.2.ebuild,v 1.3 2006/05/25 22:36:23 hansmi Exp $

inherit php-pear-r1 depend.php

DESCRIPTION="Provides an OO interface to the PHP FTP functions."
LICENSE="PHP"
SLOT="0"
KEYWORDS="~hppa ~ppc ~ppc64 ~sparc ~x86"
IUSE=""

pkg_setup() {
	require_php_with_use ftp
}
