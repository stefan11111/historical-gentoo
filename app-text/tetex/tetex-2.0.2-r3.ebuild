# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/tetex/tetex-2.0.2-r3.ebuild,v 1.11 2004/04/08 22:58:41 vapier Exp $

inherit tetex eutils

DESCRIPTION="a complete TeX distribution"
HOMEPAGE="http://tug.org/teTeX/"

KEYWORDS="x86 ppc sparc mips alpha hppa amd64 ia64"

src_unpack() {
	tetex_src_unpack
	epatch ${FILESDIR}/${PN}-no-readlink-manpage.diff
}
