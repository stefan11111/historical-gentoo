# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/gnome-apps/evolution/evolution-0.8.ebuild,v 1.3 2001/04/28 22:21:22 achim Exp $

A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="A GNOME groupware application, a Microsoft Outlook workalike"
SRC_URI="ftp://ftp.gnome.org/pub/GNOME/unstable/sources/${PN}/${A}"
HOMEPAGE="http://www.helixcode.com"

DEPEND=">=gnome-base/gnome-core-1.2.4
	>=gnome-base/libunicode-0.4-r1
	>=gnome-base/gal-0.5
	>=gnome-base/gtkhtml-0.8.3"

src_compile() {

    cd ${S}
    try ./configure --prefix=/opt/gnome --host=${CHOST}
    try make

}

src_install () {

    cd ${S}
    try make DESTDIR=${D} install
    dodoc AUTHORS COPYING ChangeLog HACKING MAINTAINERS
    dodoc NEWS README
}


