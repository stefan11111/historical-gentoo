# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-libs/rep-gtk/rep-gtk-0.18.ebuild,v 1.3 2004/02/22 16:01:50 brad_mssw Exp $

inherit eutils

IUSE=""

DESCRIPTION="A GTK+/libglade/GNOME language binding for the librep Lisp environment"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"
HOMEPAGE="http://rep-gtk.sourceforge.net/"
SLOT="gtk-2.0"
LICENSE="GPL-2"
KEYWORDS="x86 alpha ia64 amd64"

DEPEND="virtual/glibc
	>=dev-util/pkgconfig-0.12.0
	>=x11-libs/gtk+-2.0.3
	>=gnome-base/libbonobo-2.0.0
	>=gnome-base/libbonoboui-2.0.0
	>=gnome-base/libgnome-2.0.0
	>=gnome-base/libgnomeui-2.0.0
	>=gnome-base/libgnomecanvas-2.0.0
	>=gnome-base/libglade-2.0.0
	>=sys-devel/automake-1.6.1-r5
	>=dev-libs/librep-0.13"

src_compile() {

	./configure --host=${CHOST} \
	    --prefix=/usr \
	    --libexecdir=/usr/lib \
		--with-gnome \
		--with-libglade \
		--with-gdk-pixbuf \
	    --infodir=/usr/share/info || die

	emake host_type=${CHOST} || die
}

src_install() {

	make install \
		host_type=${CHOST} \
		installdir=${D}/usr/lib/rep/${CHOST} || die

	cd ${S}
	dodoc AUTHORS BUGS COPYING ChangeLog HACKING \
		NEWS README* TODO
}

