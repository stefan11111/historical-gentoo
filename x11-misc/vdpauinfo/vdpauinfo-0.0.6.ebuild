# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/vdpauinfo/vdpauinfo-0.0.6.ebuild,v 1.1 2009/10/22 15:56:19 cardoe Exp $

EAPI="2"

DESCRIPTION="Displays info about your card's VDPAU support"
HOMEPAGE="http://www.freedesktop.org/wiki/Software/VDPAU"
SRC_URI="http://people.freedesktop.org/~aplattner/vdpau/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="x11-libs/libX11
		x11-libs/libvdpau"
DEPEND="${RDEPEND}
		x11-proto/xproto"

src_install() {
	emake DESTDIR="${D}" install || die "make install failed"
}
