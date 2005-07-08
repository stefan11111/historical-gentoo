# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdeartwork-kscreensaver/kdeartwork-kscreensaver-3.4.1.ebuild,v 1.10 2005/07/08 03:28:02 weeve Exp $

KMMODULE=kscreensaver
KMNAME=kdeartwork
MAXKDEVER=$PV
KM_DEPRANGE="$PV $MAXKDEVER"
inherit kde-meta

DESCRIPTION="Extra screensavers for kde"
KEYWORDS="amd64 ppc ppc64 sparc x86"
IUSE="opengl xscreensaver"
DEPEND="$(deprange-dual $PV $MAXKDEVER kde-base/kscreensaver)
	opengl? ( virtual/opengl )
	xscreensaver? ( x11-misc/xscreensaver )"

# Fix compilation with --without-gl and detection of arts.
# See kde bug 89387 and 102398. Applied for 3.4.2.
PATCHES1="${FILESDIR}/kdeartwork-3.4.1-configure.patch"

src_compile() {
	myconf="$myconf --with-dpms $(use_with opengl gl)"
	kde-meta_src_compile
}
