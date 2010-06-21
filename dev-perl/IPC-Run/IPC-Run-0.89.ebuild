# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/IPC-Run/IPC-Run-0.89.ebuild,v 1.3 2010/06/21 20:02:25 armin76 Exp $

EAPI=2

MODULE_AUTHOR=TODDR
inherit perl-module

DESCRIPTION="system() and background procs w/ piping, redirs, ptys"

SLOT="0"
KEYWORDS="alpha amd64 ia64 ~ppc ~ppc64 sparc x86"
IUSE="test"

RDEPEND=">=dev-perl/IO-Tty-1.08"
DEPEND="${RDEPEND}
	test? ( dev-perl/Test-Pod
		dev-perl/Test-Pod-Coverage )"

SRC_TEST=do
