# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lisp/cl-uffi/cl-uffi-1.2.15.ebuild,v 1.3 2004/06/24 23:56:25 agriffis Exp $

inherit common-lisp

DESCRIPTION="UFFI is a package to [portably] interface Common Lisp programs with C-language compatible libraries."
HOMEPAGE="http://uffi.med-info.com/"
SRC_URI="http://files.b9.com/uffi/uffi-${PV}.tar.gz"
LICENSE="LLGPL-2.1"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

S=${WORKDIR}/uffi-${PV}

src_install() {
	dodir /usr/share/common-lisp/systems
	insinto /usr/share/common-lisp/source/uffi
	doins src/*.lisp ${FILESDIR}/uffi.asd
	dosym /usr/share/common-lisp/source/uffi/uffi.asd \
		/usr/share/common-lisp/systems/uffi.asd
#  	insinto /usr/share/common-lisp/source/uffi-tests
#  	doins tests/*.lisp ${FILESDIR}/uffi-tests.asd
#  	dosym /usr/share/common-lisp/source/uffi-tests/uffi-tests.asd \
# 		/usr/share/common-lisp/systems/uffi-tests.asd

	dodoc COPYRIGHT AUTHORS NEWS README TODO ChangeLog doc/uffi.pdf doc/COPYING.GFDL
	tar xfz doc/html.tar.gz -C ${D}/usr/share/doc/${P}/
	for i in examples benchmarks ; do
		insinto /usr/share/doc/${P}/$i
		doins $i/*
	done
}

pkg_postinst() {
	/usr/sbin/register-common-lisp-source uffi
#	/usr/sbin/register-common-lisp-source uffi-tests
}

pkg_prerm() {
	/usr/sbin/unregister-common-lisp-source uffi
#	/usr/sbin/unregister-common-lisp-source uffi-tests
}

