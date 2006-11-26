# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-fonts/jisx0213-fonts/jisx0213-fonts-20040425-r2.ebuild,v 1.4 2006/11/26 22:56:22 flameeyes Exp $

inherit font font-ebdftopcf

DESCRIPTION="Japanese fixed fonts that cover JIS0213 charset"

HOMEPAGE="http://www12.ocn.ne.jp/~imamura/jisx0213.html"
SRC_BASE1="http://www12.ocn.ne.jp/~imamura"
SRC_BASE2="http://gitatsu.hp.infoseek.co.jp/bdf"
SRC_URI="${SRC_BASE1}/jiskan16-2004-1.bdf.gz
	${SRC_BASE1}/jiskan16-2000-1.bdf.gz
	${SRC_BASE1}/jiskan16-2000-2.bdf.gz
	${SRC_BASE1}/K14-2004-1.bdf.gz
	${SRC_BASE1}/K14-2000-1.bdf.gz
	${SRC_BASE1}/K14-2000-2.bdf.gz
	${SRC_BASE1}/K12-1.bdf.gz
	${SRC_BASE1}/K12-2.bdf.gz
	${SRC_BASE1}/A14.bdf.gz
	${SRC_BASE1}/A12.bdf.gz
	${SRC_BASE2}/jiskan24-2000-1.bdf.gz
	${SRC_BASE2}/jiskan24-2000-2.bdf.gz"

LICENSE="public-domain"
SLOT="0"

KEYWORDS="~alpha ~amd64 arm ia64 ~ppc s390 sh ~sparc ~x86 ~x86-fbsd"

S="${WORKDIR}"
FONT_S="${S}"
FONT_PN="${PN/-fonts/}"
FONTDIR="/usr/share/fonts/${FONT_PN}"
FONT_SUFFIX="pcf.gz"

# Only installs fonts
RESTRICT="strip binchecks"

pkg_postinst(){
	elog "You need you add following line into 'Section \"Files\"' in"
	elog "XF86Config and reboot X Window System, to use these fonts."
	elog ""
	elog "\t FontPath \"${FONTDIR}\""
	elog ""
}
