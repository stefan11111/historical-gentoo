# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-dicts/aspell-it/aspell-it-2.2.20050523.ebuild,v 1.4 2007/01/02 04:05:37 vapier Exp $

ASPELL_LANG="Italian"
ASPOSTFIX="6"

inherit aspell-dict

LICENSE="GPL-2"

KEYWORDS="~amd64 ~arm ~hppa ~ia64 ~m68k ~ppc ~s390 ~sh ~sparc ~x86 ~x86-fbsd"

FILENAME="aspell6-it-2.2_20050523-0"
SRC_URI="ftp://ftp.gnu.org/gnu/aspell/dict/it/${FILENAME}.tar.bz2"
S=${WORKDIR}/${FILENAME}
