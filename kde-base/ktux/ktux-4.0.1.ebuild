# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/ktux/ktux-4.0.1.ebuild,v 1.3 2008/03/04 03:54:35 jer Exp $

EAPI="1"

KMNAME=kdetoys
inherit kde4-meta

DESCRIPTION="KDE: screensaver featuring the Space-Faring Tux"
KEYWORDS="~amd64 ~hppa ~x86"
IUSE="debug"

DEPEND=">=app-misc/strigi-0.5.7
	>=kde-base/kscreensaver-${PV}:${SLOT}"
RDEPEND="${DEPEND}"

src_compile() {
	mycmakeargs="${mycmakeargs}
		$(cmake-utils_use_with kde Plasma)"

	kde4-base_src_compile
}
