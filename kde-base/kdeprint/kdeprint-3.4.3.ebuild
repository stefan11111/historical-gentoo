# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdeprint/kdeprint-3.4.3.ebuild,v 1.3 2005/11/24 20:08:11 corsair Exp $

KMNAME=kdebase
MAXKDEVER=$PV
KM_DEPRANGE="$PV $MAXKDEVER"
inherit kde-meta eutils

DESCRIPTION="KDE printer queue/device manager"
KEYWORDS="~alpha ~amd64 ~ppc ppc64 sparc ~x86"
IUSE="cups"

DEPEND="cups? ( net-print/cups )"

src_compile() {
	myconf="$myconf `use_with cups`"
	kde-meta_src_compile
}
