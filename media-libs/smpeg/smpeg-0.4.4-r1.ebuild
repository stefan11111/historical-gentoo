# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/media-libs/smpeg/smpeg-0.4.4-r1.ebuild,v 1.3 2002/07/11 06:30:40 drobbins Exp $

A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="SDL MPEG Player Library"
SRC_URI="ftp://ftp.lokigames.com/pub/open-source/smpeg/${A}"
HOMEPAGE="http://www.lokigames.com/development/smpeg.php3"

DEPEND=">=media-libs/libsdl-1.2.0
	opengl? ( virtual/opengl virtual/glu )
	gtk? ( =x11-libs/gtk+-1.2* )"

src_compile() {

    local myconf
    if [ "`use mmx`" ]
    then
      myconf="--enable-mmx"
    fi
    if [ -z "`use gtk`" ]
    then
      myconf="${myconf} --disable-gtk-player"
    fi
    if [ -z "`use X`" ]
    then
      myconf="${myconf} --disable-gtk-player --without-x"
    fi

    if [ -z "`use opengl`" ]
    then
      myconf="${myconf} --disable-opengl-player"
    fi
    try ./configure --prefix=/usr --mandir=/usr/share/man --host=${CHOST} ${myconf} || die
    try emake || die

}

src_install () {

    try make DESTDIR=${D} install || die

   dodoc CHANGES COPYING README* TODO

}
