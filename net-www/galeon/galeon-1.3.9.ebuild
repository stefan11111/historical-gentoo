# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-www/galeon/galeon-1.3.9.ebuild,v 1.1 2003/09/22 04:23:27 azarah Exp $

inherit gnome2 debug libtool

DESCRIPTION="A GNOME Web browser based on gecko (mozilla's rendering engine)"
HOMEPAGE="http://galeon.sourceforge.net"
SRC_URI="mirror://sourceforge/galeon/${P}.tar.bz2"

IUSE=""
LICENSE="GPL-2"
KEYWORDS="~x86 ~ppc ~alpha"
SLOT="0"

# supports both moz-1.3 and moz-1.4
RDEPEND="virtual/x11
	>=net-www/mozilla-1.3
	>=dev-libs/glib-2
	>=x11-libs/gtk+-2
	>=dev-libs/libxml2-2.4
	>=gnome-base/gconf-2
	>=gnome-base/ORBit2-2
	>=gnome-base/libbonobo-2
	>=gnome-base/libbonoboui-2.1.1
	>=gnome-base/libgnomeui-2.0.5
	>=gnome-base/gnome-vfs-2
	>=gnome-base/libglade-2
	app-text/scrollkeeper"

DEPEND="${RDEPEND}
	dev-util/pkgconfig
	dev-util/intltool
	>=sys-devel/gettext-0.11"

pkg_setup () {
	if [ ! -f ${ROOT}/usr/lib/mozilla/components/libwidget_gtk2.so ]
	then
		eerror "you need mozilla-1.3+ compiled against gtk+-2"
		eerror "export USE=\"gtk2\" ;emerge mozilla -p "
		die "Need Mozilla compiled with gtk+-2.0!!"
	fi
}

src_compile() {
	elibtoolize
	local moz_ver="`pkg-config --modversion mozilla-xpcom | cut -d. -f1,2 2>/dev/null`"
	local myconf="--disable-werror"

	myconf="${myconf} --with-mozilla-snapshot=${moz_ver}"

	econf ${myconf} || die "configure failed"
	make || die "compile failed"
}

DOCS="AUTHORS COPYING COPYING.README ChangeLog FAQ INSTALL README README.ExtraPrefs THANKS TODO NEWS"
