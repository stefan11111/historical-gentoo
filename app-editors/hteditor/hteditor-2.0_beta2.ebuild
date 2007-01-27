# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-editors/hteditor/hteditor-2.0_beta2.ebuild,v 1.1 2007/01/27 10:32:57 dragonheart Exp $

inherit eutils autotools

MY_PV=${PV/_/}
DESCRIPTION="editor for executable files"
HOMEPAGE="http://hte.sourceforge.net/"
SRC_URI="mirror://sourceforge/hte/ht-${MY_PV}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="X"

RDEPEND="
	sys-libs/ncurses
	X? ( x11-libs/libX11 )
	>=dev-libs/lzo-2"
DEPEND="${RDEPEND}
	sys-devel/bison
	sys-devel/flex"

S="${WORKDIR}/ht-${MY_PV}"

src_unpack() {
	unpack ${A}
	epatch "${FILESDIR}"/${P}-optionallzo.patch
	epatch "${FILESDIR}"/${P}-regexneedstdlib.patch
	cd "${S}"
	eautoreconf
}
src_compile() {
	econf --disable-release --enable-maintainer-mode $(use_enable X x11-textmode) || die
	emake || die
}

src_install() {
	emake DESTDIR="${D}" install || die
	dodoc AUTHORS KNOWNBUGS TODO README ChangeLog
	dohtml doc/ht.html
	doinfo doc/ht.info doc/hthelp.info
}
