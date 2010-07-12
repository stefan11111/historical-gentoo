# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-rpg/nwn-cep/nwn-cep-2.0.ebuild,v 1.7 2010/07/12 17:07:46 mr_bones_ Exp $

EAPI=2
inherit eutils games

DESCRIPTION="High quality custom content addon for Neverwinter Nights"
HOMEPAGE="http://nwvault.ign.com/cep/"
SRC_URI="http://vnfiles.ign.com/nwvault.ign.com/fms/files/hakpaks/7000/CEPv2_full.rar"

LICENSE="as-is"
SLOT="2"
KEYWORDS="-* amd64 x86"
IUSE=""

DEPEND="app-arch/unrar"
RDEPEND=">=games-rpg/nwn-1.68"

S=${WORKDIR}

dir=${GAMES_PREFIX_OPT}/nwn

pkg_setup() {
	games_pkg_setup
	if ! has_version 'games-rpg/nwn-data[hou,sou]' ; then
		eerror "${P} requires NWN v1.68, Shadows of Undrentide, and Hordes of"
		eerror "the Underdark. Please make sure you have all three before using"
		eerror "this patch."
		die "Requirements not met"
	fi
}

src_install() {
	local i
	for i in hak tlk erf
	do
		insinto "${dir}"/${i}
		doins *.${i} || die "${i} failed"
	done
	insinto "${dir}"/modules
	doins *.mod || die "mod failed"
	insinto "${dir}"/cep
	doins *.pdf || die "pdf failed"
	prepgamesdirs
}
