# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-kernel/vanilla-prepatch-sources/vanilla-prepatch-sources-2.4.24_pre1.ebuild,v 1.2 2003/12/10 17:12:40 iggy Exp $

IUSE="build"

ETYPE="sources"
inherit kernel

# OKV=original kernel version, KV=patched kernel version.  
OKV="2.4.23"
KV="${PV/_/-}"
S=${WORKDIR}/linux-${KV}

EXTRAVERSION="`echo ${KV}|sed -e 's:[^-]*\(-.*$\):\1:'`"
BASE="`echo ${KV}|sed -e s:${EXTRAVERSION}::`"

DESCRIPTION="Full sources for the prerelease vanilla Linux kernel"
SRC_URI="mirror://kernel/linux/kernel/v2.4/linux-${OKV}.tar.bz2
	mirror://kernel/linux/kernel/v2.4/testing/patch-${PV/_/-}.bz2"
HOMEPAGE="http://www.kernel.org/ http://www.gentoo.org/"

KEYWORDS="~x86 ~ppc ~sparc ~alpha ~amd64"
SLOT="${KV}"

# We'll see how not mirroring kernels goes over with the mirrors
restrict="nomirror"

src_unpack() {
	unpack linux-${OKV}.tar.bz2
	mv linux-${OKV} linux-${KV} || die

	cd linux-${KV}

	bzcat ${DISTDIR}/patch-${PV/_/-}.bz2|patch -p1 || die "-marcelo patch failed"

	kernel_universal_unpack
}

pkg_postinst() {
	einfo "Prepatches are the equivalent to alpha releases for Linux."
	einfo "They may be poorly tested, and may not work at all."
	einfo "Prepatches with -rc in the name are release candidates and"
	einfo "may become full versions.  It is particularly important"
	einfo "that these are thoroughly tested and bugs are reported back"
	einfo "upstream (and not to the Gentoo team)."
}
