# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-proto/xcmiscproto/xcmiscproto-1.1.2.ebuild,v 1.12 2006/06/30 23:10:54 spyderous Exp $

# Must be before x-modular eclass is inherited
#SNAPSHOT="yes"

inherit x-modular

DESCRIPTION="X.Org XCMisc protocol headers"
RESTRICT="mirror"
KEYWORDS="alpha amd64 arm ~hppa ~ia64 mips ppc ppc64 ~s390 sh sparc x86 ~x86-fbsd"
RDEPEND=""
DEPEND="${RDEPEND}"
