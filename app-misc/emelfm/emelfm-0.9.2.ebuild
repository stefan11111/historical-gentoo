# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/emelfm/emelfm-0.9.2.ebuild,v 1.11 2004/03/14 10:50:19 mr_bones_ Exp $

DESCRIPTION="A file manager that implements the popular two-pane design."
SRC_URI="http://emelfm.sourceforge.net/${P}.tar.gz"
HOMEPAGE="http://emelfm.sourceforge.net/"
IUSE="nls"
SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86"

DEPEND="=x11-libs/gtk+-1.2*"

src_unpack() {
	unpack ${A}
	epatch ${FILESDIR}/po-cs-po-gentoo.patch
	epatch ${FILESDIR}/makefile-nls-gentoo.patch
}

src_compile() {
	local myconf

	if use nls ; then
		make PREFIX=/usr \
			CC="gcc ${CFLAGS}" \
			NLS=-DENABLE_NLS || die
	else
		make PREFIX=/usr \
			CC="gcc ${CFLAGS}" \
			NLS= || die
	fi
}

src_install() {
	dodir /usr/bin

	if use nls ; then
		make PREFIX=${D}/usr \
			NLS=-DENABLE_NLS \
			DOC_DIR=${D}/usr/share/doc/${P} \
			install || die
	else
		make PREFIX=${D}/usr NLS= \
			DOC_DIR=${D}/usr/share/doc/${P} \
			install || die
	fi

	gzip ${D}/usr/share/doc/${P}/*.txt
}
