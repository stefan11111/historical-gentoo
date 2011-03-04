# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/ksudoku/ksudoku-4.6.1.ebuild,v 1.1 2011/03/04 17:59:58 alexxy Exp $

EAPI=3

KDE_HANDBOOK="optional"
KMNAME="kdegames"
OPENGL_REQUIRED="always"
inherit kde4-meta

DESCRIPTION="KDE Sudoku"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86 ~amd64-linux ~x86-linux"
IUSE="debug"

RDEPEND="
	!kdeprefix? ( !games-puzzle/ksudoku )
"
