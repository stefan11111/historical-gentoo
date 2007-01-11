# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/lndir/lndir-1.0.1.ebuild,v 1.9 2007/01/11 22:18:41 opfer Exp $

# Must be before x-modular eclass is inherited
#SNAPSHOT="yes"

inherit x-modular

DESCRIPTION="create a shadow directory of symbolic links to another directory tree"
KEYWORDS="~amd64 ~ppc ppc64 sparc x86"
RDEPEND=""
DEPEND="${RDEPEND}
		x11-proto/xproto"
