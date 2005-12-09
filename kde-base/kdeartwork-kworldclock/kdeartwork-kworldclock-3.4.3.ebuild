# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdeartwork-kworldclock/kdeartwork-kworldclock-3.4.3.ebuild,v 1.5 2005/12/09 03:49:33 josejx Exp $

KMMODULE=kworldclock
KMNAME=kdeartwork
MAXKDEVER=$PV
KM_DEPRANGE="$PV $MAXKDEVER"
inherit kde-meta

DESCRIPTION="kworldclock from kdeartwork"
KEYWORDS="~alpha amd64 ppc ppc64 sparc ~x86"
IUSE=""

RDEPEND="$(deprange-dual $PV $MAXKDEVER kde-base/kworldwatch)"
