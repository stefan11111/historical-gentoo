# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-apps/xoops/xoops-2.0.12a.ebuild,v 1.1 2005/06/30 19:09:48 ka0ttic Exp $

inherit webapp eutils

MY_P="${PN/x/X}-${PV}"
DESCRIPTION="eXtensible Object Oriented Portal System (xoops) is an open-source Content Management System, including various portal features and supplemental modules."
HOMEPAGE="http://www.xoops.org/"
SRC_URI="mirror://sourceforge/${PN}/${MY_P}.tar.gz"

LICENSE="GPL-2"
KEYWORDS="~x86 ~ppc ~amd64"

RDEPEND=">=virtual/php-4.1.1
	net-www/apache
	>=dev-db/mysql-3.23"

S="${WORKDIR}"

src_install() {
	webapp_src_preinst
	dodoc docs/CHANGES.txt
	dohtml docs/INSTALL.html
	mv docs/images ${D}/usr/share/doc/${PF}/html

	cp -a html/* "${D}/${MY_HTDOCSDIR}"
	webapp_serverowned ${MY_HTDOCSDIR}/uploads
	webapp_serverowned ${MY_HTDOCSDIR}/cache
	webapp_serverowned ${MY_HTDOCSDIR}/templates_c
	webapp_serverowned ${MY_HTDOCSDIR}/mainfile.php
	webapp_postinst_txt en ${FILESDIR}/postinstall-en.txt
	webapp_src_install
}
