# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdewebdev-meta/kdewebdev-meta-4.3.4.ebuild,v 1.2 2010/01/16 19:34:33 abcd Exp $

EAPI="2"
inherit kde4-functions

DESCRIPTION="KDE WebDev - merge this to pull in all kdewebdev-derived packages"
HOMEPAGE="http://www.kde.org/"

LICENSE="GPL-2"
SLOT="4.3"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86"
IUSE="aqua kdeprefix"

RDEPEND="
	$(add_kdebase_dep kfilereplace)
	$(add_kdebase_dep kimagemapeditor)
	$(add_kdebase_dep klinkstatus)
	$(add_kdebase_dep kommander)
	$(add_kdebase_dep kxsldbg)
	$(block_other_slots)
"
