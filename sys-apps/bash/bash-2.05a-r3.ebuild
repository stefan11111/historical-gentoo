# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/sys-apps/bash/bash-2.05a-r3.ebuild,v 1.3 2002/09/14 15:51:24 bjb Exp $

inherit flag-o-matic

S=${WORKDIR}/${P}
DESCRIPTION="The standard GNU Bourne again shell"
SRC_URI="ftp://ftp.gnu.org/gnu/bash/${P}.tar.gz"
HOMEPAGE="http://www.gnu.org/software/bash/bash.html"

KEYWORDS="x86 ppc sparc sparc64 alpha"
SLOT="0"
LICENSE="GPL-2"

DEPEND=">=sys-libs/ncurses-5.2-r2"

RDEPEND="virtual/glibc"

src_unpack() {
	unpack ${A}
	
	cd ${S}
	#enable non-interactive login shells; this patch allows your prompt 
	#to be preserved when you start X and closes bug #1579.
	cat ${FILESDIR}/config-top.h.diff | patch -p0 -l || die
}

src_compile() {

	filter-flags -malign-double

	local myconf=""

	# Always use the buildin readline, else if we update readline
	# bash gets borked as readline is usually not binary compadible
	# between minor versions.
	#
	# Martin Schlemmer <azarah@gentoo.org> (1 Sep 2002)
	#[ "`use readline`" ] && myconf="--with-installed-readline"
	
	[ -z "`use nls`" ] && myconf="${myconf} --disable-nls"
	
	./configure --prefix=/ \
		--mandir=/usr/share/man \
		--infodir=/usr/share/info \
		--host=${CHOST} \
		--disable-profiling \
		--with-curses \
		--without-gnu-malloc \
		${myconf} || die
	# bash 2.0.5 doesn't like -j>1
	
	emake -j1 || die
}

src_install() {
	make prefix=${D}/usr \
		mandir=${D}/usr/share/man \
		infodir=${D}/usr/share/info \
		install || die
		
	dodir /bin
	mv ${D}/usr/bin/bash ${D}/bin
	dosym bash /bin/sh

	if [ -z "`use build`" ]
	then
		doman doc/*.1 doc/*.3
		dodoc README NEWS AUTHORS CHANGES COMPAT COPYING Y2K
		dodoc doc/FAQ doc/INTRO
	else
		rm -rf ${D}/usr
	fi
}

