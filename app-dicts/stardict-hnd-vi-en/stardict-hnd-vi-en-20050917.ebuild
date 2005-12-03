# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-dicts/stardict-hnd-vi-en/stardict-hnd-vi-en-20050917.ebuild,v 1.1 2005/12/03 11:40:45 pclouds Exp $

FROM_LANG="Vietnamese"
TO_LANG="English"

inherit stardict

HOMEPAGE="http://forum.vnoss.org/viewtopic.php?id=1818"
SRC_URI="http://james.dyndns.ws/pub/Dictionary/StarDict-James/VietAnh23K.zip"

KEYWORDS="~x86"
IUSE=""
S="${WORKDIR}/VietAnh"

RDEPEND=">=app-dicts/stardict-2.4.2"
