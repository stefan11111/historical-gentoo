# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author: Aron Griffis <agriffis@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/geotrace/geotrace-0.0.4.ebuild,v 1.5 2002/06/30 02:44:58 seemant Exp $

S=${WORKDIR}/${P}
DESCRIPTION="geographical traceroute utility"
SRC_URI="http://geotrace.sourceforge.net/releases/${P}.tar.gz"
HOMEPAGE="http://geotrace.sourceforge.net/"

DEPEND="=x11-libs/gtk+-1.2*
	>=media-libs/gdk-pixbuf-0.16.0-r1"

RDEPEND="net-analyzer/traceroute"

src_unpack() {
	unpack ${A}
	cd ${S}
	patch -p1 < ${FILESDIR}/geotrace-map-location.patch
}

src_compile() {
	emake || die
}

src_install () {
	install -d ${D}/usr/bin
	install -d ${D}/usr/share/geotrace
	install -d ${D}/usr/share/geotrace/maps
	install -m755 geotrace ${D}/usr/bin
	install -m644 maps/* ${D}/usr/share/geotrace/maps
	dodoc Changelog COPYRIGHT README
}
