# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/findutils/findutils-4.1.7-r3.ebuild,v 1.11 2004/02/24 08:36:00 mr_bones_ Exp $

IUSE="nls build afs"

inherit eutils

S=${WORKDIR}/${P}

DESCRIPTION="GNU utilities to find files"
SRC_URI="ftp://alpha.gnu.org/gnu/${P}.tar.gz"

HOMEPAGE="http://www.gnu.org/software/findutils/findutils.html"

KEYWORDS="x86 amd64 ~hppa ppc"
SLOT="0"
LICENSE="GPL-2"

DEPEND="virtual/glibc
	nls? ( sys-devel/gettext )
	x86? ( afs? ( net-fs/openafs ) )"
RDEPEND="virtual/glibc"

src_compile() {

	local myconf

	use nls || myconf="${myconf} --disable-nls"

	if use afs
	    then
		export CPPFLAGS=-I/usr/afsws/include
		export LDFLAGS=-lpam
		export LIBS=/usr/afsws/lib/pam_afs.so.1
	fi

	./configure \
		--host=${CHOST} \
		--prefix=/usr \
		--localstatedir=/var/spool/locate \
		${myconf} || die

	emake libexecdir=/usr/lib/find || die
}

src_install() {
	#do not change 'localstatedir=/var/spool/locate' to
	#'localstatedir=${D}/var/spool/locate', as it will then be hardcoded
	#into locate and updatedb
	einstall \
		localstatedir=${D}/var/spool/locate \
		libexecdir=${D}/usr/lib/find \
		|| die

	prepallman

	dosed "s:TMPDIR=/usr/tmp:TMPDIR=/tmp:" usr/bin/updatedb
	rm -rf ${D}/usr/var
	if [ -z "`use build`" ]
	then
		dodoc COPYING NEWS README TODO ChangeLog
	else
		rm -rf ${D}/usr/share
	fi
	keepdir /var/spool/locate
}
