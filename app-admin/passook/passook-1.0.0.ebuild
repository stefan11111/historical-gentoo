# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/passook/passook-1.0.0.ebuild,v 1.4 2002/10/04 20:40:50 vapier Exp $

S=${WORKDIR}
DESCRIPTION="Password generator capable of generating pronounceable and/or secure passwords."
SRC_URI="ftp://mackers.com/pub/scripts/passook.tar.gz"
HOMEPAGE="http://mackers.com/misc/scripts/passook/"

SLOT="0"
LICENSE="as-is"
KEYWORDS="x86 ppc sparc sparc64"

DEPEND="sys-devel/perl
	sys-apps/grep
	sys-apps/miscfiles"

RDEPEND="${DEPEND}"

src_unpack() {
	unpack ${A}
	cd ${S}
	patch -p0 < ${FILESDIR}/passook.diff || die
}

src_install() {
	dobin passook
	dodoc README passook.cgi
}
