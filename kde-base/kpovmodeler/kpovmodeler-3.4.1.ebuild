# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kpovmodeler/kpovmodeler-3.4.1.ebuild,v 1.6 2005/07/08 04:04:14 weeve Exp $

KMNAME=kdegraphics
MAXKDEVER=$PV
KM_DEPRANGE="$PV $MAXKDEVER"
inherit kde-meta eutils

DESCRIPTION="KDE: Modeler for POV-Ray Scenes"
KEYWORDS="amd64 ppc ppc64 sparc x86"
IUSE=""
DEPEND="virtual/opengl"
RDEPEND="${DEPEND}
	media-gfx/povray"
