# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-fonts/konfont/konfont-0.1.ebuild,v 1.10 2006/11/26 23:01:13 flameeyes Exp $

IUSE=""

MY_P="${P/-/_}.orig"

DESCRIPTION="Fontset for KON2"
SRC_URI="mirror://debian/dists/potato/main/source/utils/${MY_P}.tar.gz"
# There seems to be no real homepage for this package
HOMEPAGE="http://packages.debian.org/stable/utils/konfont"
LICENSE="as-is"
SLOT=0
KEYWORDS="amd64 arm ~hppa ia64 ppc s390 sh x86 ~x86-fbsd"

DEPEND=""

S="${WORKDIR}/${MY_P/_/-}/fonts"

# Only installs fonts
RESTRICT="strip binchecks"

src_install(){
	insinto /usr/share/fonts
	doins pubfont.*.gz || die
}
