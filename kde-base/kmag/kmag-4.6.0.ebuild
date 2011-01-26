# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kmag/kmag-4.6.0.ebuild,v 1.1 2011/01/26 20:28:23 alexxy Exp $

EAPI="3"

KDE_HANDBOOK="optional"
KMNAME="kdeaccessibility"
inherit kde4-meta

DESCRIPTION="KDE screen magnifier"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86 ~amd64-linux ~x86-linux"
IUSE="debug"

RDEPEND="
	$(add_kdebase_dep kaccessible)
"
