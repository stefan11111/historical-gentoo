# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/schedutils/schedutils-1.1.0.ebuild,v 1.2 2003/04/12 14:41:56 lostlogic Exp $

DESCRIPTION="Utilities for manipulating kernel schedular parameters"
HOMEPAGE="http://tech9.net/rml/schedutils"
KEYWORDS="~x86 -ppc"
LICENSE="GPL-2"

RDEPEND="virtual/glibc"
DEPEND="$RDEPEND"
SLOT="0"

SRC_URI="http://tech9.net/rml/${PN}/${P}.tar.gz"
S=${WORKDIR}/${P}

src_compile() {
	emake || die || die "Make failed"
}

src_install() {
	einstall || die "Install failed"
}
