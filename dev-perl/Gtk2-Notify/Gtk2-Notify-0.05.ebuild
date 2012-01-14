# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Gtk2-Notify/Gtk2-Notify-0.05.ebuild,v 1.1 2012/01/14 15:45:31 ssuominen Exp $

EAPI=4

MODULE_AUTHOR=FLORA

inherit perl-module

DESCRIPTION="A perl interface to the notification library"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"

RDEPEND="dev-perl/glib-perl
	dev-perl/gtk2-perl
	>=x11-libs/libnotify-0.7"
DEPEND="${RDEPEND}
	dev-perl/extutils-depends
	dev-perl/extutils-pkgconfig
	test? ( dev-perl/Test-Exception )"

SRC_TEST="do"

PATCHES=( "${FILESDIR}"/${P}-libnotify.patch )
