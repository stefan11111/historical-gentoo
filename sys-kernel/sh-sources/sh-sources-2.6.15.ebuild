# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-kernel/sh-sources/sh-sources-2.6.15.ebuild,v 1.1 2006/03/14 02:57:31 vapier Exp $

ETYPE="sources"
K_WANT_GENPATCHES="base extras"
K_GENPATCHES_VER="10"

inherit kernel-2
detect_version
detect_arch

STAMP=20060313
ARCH_URI="mirror://gentoo/linux-${PV}-sh-${STAMP}.patch.bz2"
UNIPATCH_LIST="${DISTDIR}/linux-${PV}-sh-${STAMP}.patch.bz2"

DESCRIPTION="Full SuperH sources including the gentoo patchset for the ${KV_MAJOR}.${KV_MINOR} kernel tree"
HOMEPAGE="http://dev.gentoo.org/~dsd/genpatches"
SRC_URI="${KERNEL_URI} ${GENPATCHES_URI} ${ARCH_URI}"

KEYWORDS="-* sh"
IUSE=""

pkg_postinst() {
	postinst_sources

	echo
	einfo "For more info on this patchset, and how to report problems, see:"
	einfo "${HOMEPAGE}"
}
