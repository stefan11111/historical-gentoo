# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-base/libgtop/libgtop-2.8.2.ebuild,v 1.4 2005/03/09 03:18:29 obz Exp $

inherit gnome2

DESCRIPTION="A library that provides top functionality to applications"
HOMEPAGE="http://www.gnome.org/"

LICENSE="GPL-2"
SLOT="2"
KEYWORDS="x86 ppc ~sparc ~alpha ~hppa ~amd64 ~ia64 ~mips ~ppc64"
IUSE=""

RDEPEND=">=dev-libs/glib-2.4
	dev-libs/popt"
DEPEND="${RDEPEND}
	>=dev-util/pkgconfig-0.12.0"

DOCS="AUTHORS ChangeLog NEWS README"

USE_DESTDIR="1"
