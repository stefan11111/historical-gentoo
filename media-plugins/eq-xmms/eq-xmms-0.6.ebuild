# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/eq-xmms/eq-xmms-0.6.ebuild,v 1.5 2005/03/15 19:40:25 luckyduck Exp $

IUSE=""

inherit eutils

DESCRIPTION="EQU is a realtime graphical equalizer effect plugin that will equalize almost everything that you play through XMMS, not just the MP3s"
HOMEPAGE="http://equ.sourceforge.net/"
SRC_URI="mirror://sourceforge/equ/${P}.tar.gz"
RESTRICT="nomirror"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~amd64 ~sparc ~ppc"

RDEPEND="media-sound/xmms"
DEPEND="${RDEPEND}
	!x86? ( >=sys-devel/automake-1.7 )"

src_unpack() {
	unpack ${A}

	if ! use x86; then
		cd ${S}
		epatch ${FILESDIR}/${P}-nonx86.patch

		WANT_AUTOMAKE=1.7 aclocal
		WANT_AUTOMAKE=1.7 automake
		WANT_AUTOCONF=2.5 autoconf
		libtoolize --copy --force
	fi
}

src_install() {
	make DESTDIR=${D} install || die

	dodoc AUTHORS BUGS COPYING ChangeLog INSTALL NEWS README README.BSD SKINS TODO
}
