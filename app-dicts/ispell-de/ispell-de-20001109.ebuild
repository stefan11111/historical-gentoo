# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-dicts/ispell-de/ispell-de-20001109.ebuild,v 1.1 2002/12/03 07:15:39 seemant Exp $

KEYWORDS="x86"

LICENSE="GPL-2"

SLOT="0"

MY_P=igerman98-${PV}
S=${WORKDIR}/${MY_P}
DESCRIPTION="A german dictionary for ispell"
SRC_URI="http://www.suse.de/~bjacke/igerman98/dict/${MY_P}.tar.bz2"
HOMEPAGE="http://www.suse.de/~bjacke/igerman98/"

DEPEND="app-text/ispell"

src_compile() {

	make || die

}

src_install () {

	insinto /usr/lib/ispell
	doins german.aff german.hash
 
	dodoc Documentation/*

}

