# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-themes/gnome-backgrounds/gnome-backgrounds-2.24.1.ebuild,v 1.7 2009/12/03 16:54:36 ranger Exp $

GCONF_DEBUG="no"

inherit gnome2

DESCRIPTION="A set of backgrounds packaged with the GNOME desktop"
HOMEPAGE="http://www.gnome.org/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 arm ~hppa ia64 ppc ppc64 ~sh sparc x86 ~x86-fbsd"
IUSE=""

RDEPEND=""
DEPEND="sys-devel/gettext
	>=dev-util/intltool-0.35"

DOCS="AUTHORS ChangeLog NEWS README"
