# Copyright 1999-2001 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/media-libs/qhull/qhull-3.1.ebuild,v 1.2 2002/07/11 06:30:39 drobbins Exp $

S=${WORKDIR}/qhull3.1
DESCRIPTION="Geometry library"
SRC_URI="http://www.geom.umn.edu/software/qhull/qhull3.1.tgz"
HOMEPAGE="http://www.geom.umn.edu/software/qhull/"

DEPEND=""
#RDEPEND=""

src_compile() {
	cd src
	make -f Makefile.txt

}

src_install () {

	cd src

	dolib libqhull.a
	dobin qconvex
	dobin qdelaunay
	dobin qhalf
	dobin qhull
	dobin qvoronoi
	dobin rbox

	dodir /usr/include/qhull
	insinto /usr/include/qhull
	doins *.h

	cd ${S}
	dodoc Announce.txt COPYING.txt File_id.diz README.txt REGISTER.txt
	
	cd html

	rename .htm .html *.htm
	rename .man .1 *.man

	dohtml -a html,gif *

	doman *.1
}
