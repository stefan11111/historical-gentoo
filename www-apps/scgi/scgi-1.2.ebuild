# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-apps/scgi/scgi-1.2.ebuild,v 1.1 2005/03/02 07:18:33 hollow Exp $

inherit distutils

DESCRIPTION="Replacement for the CGI protocol that is similar to FastCGI"
HOMEPAGE="http://www.mems-exchange.org/software/scgi/"
SRC_URI="http://www.mems-exchange.org/software/files/${PN}/${P}.tar.gz"

LICENSE="CNRI"
SLOT="0"
KEYWORDS="x86"
IUSE=""

pkg_postinst() {
	distutils_pkg_postinst
	einfo "This package does not install mod_scgi"
	einfo "Please 'emerge mod_scgi' if you need it"
}
