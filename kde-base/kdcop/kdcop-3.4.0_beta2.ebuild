# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdcop/kdcop-3.4.0_beta2.ebuild,v 1.2 2005/02/27 20:21:32 danarmak Exp $

KMNAME=kdebase
MAXKDEVER=3.4.0_rc1
KM_DEPRANGE="$PV $MAXKDEVER"
inherit kde-meta eutils

DESCRIPTION="KDE: graphical DCOP browser/client"
KEYWORDS="~x86"
IUSE=""
KMNODOCS="true"

