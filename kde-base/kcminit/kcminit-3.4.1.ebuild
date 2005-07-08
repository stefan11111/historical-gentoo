# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kcminit/kcminit-3.4.1.ebuild,v 1.6 2005/07/08 03:57:12 weeve Exp $

KMNAME=kdebase
MAXKDEVER=$PV
KM_DEPRANGE="$PV $MAXKDEVER"
inherit kde-meta eutils

DESCRIPTION="KCMInit - runs startups initialization for Control Modules."
KEYWORDS="amd64 ppc ppc64 sparc x86"
IUSE=""


