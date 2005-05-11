# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libIDL/libIDL-0.8.5.ebuild,v 1.6 2005/05/11 17:01:16 gmsoft Exp $

inherit gnome2

DESCRIPTION="CORBA tree builder"
HOMEPAGE="http://www.gnome.org/"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="~alpha amd64 ~arm hppa ia64 ~mips ppc ~ppc-macos ~ppc64 sparc x86"
IUSE=""

RDEPEND=">=dev-libs/glib-2
	>=sys-devel/flex-2.5.4"

DEPEND="${RDEPEND}
	>=dev-util/pkgconfig-0.12.0"

DOCS="AUTHORS BUGS ChangeLog NEWS README"
