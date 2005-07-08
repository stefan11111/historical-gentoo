# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kig/kig-3.4.1.ebuild,v 1.8 2005/07/08 03:37:06 weeve Exp $
KMNAME=kdeedu
MAXKDEVER=$PV
KM_DEPRANGE="$PV $MAXKDEVER"
inherit kde-meta

DESCRIPTION="KDE Interactive Geometry tool"
KEYWORDS="amd64 ppc ppc64 sparc x86"
IUSE=""
DEPEND=""

myconf="${myconf} --disable-kig-python-scripting"
