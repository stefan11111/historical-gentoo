# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-cpp/gconfmm/gconfmm-2.6.1.ebuild,v 1.4 2004/05/21 14:10:37 khai Exp $

inherit gnome2

DESCRIPTION="C++ bindings for GConf"
HOMEPAGE="http://gtkmm.sourceforge.net/"

IUSE=""
LICENSE="LGPL-2.1"
KEYWORDS="~x86"
SLOT="2.6"

RDEPEND=">=gnome-base/gconf-2.4
	>=dev-cpp/glibmm-2.4
	>=dev-cpp/gtkmm-2.4"

DEPEND=">=dev-util/pkgconfig-0.12.0
	${RDEPEND}"

DOCS="AUTHORS COPYING* ChangeLog NEWS README INSTALL"

src_compile() {
		gnome2_src_compile
}
