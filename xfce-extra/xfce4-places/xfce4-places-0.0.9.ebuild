# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/xfce-extra/xfce4-places/xfce4-places-0.0.9.ebuild,v 1.2 2007/03/17 17:28:52 nixnut Exp $

inherit xfce44

xfce44
xfce44_gzipped

RESTRICT="test"

DESCRIPTION="Rewrite of GNOME Places menu for panel"
KEYWORDS="~ppc ~x86"
IUSE="debug"

RDEPEND=""
DEPEND="${RDEPEND}
	dev-util/intltool"

DOCS="AUTHORS ChangeLog NEWS README TODO"

xfce44_goodies_panel_plugin
