# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kwrited/kwrited-4.7.3.ebuild,v 1.2 2011/12/07 11:47:49 phajdan.jr Exp $

EAPI=4
KMNAME="kde-workspace"
inherit kde4-meta

DESCRIPTION="KDE daemon listening for wall and write messages."
KEYWORDS="~amd64 ~arm ~ppc ~ppc64 x86 ~amd64-linux ~x86-linux"
IUSE="debug"

DEPEND="
	>=sys-libs/libutempter-1.1.5
"
RDEPEND="${DEPEND}"
