# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/gnome-apps/bug-buddy/bug-buddy-2.0.1.ebuild,v 1.2 2001/06/04 21:57:52 achim Exp $

A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="bug-buddy"
SRC_URI="ftp://ftp.gnome.org/pub/GNOME/stable/sources/${PN}/${A}"
HOMEPAGE="http://www.gnome.org/"

DEPEND="virtual/glibc nls? ( sys-devel/gettext)
        >=gnome-base/gnome-core"

src_compile() {
  local myconf
  if [ -z "`use nls`" ] ; then
    myconf="--disbale-nls"
  fi
  try ./configure --host=${CHOST} --prefix=/opt/gnome  $myconf
  try make
}

src_install() {
  try make prefix=${D}/opt/gnome install
  dodoc AUTHORS COPYING* NEWS
  dodoc README* TODO
}





