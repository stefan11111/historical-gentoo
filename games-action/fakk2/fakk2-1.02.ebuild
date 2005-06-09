# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-action/fakk2/fakk2-1.02.ebuild,v 1.8 2005/06/09 20:41:36 wolf31o2 Exp $

inherit eutils games

IUSE="nocd"
DESCRIPTION="Heavy Metal: FAKK2 - 3D third-person action shooter based on the Heavy Metal comics/movies"
HOMEPAGE="http://www.lokigames.com/products/fakk2/"
SRC_URI=""

LICENSE="LOKI-EULA"
SLOT="0"
KEYWORDS="x86"
RESTRICT="nostrip"

DEPEND="virtual/libc"
RDEPEND="${DEPEND}
	virtual/opengl"

S=${WORKDIR}

dir=${GAMES_PREFIX_OPT}/${PN}
Ddir=${D}/${dir}

pkg_setup() {
	check_license || die "License check failed"
	if use nocd ; then
		ewarn "The installed game takes about 378MB of space!"
	fi
	cdrom_get_cds fakk
	games_pkg_setup
}

src_install() {
	dodir ${dir}
	einfo "Copying files... this may take a while..."
	exeinto ${dir}
	doexe ${CDROM_ROOT}/bin/x86/glibc-2.1/${PN}
	insinto ${dir}
	doins ${CDROM_ROOT}/{README,icon.{bmp,xpm}}
	dodir ${dir}/fakk
	exeinto ${dir}/fakk
	doexe ${CDROM_ROOT}/bin/x86/glibc-2.1/fakk/{c,f}game.so
	if use nocd ; then
		insinto ${dir}fakk
		doins ${CDROM_ROOT}/fakk/pak{0,1,2,3}.pk3
	fi

	# now, since these files are coming off a cd, the times/sizes/md5sums wont
	# be different ... that means portage will try to unmerge some files (!)
	# we run touch on ${D} so as to make sure portage doesnt do any such thing
	find ${Ddir} -exec touch '{}' \;

	games_make_wrapper ${PN} ./${PN} ${dir}
	newicon ${CDROM_ROOT}/icon.xpm ${PN}.xpm

	prepgamesdirs
	make_desktop_entry ${PN} "FAKK2" ${PN}
}

pkg_postinst() {
	games_pkg_postinst
	echo
	ewarn "There are two possible security bugs in this package, both causing a denial of"
	ewarn "service.  One affects the game when running a server, the other when running as"
	ewarn "a client.  For more information, see bug #82149."
	echo
	einfo "To play the game run:"
	einfo " fakk2"
}
