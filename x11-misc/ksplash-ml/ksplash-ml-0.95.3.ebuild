# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/ksplash-ml/ksplash-ml-0.95.3.ebuild,v 1.6 2004/02/17 23:06:16 agriffis Exp $

inherit kde-base

need-kde 3

S=${WORKDIR}/ksplashml-${PV}
DESCRIPTION="Fancy splash-screen for KDE 3.x"
SRC_URI="http://www.shadowcom.net/Software/ksplash-ml/ksplashml-${PV}.tgz"
HOMEPAGE="http://www.shadowcom.net/Software/ksplash-ml"

newdepend ">=kde-base/kdebase-3.0"

LICENSE="BSD"

KEYWORDS="x86 ~ppc alpha ia64"

src_install() {

	kde_src_install

	dodir /etc/env.d
	echo "KSPLASH=${PREFIX}/bin/ksplash" > ${D}/etc/env.d/90ksplash-ml

}
