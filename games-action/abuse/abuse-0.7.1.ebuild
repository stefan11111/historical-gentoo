# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-action/abuse/abuse-0.7.1.ebuild,v 1.7 2008/08/14 16:46:55 mr_bones_ Exp $

inherit eutils games

ZOY="http://abuse.zoy.org/raw/Downloads"

DESCRIPTION="port of Abuse by Crack Dot Com"
HOMEPAGE="http://abuse.zoy.org/"
SRC_URI="${ZOY}/${P}.tar.gz
	!demo? ( ${ZOY}/abuse-data-2.00.tar.gz )
	demo? ( ${ZOY}/abuse-lib-2.00.tar.gz )
	sounds? ( ${ZOY}/abuse-sfx-2.00.tar.gz )
	levels? ( ${ZOY}/abuse-frabs-2.11.tar.gz )"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ppc sparc x86"
IUSE="demo levels sounds"

RDEPEND=">=media-libs/libsdl-1.1.6"
DEPEND="${RDEPEND}
	x11-libs/libXt
	virtual/opengl"
src_unpack() {
	unpack ${A}
	# fix placing additional patches
	cp -rf "${WORKDIR}"/abuse-frabs-2.11/{addon,art,levels,lisp,music,netlevel,register} "${WORKDIR}"
	cp -rf "${WORKDIR}"/abuse-lib-2.00.orig/unpacked/{addon,art,levels,lisp,abuse.lsp} "${WORKDIR}"
	cp -rf "${WORKDIR}"/abuse-sfx-2.00.orig/sfx "${WORKDIR}"
	rm -rf "${WORKDIR}"/abuse-frabs-2.11/ "${WORKDIR}"/abuse-lib-2.00.orig/ "${WORKDIR}"/abuse-sfx-2.00.orig/
	cd "${S}"
	# fix bug #231822
	sed -i \
		-e "s:/var/games/abuse:${GAMES_DATADIR}/${PN}:" \
		src/sdlport/setup.cpp || or die "sed setup.cpp failed"
}

src_compile() {
	# Abuse auto-appends games, so point to the base
	egamesconf --datadir="${GAMES_DATADIR_BASE}" || die
	emake || die "emake failed"
}

src_install() {
	# Source-based install
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc AUTHORS ChangeLog README TODO

	# Data install
	insinto "${GAMES_DATADIR}"/"${PN}"
	doins -r "${WORKDIR}"/{addon,art,levels,lisp,music,netlevel,register,sfx} \
		"${WORKDIR}"/abuse.lsp \
		|| die "doins failed"

	# Icons/desktop entry
	doicon ${PN}.png
	make_desktop_entry abuse "Abuse" ${PN}

	prepgamesdirs
}

pkg_postinst() {
	games_pkg_postinst
	elog "NOTE: If you had previous version of abuse installed"
	elog "you may need to remove ~/.abuse for the game to work correctly."
}
