# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-action/d1x-rebirth/d1x-rebirth-0.55.1.ebuild,v 1.5 2012/01/18 12:42:50 vapier Exp $

EAPI=2

CDROM_OPTIONAL="yes"
inherit eutils cdrom games

DV=1
DESCRIPTION="Descent Rebirth - enhanced Descent ${DV} engine"
HOMEPAGE="http://www.dxx-rebirth.de/"
SRC_URI="mirror://sourceforge/dxx-rebirth/${PN}_v${PV}-src.tar.gz
	http://www.dxx-rebirth.com/download/dxx/res/d1xrdata.zip
	http://www.dxx-rebirth.com/download/dxx/res/dxx-rebirth_icons.zip
	timidity? ( http://www.dxx-rebirth.com/download/dxx/res/descent${DV/1}_midi.zip )
	cdinstall? ( http://www.dxx-rebirth.com/download/dxx/res/d1datapt.zip )
	linguas_de? ( http://www.dxx-rebirth.com/download/dxx/res/D${DV}XBDE01.zip )"

LICENSE="D1X GPL-2 as-is"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="ipv6 linguas_de opengl timidity"

RDEPEND="virtual/opengl
	virtual/glu
	dev-games/physfs[hog,zip]
	media-libs/libsdl
	media-libs/sdl-mixer[timidity?]
	cdinstall? ( !games-action/descent1-demodata )"
DEPEND="${RDEPEND}
	app-arch/unzip
	dev-util/scons"

S=${WORKDIR}/${PN}_v${PV}-src

src_unpack() {
	unpack ${PN}_v${PV}-src.tar.gz dxx-rebirth_icons.zip
	use linguas_de && unpack D${DV}XBDE01.zip
	if use cdinstall ; then
		unpack d1datapt.zip
		cdrom_get_cds descent/descent.hog
		mkdir "${S}"/Data
		cp \
			${CDROM_ROOT}/descent/descent.{hog,pig} \
			${CDROM_ROOT}/descent/chaos.{hog,msn} \
			"${S}"/Data \
			|| die "cp failed"
	fi
}

src_prepare() {
	if use cdinstall ; then
		cd Data
		patch -p0 < "${WORKDIR}"/d1datapt/descent.hog.diff descent.hog
		patch -p0 < "${WORKDIR}"/d1datapt/descent.pig.diff descent.pig
	fi
}

src_compile() {
	local sconsopts=$(echo "${MAKEOPTS}" | sed -ne "/-j/ { s/.*\(-j[[:space:]]*[0-9]\+\).*/\1/; p }")

	scons ${sconsopts} \
		sharepath="${GAMES_DATADIR}/d${DV}x" \
		sdlmixer=1 \
		sdl_only=$(use opengl && echo 0 || echo 1)
		ipv6=$(use ipv6 && echo 1 || echo 0)
}

src_install() {
	dodoc INSTALL.txt README.txt
	insinto "${GAMES_DATADIR}/d${DV}x"
	doins "${DISTDIR}"/d1xrdata.zip || die
	if use linguas_de ; then
		doins "${WORKDIR}"/D${DV}XBDE01/D${DV}XbDE01/*.txb
	fi
	if use timidity ; then
		doins "${DISTDIR}"/descent_midi.zip || die
	fi
	if use cdinstall ; then
		doins Data/descent.{hog,pig} || die
		insinto "${GAMES_DATADIR}"/d${DV}x/missions
		doins Data/chaos.{hog,msn} || die
	fi
	doicon "${WORKDIR}/${PN}.xpm"

	if use opengl ; then
		newgamesbin d${DV}x-rebirth-gl d${DV}x-rebirth
	else
		newgamesbin d${DV}x-rebirth-sdl d${DV}x-rebirth
	fi
	make_desktop_entry d${DV}x-rebirth "Descent ${DV} Rebirth" ${PN}
	prepgamesdirs
}

pkg_postinst() {
	games_pkg_postinst
	if ! use cdinstall ; then
		echo
		elog "You need to copy data-files from original Descent ${DV}"
		elog "installation to ${GAMES_DATADIR}/d${DV}x. Please read "
		elog "/usr/share/doc/${PF}/INSTALL.txt for more info."
		echo
	fi
}
