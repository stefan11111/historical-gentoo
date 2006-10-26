# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-power/acpi/acpi-0.06-r5.ebuild,v 1.2 2006/10/26 16:33:29 peper Exp $

inherit eutils

SRC_URI_BASE="http://ftp.debian.org/debian/pool/main/${PN:0:1}/${PN}"
SRC_URI_TGZ="${PN}_${PV}.orig.tar.gz"
SRC_URI_PATCH="${PN}_${PV}-${PR/r}.diff.gz"
DESCRIPTION="Attemp to replicate the functionality of the 'old' apm command on ACPI systems."
HOMEPAGE="http://packages.debian.org/unstable/utils/acpi.html"
SRC_URI="${SRC_URI_BASE}/${SRC_URI_TGZ}
	${SRC_URI_BASE}/${SRC_URI_PATCH}"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="-* x86 ~amd64"
IUSE=""

DEPEND="=sys-devel/automake-1.4*
	sys-apps/help2man"
RDEPEND=""

src_unpack() {
	unpack ${SRC_URI_TGZ}
	mv ${PN} ${P}
	epatch "${DISTDIR}/${SRC_URI_PATCH}"
}

src_compile() {
	econf || die "econf failed"
	emake || die "emake failed"

	# build manpage
	emake -C doc || die "emake doc failed"
}

src_install() {
	make DESTDIR="${D}" install || die "make install failed"
	doman doc/acpi.1
	dodoc AUTHORS CREDITS ChangeLog README
}
