# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/ondir/ondir-0.2.1.ebuild,v 1.3 2004/03/14 10:52:28 mr_bones_ Exp $

inherit eutils

DESCRIPTION="ondir is a program that automatically executes scripts as you traverse directories."
SRC_URI="http://ondir.sourceforge.net/${PV}/ondir-${PV}.tar.gz"
HOMEPAGE="http://ondir.sourceforge.net"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"
IUSE=""
DEPEND=""

src_unpack() {
	unpack "${A}"
	cd "${S}"
}

src_compile() {
	emake PREFIX=/usr CONF=/etc/ondirrc || die "Make failed"
}

src_install() {
	## EXEs
	exeinto /usr/bin
	exeopts -oroot -groot -m0755
	doexe ondir
	## MISC
	insinto /usr/share/${PN}
	insopts -oroot -groot -m0755
	doins scripts.sh scripts.tcsh
	insopts -oroot -groot -m0644
	doins ondirrc.eg
	## DOCS
	dodoc AUTHORS ChangeLog COPYING \
	INSTALL README TODO
	doman ondir.1
}
