# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/sys-apps/modutils/modutils-2.4.16-r1.ebuild,v 1.2 2002/07/11 06:30:54 drobbins Exp $

S=${WORKDIR}/${P}
SLOT="0"
DESCRIPTION="Standard kernel module utilities"
SRC_URI="http://www.kernel.org/pub/linux/utils/kernel/modutils/v2.4/${P}.tar.bz2"

DEPEND="virtual/glibc
	zlib? ( sys-libs/zlib )"

src_compile() {
	myconf=""
	# see bug #3897 ... we need insmod static, as libz.so is in /usr/lib
	use zlib && myconf="${myconf} --enable-zlib --enable-insmod-static" \
	         || myconf="${myconf} --disable-zlib"

	./configure --prefix=/ \
		--mandir=/usr/share/man \
		--host=${CHOST} \
		--disable-strip \
		${myconf} || die
		
	emake || die
}

src_install() {
	make prefix=${D} \
		mandir=${D}/usr/share/man \
		install || die

	# we want insmod static if using zlib, as libz is in /usr/lib/, so
	# move all the *.static to the normal names
	if [ "`use zlib`" ] ; then
		mv ${D}/sbin/insmod.static ${D}/sbin/insmod
		# rest are symlinks pointing to "/sbin/insmod.static", so
		# nuke them
		rm -f ${D}/sbin/*.static
	fi
		
	dodoc COPYING CREDITS ChangeLog NEWS README TODO
}

