# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/gnome-base/nautilus/nautilus-2.0.0-r1.ebuild,v 1.2 2002/06/15 14:43:11 spider Exp $

inherit gnome2

S=${WORKDIR}/${P}
DESCRIPTION="A filemanager for the Gnome2 desktop"
SRC_URI="ftp://ftp.gnome.org/pub/gnome/pre-gnome2/sources/${PN}/${P}.tar.bz2"
HOMEPAGE="http://www.gnome.org/"
SLOT="0"
LICENSE="GPL-2 LGPL-2.1 FDL-1.1"

RDEPEND="app-admin/fam-oss
	>=dev-libs/glib-2.0.1
	>=gnome-base/gconf-1.1.11
	>=x11-libs/gtk+-2.0.2
	>=dev-libs/libxml2-2.4.22
	>=gnome-base/gnome-vfs-1.9.16
	>=media-sound/esound-0.2.27
	>=gnome-base/bonobo-activation-1.0.0
	>=gnome-base/eel-2.0.0
	>=gnome-base/gail-0.16
	>=gnome-base/libgnome-2.0.1
	>=gnome-base/libgnomeui-2.0.0
	>=gnome-base/gnome-desktop-2.0.0
	>=media-libs/libart_lgpl-2.3.8-r1
	>=gnome-base/libbonobo-2.0.0
	>=gnome-base/libbonoboui-2.0.0
	>=gnome-base/libgnomecanvas-2.0.0
	>=gnome-base/librsvg-1.1.6
	>=app-text/scrollkeeper-0.3.6"

DEPEND="${RDEPEND} >=dev-util/pkgconfig-0.12.0"


G2CONF="${G2CONF} --enable-platform-gnome-2"
DOCS="AUTHORS COPYIN* ChangeLo* HACKING INSTALL MAINTAINERS NEWS README THANKS TODO"

SCHEMAS="nautilus.schemas apps_nautilus_preferences.schemas"


