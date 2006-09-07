# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/fetchlog/fetchlog-1.0.ebuild,v 1.6 2006/09/07 23:58:01 dang Exp $

DESCRIPTION="Displays the last new messages of a logfile"
HOMEPAGE="http://fetchlog.sourceforge.net/"
SRC_URI="mirror://sourceforge/fetchlog/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc x86"

IUSE="snmp"

DEPEND="snmp? (
	>=dev-perl/Net-SNMP-4.0.1-r2
	>=net-analyzer/net-snmp-5.0.6
	)"

pkg_preinst() {
	einfo
	einfo "This utility can be used together with Nagios"
	einfo "To make use of these features you need to"
	einfo "install net-analyzer/nagios."
	einfo "This feature depends on SNMP, so make use you"
	einfo "have 'snmp' in your USE flags"
	einfo
}

src_compile() {
	emake || die
}

src_install() {
	dodoc CHANGES README*
	dobin fetchlog
	doman fetchlog.1
}
