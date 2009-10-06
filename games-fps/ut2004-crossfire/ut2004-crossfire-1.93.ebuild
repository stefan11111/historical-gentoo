# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-fps/ut2004-crossfire/ut2004-crossfire-1.93.ebuild,v 1.1 2009/10/06 15:46:01 nyhm Exp $

EAPI=2

MOD_NAME="Crossfire"
MOD_DESC="Special Forces vs Terrorists"
MOD_DIR="TOCrossfire"
MOD_ICON="Help/icons/TOC_TERROR2.png"

inherit games games-mods

HOMEPAGE="http://www.to-crossfire.net/"
SRC_URI="ftp://to-crossfire.speicherland.com/TOC/client/TOCrossfire_beta_${PV}_full.zip
	http://www.to-crossfire.org/mirrors/client/TOCrossfire_beta_${PV}_full.zip"

# See Help/EULA.txt
LICENSE="free-noncomm"
KEYWORDS="~amd64 ~x86"
IUSE="dedicated opengl"

src_unpack() {
	unpack ${A}
	unpack ./TOCinstall.tgz
}

src_prepare() {
	cd ${MOD_DIR} || die
	rm -f *.{bat,exe} Help/*.{exe,zip}
}
