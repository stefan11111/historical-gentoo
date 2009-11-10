# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-misc/yawp/yawp-0.2.3.ebuild,v 1.1 2009/11/10 19:09:08 ssuominen Exp $

EAPI=2
KDE_LINGUAS="af cs de es fr it pl ru sk sl"
inherit kde4-base

DESCRIPTION="Yet Another Weather Plasmoid"
HOMEPAGE="http://www.kde-look.org/content/show.php?content=94106"
SRC_URI="mirror://sourceforge/yawp/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="4"
KEYWORDS="~amd64 ~x86"
IUSE="debug"

RDEPEND=">=kde-base/plasma-workspace-${KDE_MINIMAL}"

DOCS="README TODO"
