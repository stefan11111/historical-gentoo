# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/app-text/docbook-dtd/docbook-dtd41-sgml-1.0.ebuild,v 1.1 2000/10/19 15:59:08 achim Exp $

A="docbk41.zip ${P}.catalog.patch ${P}.Makefile"
S=${WORKDIR}/${P}
DESCRIPTION="Docbook DTD"
SRC_URI="ftp://ftp.kde.org/pub/kde/devel/docbook/SOURCES/docbk41.zip
	 ftp.kde.org/pub/kde/devel/docbook/SOURCES/${P}.catalog.patch
	 ftp.kde.org/pub/kde/devel/docbook/SOURCES/${P}.Makefile"

HOMEPAGE="http://www.oasis-open.org/docbook/"


src_unpack() {
  mkdir ${S}
  cd ${S}
  unpack docbk41.zip
  cp ${DISTDIR}/${P}.Makefile Makefile
  patch -b docbook.cat ${DISTDIR}/${P}.catalog.patch
}

src_compile() {

    cd ${S}
}

src_install () {

    cd ${S}
    try make DESTDIR=${D}/usr/share/sgml/docbook/sgml-dtd-4.1 install

}

