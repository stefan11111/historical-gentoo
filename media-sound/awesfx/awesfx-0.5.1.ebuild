# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/awesfx/awesfx-0.5.1.ebuild,v 1.6 2009/06/05 09:58:09 ssuominen Exp $

inherit eutils

DESCRIPTION="AWE Utilities - sfxload"
HOMEPAGE="http://www.alsa-project.org/~iwai/awedrv.html#Utils"
SRC_URI="http://ftp.suse.com/pub/people/tiwai/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~ppc sparc x86"
IUSE=""

RDEPEND="media-libs/alsa-lib"
DEPEND="${RDEPEND}"

BANK_LOC="/usr/share/sounds/sf2"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${P}-include.patch
}

src_compile() {
	econf --with-sfpath=${BANK_LOC}
	emake || die "emake failed."
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed."
	dodoc AUTHORS ChangeLog README SBKtoSF2.txt
	dodoc "${D}"/usr/share/sounds/sf2/README-bank
	rm "${D}"/usr/share/sounds/sf2/README-bank
}

pkg_postinst() {
	elog "Copy your SoundFont files from the original CDROM"
	elog "shipped with your soundcard to ${BANK_LOC}"
}
