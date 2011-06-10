# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/ksudoku/ksudoku-4.6.3.ebuild,v 1.4 2011/06/10 11:50:18 hwoarang Exp $

EAPI=4

KDE_HANDBOOK="optional"
KMNAME="kdegames"
OPENGL_REQUIRED="always"
inherit kde4-meta

DESCRIPTION="KDE Sudoku"
KEYWORDS="amd64 ~ppc ~ppc64 x86 ~amd64-linux ~x86-linux"
IUSE="debug"

RDEPEND="
	!games-puzzle/ksudoku
"
