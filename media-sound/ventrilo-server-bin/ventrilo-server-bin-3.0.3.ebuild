# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/ventrilo-server-bin/ventrilo-server-bin-3.0.3.ebuild,v 1.3 2009/07/07 23:10:39 flameeyes Exp $

inherit eutils

IUSE=""
DESCRIPTION="The Ventrilo Voice Communication Server"
HOMEPAGE="http://www.ventrilo.com/"
SRC_URI="ventrilo_srv-${PV}-Linux-i386.tar.gz"

LICENSE="ventrilo"
SLOT="0"
KEYWORDS="-* amd64 x86"
RESTRICT="fetch"

S=${WORKDIR}

DEPEND="amd64? ( app-emulation/emul-linux-x86-baselibs )"
RDEPEND="${DEPEND}"
pkg_setup() {
	enewgroup ventrilo 3784
	enewuser ventrilo 3784 -1 /dev/null ventrilo
}

pkg_nofetch() {
	elog "Please visit http://www.ventrilo.com/download.php"
	elog "and download the Linux i386 - 32bit ${PV} server."
	elog "Just save it in ${DISTDIR} !"
}

src_install() {
	cd "${S}/ventsrv"

	exeinto /opt/ventrilo-server
	doexe ventrilo_{srv,status}

	newinitd "${FILESDIR}"/${PV}-init.d.ventrilo ventrilo
	newconfd "${FILESDIR}"/${PV}-conf.d.ventrilo ventrilo

	insinto /opt/ventrilo-server
	doins ventrilo_srv.ini

	dohtml ventrilo_srv.htm

	fowners ventrilo:ventrilo /opt/ventrilo-server
}
