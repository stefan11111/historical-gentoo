# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/sys-apps/diffutils/diffutils-2.7.7.ebuild,v 1.3 2002/07/11 06:30:53 drobbins Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Tools to make diffs and compare files"
SRC_URI="ftp://alpha.gnu.org/gnu/diffutils/${P}.tar.gz"
HOMEPAGE="http://www.gnu.org/software/diffutils/diffutils.html"
LICENSE="GPL-2"

DEPEND="virtual/glibc nls? ( sys-devel/gettext )"

if [ -z "`use build`" ]
then
	DEPEND="$DEPEND sys-apps/texinfo"
fi

RDEPEND="virtual/glibc"

src_unpack() {
	unpack ${A}
}

src_compile() {
	local myconf=""
	[ -z "`use nls`" ] && myconf="--disable-nls"
	./configure --build=${CHOST} \
		--prefix=/usr \
		${myconf} || die
		
	if [ "`use build`" ]
	then
		#disable texinfo building so we can remove the dep
		cp Makefile Makefile.orig
		sed -e 's/^all: ${PROGRAMS} info/all: ${PROGRAMS}/g' \
			Makefile.orig > Makefile
	fi
	emake || die

	if [ -z "`use build`" ]
	then
	 	#fix the info page
		cp doc/diff.info doc/diff.info.orig
		sed -e 's/^Diff: (diff)/* Diff: (diff)/' \
			doc/diff.info.orig > doc/diff.info
	fi
}

src_install() {
	make prefix=${D}/usr \
		infodir=${D}/usr/share/info \
		install || die
		
	if [ -z "`use build`" ]
	then
		dodoc COPYING ChangeLog NEWS README
	else
		rm -rf ${D}/usr/share/info
	fi
}


