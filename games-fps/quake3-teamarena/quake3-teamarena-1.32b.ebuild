# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-fps/quake3-teamarena/quake3-teamarena-1.32b.ebuild,v 1.9 2012/01/16 19:23:30 ulm Exp $

CDROM_DISABLE_PROPERTIES=1
inherit eutils cdrom games

DESCRIPTION="Quake III Team Arena - data portion"
HOMEPAGE="http://icculus.org/quake3/"
SRC_URI="mirror://idsoftware/quake3/linux/linuxq3apoint-${PV}-3.x86.run"

LICENSE="Q3AEULA"
SLOT="0"
KEYWORDS="amd64 ~ppc x86 ~x86-fbsd"
IUSE="cdinstall"
PROPERTIES="cdinstall? ( interactive )"

RDEPEND="|| (
	games-fps/quake3
	games-fps/quake3-bin )"

S=${WORKDIR}

src_unpack() {
	use cdinstall && cdrom_get_cds Setup/missionpack/PAK0.PK3
	unpack_makeself
}

src_install() {
	einfo "Copying Team Arena files from linux client ..."
	insinto "${GAMES_DATADIR}"/quake3/missionpack
	doins missionpack/*.pk3 || die "missionpack"

	if use cdinstall ; then
		einfo "Copying files from CD ..."
		newins "${CDROM_ROOT}/Setup/missionpack/PAK0.PK3" pak0.pk3 \
			|| die "pak0"
		eend 0
	fi

	find "${D}" -exec touch '{}' \;
	prepgamesdirs
}

pkg_postinst() {
	games_pkg_postinst
	if ! use cdinstall ; then
		elog "You need to copy PAK0.PK3 from your Team Arena CD into"
		elog "${dir}/missionpack and name it pak0.pk3."
		elog "Or if you have got a Window installation of Q3 make a symlink to save space."
		elog
		elog "Or, re-emerge quake3-teamarena with USE=cdinstall."
		echo
	fi
}
