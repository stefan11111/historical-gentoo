# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-extra/libgail-gnome/libgail-gnome-1.20.1.ebuild,v 1.9 2009/04/27 10:15:05 armin76 Exp $

inherit gnome2

DESCRIPTION="Gail libraries for GNOME"
HOMEPAGE="http://developer.gnome.org/projects/gap/"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="alpha amd64 arm ~hppa ia64 ppc ppc64 ~sh sparc x86 ~x86-fbsd"
IUSE=""

RDEPEND=">=dev-libs/atk-1.7.2
	>=x11-libs/gtk+-1.3.11
	>=gnome-base/libbonobo-1.1
	>=gnome-base/libbonoboui-1.1
	>=gnome-base/libgnomeui-1.1
	>=gnome-base/gnome-panel-0.0.18
	>=gnome-extra/at-spi-0.10"
DEPEND="${RDEPEND}
	>=dev-util/pkgconfig-0.9"

DOCS="AUTHORS ChangeLog NEWS README"
