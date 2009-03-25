# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-proto/renderproto/renderproto-0.9.3-r1.ebuild,v 1.1 2009/03/25 13:47:10 remi Exp $

# Must be before x-modular eclass is inherited
#SNAPSHOT="yes"

inherit x-modular

DESCRIPTION="X.Org Render protocol headers"

KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86 ~x86-fbsd"

IUSE=""
RDEPEND=""
DEPEND="${RDEPEND}"

PATCHES=( "${FILESDIR}/0.9.3-fix-render-h-compilation.patch" )
