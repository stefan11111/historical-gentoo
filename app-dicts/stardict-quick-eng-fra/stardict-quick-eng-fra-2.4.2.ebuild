# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-dicts/stardict-quick-eng-fra/stardict-quick-eng-fra-2.4.2.ebuild,v 1.4 2004/06/29 22:37:36 agriffis Exp $

FROM_LANG="English"
TO_LANG="French"
DICT_PREFIX="quick_"

inherit stardict

HOMEPAGE="http://stardict.sourceforge.net/Dictionaries_Quick.php"

KEYWORDS="~x86 ~ppc"
IUSE=""

RDEPEND=">=app-dicts/stardict-2.4.2"
