# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-themes/mosfet-liquid-widgets/mosfet-liquid-widgets-0.9.6_pre4.ebuild,v 1.2 2003/02/13 17:43:57 vapier Exp $
inherit kde-base

need-kde 3.1_rc1

S=${WORKDIR}/mosfet-liquid0.9.6pre4
DESCRIPTION="Mosfet's High-Permormance Liquid Widgets and Style for KDE 3.1.x"
SRC_URI="http://www.mosfet.org/mosfet-liquid${PV//_/-}.tar.gz"
HOMEPAGE="http://www.mosfet.org/liquid.html"
LICENSE="BSD"

KEYWORDS="~ppc"

newdepend ">=kde-base/kdebase-3.1_rc1"
