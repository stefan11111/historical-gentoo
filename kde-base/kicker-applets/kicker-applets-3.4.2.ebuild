# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kicker-applets/kicker-applets-3.4.2.ebuild,v 1.1 2005/07/28 21:16:17 danarmak Exp $
KMNAME=kdeaddons
KMNOMODULE=true
KMEXTRA="kicker-applets doc/kicker-applets"
MAXKDEVER=$PV
KM_DEPRANGE="$PV $MAXKDEVER"
inherit kde-meta

DESCRIPTION="kicker applets"
KEYWORDS=" ~amd64 ~ppc ~ppc64 ~sparc ~x86"
IUSE="xmms"
OLDDEPEND="~kde-base/kicker-$PV
	xmms? ( media-sound/xmms )"
DEPEND="xmms? ( media-sound/xmms )
$(deprange-dual $PV $MAXKDEVER kde-base/kicker)"

PATCHES="$FILESDIR/configure-fix-kdeaddons-xmms.patch"

myconf="$(use_with xmms)"
