# Copyright 2006-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-dicts/myspell-sv/myspell-sv-20060316.ebuild,v 1.4 2006/06/04 11:12:30 kevquinn Exp $

DESCRIPTION="Swedish dictionaries for myspell/hunspell"
LICENSE="LGPL-2.1"
HOMEPAGE="http://lingucomponent.openoffice.org/ http://sv.speling.org/"

KEYWORDS="~amd64 ~ppc ~sparc ~x86 ~x86-fbsd"

MYSPELL_SPELLING_DICTIONARIES=(
"sv,SE,sv_SE,Swedish (Sweden),sv_SE.zip"
)

MYSPELL_HYPHENATION_DICTIONARIES=(
"sv,SE,hyph_sv_SE,Swedish(Sweden),hyph_sv_SE.zip"
)

MYSPELL_THESAURUS_DICTIONARIES=(
)

inherit myspell
