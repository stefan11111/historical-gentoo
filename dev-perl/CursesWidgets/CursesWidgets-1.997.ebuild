# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/CursesWidgets/CursesWidgets-1.997.ebuild,v 1.1 2003/03/22 02:44:53 pylon Exp $

inherit perl-module

IUSE=""
#S=${WORKDIR}/${P}
DESCRIPTION="Curses::Widgets is designed to provide high level APIs for rapid user interface design on the console in Perl."
HOMEPAGE="http://www.digitalmages.com/perl/CursesWidgets/index.html"
SRC_URI="http://www.digitalmages.com/perl/CursesWidgets/downloads/${P}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="ppc"

DEPEND="${DEPEND}
	>=sys-libs/ncurses-5
	>=dev-perl/Curses-1.06"
RDEPEND=""
