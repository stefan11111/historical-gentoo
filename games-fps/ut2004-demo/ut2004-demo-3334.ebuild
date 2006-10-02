# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-fps/ut2004-demo/ut2004-demo-3334.ebuild,v 1.14 2006/10/02 15:31:42 wolf31o2 Exp $

inherit eutils games

MY_P="ut2004-lnx-demo${PV}.run"
DESCRIPTION="Unreal Tournament 2004 Demo"
HOMEPAGE="http://www.unrealtournament.com/"

SRC_URI="mirror://3dgamers/unrealtourn2k4/${MY_P}"

LICENSE="as-is"
SLOT="0"
KEYWORDS="-* x86 amd64"
RESTRICT="strip"
IUSE=""

DEPEND=""
RDEPEND="virtual/opengl
	=virtual/libstdc++-3.3
	x86? (
		x11-libs/libX11
		x11-libs/libXext )
	amd64? (
		app-emulation/emul-linux-x86-xlibs )"

S=${WORKDIR}

dir=${GAMES_PREFIX_OPT}/${PN}
Ddir=${D}/${dir}

src_unpack() {
	unpack_makeself
	tar zxf setupstuff.tar.gz || die "unpacking setupstuff"
}

src_install() {
	dodir ${dir}

	tar xjf ut2004demo.tar.bz2 -C ${Ddir} || die "unpacking ut2004 failed"

	if use x86
	then
		tar xjf linux-x86.tar.bz2 || die "unpacking exe"
	fi
	if use amd64
	then
		tar xjf linux-amd64.tar.bz2 || die "unpacking exe"
	fi

	insinto ${dir}
	doins README.linux ut2004.xpm
	newicon ut2004.xpm ut2004-demo.xpm

	exeinto ${dir}
	doexe bin/ut2004-demo

	exeinto ${dir}/System
	doexe System/{libSDL-1.2.so.0,openal.so,ucc-bin,ut2004-bin}

	dodir
	games_make_wrapper ut2004-demo ./ut2004-demo "${dir}" "${dir}"
	make_desktop_entry ut2004-demo "Unreal Tournament 2004 (Demo)" ut2004-demo.xpm

	prepgamesdirs
}

pkg_postinst() {
	games_pkg_postinst
	echo
	elog "For Text To Speech:"
	elog "   1) emerge festival speechd"
	elog "   2) Edit your ~/.ut2004demo/System/UT2004.ini file."
	elog "      In the [SDLDrv.SDLClient] section, add:"
	elog "         TextToSpeechFile=/dev/speech"
	elog "   3) Start speechd."
	elog "   4) Start the game.  Be sure to go into the Audio"
	elog "      options and enable Text To Speech."
	echo
	elog "To test, pull down the console (~) and type:"
	elog "   TTS this is a test."
	echo
	elog "You should hear something that sounds like 'This is a test.'"
	echo
}
