# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# Author Bart Verwilst <verwilst@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/net-misc/krfb/krfb-0.5.1.ebuild,v 1.1 2002/04/02 13:48:13 verwilst Exp $ 
. /usr/portage/eclass/inherit.eclass || die
inherit kde-base || die

need-kde 2.2
SLOT="0"
DESCRIPTION="KDE Desktop Sharing Application"
SRC_URI="http://www.tjansen.de/krfb/${PN}-0.5.tar.gz"
HOMEPAGE="http://www.tjansen.de/krfb/"

src_install() {

	mkdir -p ${D}/${KDE2DIR}/share/apps/krfb
	make DESTDIR=${D} install || die

}


