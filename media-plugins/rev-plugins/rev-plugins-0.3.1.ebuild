# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/rev-plugins/rev-plugins-0.3.1.ebuild,v 1.1 2005/10/10 19:04:22 fvdpol Exp $
#
MY_P=${P/rev/REV}

DESCRIPTION="REV LADSPA plugins package. A stereo reverb plugin based on the well-known greverb"
HOMEPAGE="http://users.skynet.be/solaris/linuxaudio/"
SRC_URI="http://users.skynet.be/solaris/linuxaudio/downloads/${MY_P}.tar.bz2"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"

IUSE=""

DEPEND="media-libs/ladspa-sdk"

S=${WORKDIR}/${MY_P}

src_compile() {
	make || die
}

src_install() {
	dodoc AUTHORS README
	insinto /usr/lib/ladspa
	insopts -m0755
	doins *.so
}
