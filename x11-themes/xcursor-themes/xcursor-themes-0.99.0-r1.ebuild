# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-themes/xcursor-themes/xcursor-themes-0.99.0-r1.ebuild,v 1.2 2005/08/20 22:35:10 lu_zero Exp $

# Must be before x-modular eclass is inherited
SNAPSHOT="yes"

inherit x-modular

DESCRIPTION="X.Org cursors data"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
RDEPEND="x11-libs/libX11
	x11-libs/libXcursor
	=media-libs/libpng-1.2*"
DEPEND="${RDEPEND}
	x11-apps/xcursorgen"

PATCHES="${FILESDIR}/make-cursordir-configurable.patch"

CONFIGURE_OPTIONS="--with-cursordir=/usr/share/cursors/xorg-x11"
