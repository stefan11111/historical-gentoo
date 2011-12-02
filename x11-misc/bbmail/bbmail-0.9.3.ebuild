# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/bbmail/bbmail-0.9.3.ebuild,v 1.5 2011/12/02 22:53:49 hwoarang Exp $

EAPI=2
inherit autotools eutils

DESCRIPTION="blackbox mail notification"
HOMEPAGE="http://www.sourceforge.net/projects/bbtools"
SRC_URI="mirror://sourceforge/bbtools/${P}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="amd64 ~ppc ~sparc x86 ~x86-fbsd"
IUSE=""

RDEPEND="x11-wm/blackbox
	x11-libs/libX11
	x11-libs/libXext"
DEPEND="${RDEPEND}
	x11-proto/xproto"

src_prepare() {
	epatch "${FILESDIR}"/${P}-gcc4.3.patch \
		"${FILESDIR}"/${P}-gcc4.4.patch
	eautoreconf
}

src_install () {
	emake DESTDIR="${D}" install || die "emake install failed"
	dobin scripts/bbmailparsefm.pl
	dodoc AUTHORS BUGS ChangeLog INSTALL NEWS README TODO
}
