# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/xfce-base/xfprint/xfprint-4.2.1.ebuild,v 1.1 2005/03/17 03:04:33 bcowan Exp $

DESCRIPTION="Xfce 4 print manager panel plugin"
LICENSE="BSD"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~sparc ~x86"

RDEPEND="~xfce-base/xfce4-panel-${PV}
	app-text/a2ps
	app-text/psutils"

inherit xfce4