# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/digikamplugins/digikamplugins-0.6.2_rc1.ebuild,v 1.1 2004/06/09 20:07:46 carlo Exp $

inherit kde

MY_P=${P/_rc1/RC}
S=${WORKDIR}/${PN}

DESCRIPTION="A KDE frontend for gPhoto 2"
HOMEPAGE="http://digikam.sourceforge.net/"
SRC_URI="http://digikam.free.fr/Tarballs/${MY_P}.tar.bz2"
#rc not via sf available
#SRC_URI="mirror://sourceforge/digikam/${MY_P}.tar.bz2"


SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~ppc ~amd64"
IUSE=""

DEPEND="=media-gfx/digikam-${PV}
	>=media-gfx/imagemagick-5.5.4
	>=media-video/mjpegtools-1.6.0
	virtual/opengl"

need-kde 3