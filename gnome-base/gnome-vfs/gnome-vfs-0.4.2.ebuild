# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/gnome-base/gnome-vfs/gnome-vfs-0.4.2.ebuild,v 1.2 2000/11/29 00:10:02 drobbins Exp $

A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="gnome-vfs"
SRC_URI="ftp://ftp.gnome.org/pub/GNOME/unstable/sources/${PN}/${A}"
HOMEPAGE="http://www.gnome.org/"

DEPEND="
>=gnome-base/gconf-0.10 
>=gnome-base/control-center-1.2.2 
>=gnome-base/gnome-libs-1.2.8"

src_unpack() {
  unpack ${A}
}
src_compile() {                           
  cd ${S}
  try ./configure --host=${CHOST} --prefix=/opt/gnome 
  try make
}

src_install() {
  cd ${S}
  try make prefix=${D}/opt/gnome install
  dodoc AUTHORS COPYING* ChangeLog NEWS README
}





