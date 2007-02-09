# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-kernel/vserver-sources/vserver-sources-2.0.2.1.ebuild,v 1.3 2007/02/09 14:47:56 chtekk Exp $

ETYPE="sources"
CKV="2.6.17"
K_WANT_GENPATCHES="base extras"
K_GENPATCHES_VER="11"

K_USEPV=1
K_NOSETEXTRAVERSION=1

MY_PN=${PN/-sources/-patches}

inherit kernel-2
detect_version

KEYWORDS="amd64 x86"
IUSE=""

DESCRIPTION="Full sources including Gentoo and Linux-VServer patchsets for the ${KV_MAJOR}.${KV_MINOR} kernel tree."
HOMEPAGE="http://www.gentoo.org/proj/en/vps/"
SRC_URI="${KERNEL_URI} ${GENPATCHES_URI} ${ARCH_URI}
	http://dev.gentoo.org/~hollow/distfiles/${MY_PN}-${CKV}_${PVR}.tar.bz2
	http://dev.gentoo.org/~phreak/distfiles/${MY_PN}-${CKV}_${PVR}.tar.bz2"

UNIPATCH_STRICTORDER=1
UNIPATCH_LIST="${DISTDIR}/${MY_PN}-${CKV}_${PVR}.tar.bz2"
