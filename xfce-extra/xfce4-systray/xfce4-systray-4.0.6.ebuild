# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/xfce-extra/xfce4-systray/xfce4-systray-4.0.6.ebuild,v 1.3 2004/08/06 08:53:24 gmsoft Exp $

IUSE=""

DESCRIPTION="Xfce4 system tray"
HOMEPAGE="http://www.xfce.org/"
SRC_URI="http://www.xfce.org/archive/xfce-${PV}/src/${P}.tar.gz
	http://hannelore.f1.fhtw-berlin.de/mirrors/xfce4/xfce-${PV}/src/${P}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~ia64 x86 ~ppc ~alpha ~sparc ~amd64 hppa ~mips"

RDEPEND=">=x11-libs/gtk+-2.0.6
	dev-libs/libxml2
	=xfce-base/libxfce4util-${PV}
	=xfce-base/libxfcegui4-${PV}
	=xfce-base/libxfce4mcs-${PV}
	=xfce-base/xfce-mcs-manager-${PV}
	=xfce-base/xfce4-panel-${PV}"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

src_install() {
	make DESTDIR=${D} install || die
	dodoc AUTHORS INSTALL COPYING README ChangeLog
}
