# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdetoys-meta/kdetoys-meta-3.5.0_beta2.ebuild,v 1.2 2005/10/22 06:53:31 halcy0n Exp $
MAXKDEVER=$PV

inherit kde-functions
DESCRIPTION="kdetoys - merge this to pull in all kdetoys-derived packages"
HOMEPAGE="http://www.kde.org/"

LICENSE="GPL-2"
SLOT="3.5"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="
$(deprange $PV $MAXKDEVER kde-base/amor)
$(deprange $PV $MAXKDEVER kde-base/eyesapplet)
$(deprange $PV $MAXKDEVER kde-base/fifteenapplet)
$(deprange $PV $MAXKDEVER kde-base/kmoon)
$(deprange $PV $MAXKDEVER kde-base/kodo)
$(deprange $PV $MAXKDEVER kde-base/kteatime)
$(deprange 3.5_beta1 $MAXKDEVER kde-base/ktux)
$(deprange $PV $MAXKDEVER kde-base/kweather)
$(deprange $PV $MAXKDEVER kde-base/kworldwatch)
"
