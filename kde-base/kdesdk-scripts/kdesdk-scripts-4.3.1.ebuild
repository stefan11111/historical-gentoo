# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdesdk-scripts/kdesdk-scripts-4.3.1.ebuild,v 1.3 2009/10/18 15:05:13 maekke Exp $

EAPI="2"

KMNAME="${PN/-*/}"
KMMODULE="${PN/*-/}"

inherit kde4-meta

DESCRIPTION="KDE SDK Scripts"
KEYWORDS="~alpha amd64 ~hppa ~ia64 ~ppc ~ppc64 x86"
IUSE="+handbook debug"

src_prepare() {
	# bug 275069
	sed -ie 's:colorsvn::' scripts/CMakeLists.txt || die

	kde4-meta_src_prepare
}
