# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/vcdgear/vcdgear-1.76.ebuild,v 1.1 2005/09/25 10:27:31 vapier Exp $

inherit eutils

STAMP=040415
DESCRIPTION="extract MPEG streams from CD images, convert VCD files to MPEG, correct MPEG errors, and more"
HOMEPAGE="http://www.vcdgear.com/"
SRC_URI="http://www.vcdgear.com/files/vcdgear${PV//.}-${STAMP}_linux.tar.gz"

LICENSE="as-is"
SLOT="0"
KEYWORDS="-* ~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND=""

S=${WORKDIR}/${PN}

src_install() {
	insinto /opt/vcdgear
	doins -r * || die "doins"
	fperms a+rx /opt/vcdgear/vcdgear
	make_wrapper ${PN} ./vcdgear /opt/vcdgear
}
