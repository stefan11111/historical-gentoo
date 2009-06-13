# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/kprof/kprof-1.4.3-r1.ebuild,v 1.6 2009/06/13 12:15:35 scarabeus Exp $

inherit kde eutils

DESCRIPTION="A KDE3 visual tool helping developers to analyze the profiling results generated by code profilers."
HOMEPAGE="http://kprof.sourceforge.net/"
SRC_URI="mirror://sourceforge/kprof/${P}.tar.bz2
	mirror://gentoo/kde-admindir-3.5.5.tar.bz2"

SLOT="3.5"
LICENSE="GPL-2"
KEYWORDS="~amd64 ~ppc ~sparc x86"
IUSE=""

RDEPEND="media-gfx/graphviz"
need-kde 3.5

PATCHES="${FILESDIR}/${P}-debian7.diff
		${FILESDIR}/${P}-gcc4.3.patch"

S="${WORKDIR}/${PN}"

src_unpack() {
	kde_src_unpack

	# Fixing the desktop file to use UTF-8.
	sed -i -e "s:r\xE9sultats:résultats:" "${S}"/kprof/kprof.desktop \
		|| die "sed'ing the desktop file failed."
}

src_install() {
	MAKEOPTS="-j1" kde_src_install
}
